from pathlib import Path
import numpy as np
import pandas as pd
from pybdm import BDM

# Paths and globals
HERE = Path(__file__).absolute().parent
ROOT = HERE.parent
DATA = ROOT / "data"

# BDM class
bdm = BDM(ndim=1)
bdm_short = BDM(ndim=1, shape=(8,))

# Window BDM function
def window_bdm(seq, bdm, k=8, normalized=True):
    return np.array([ bdm.bdm(seq[i:(i+k)], normalized=normalized) for i in range(len(seq) - k) ])

# Read and prepare data
data = pd.read_csv(DATA / 'Study_1.csv', sep=';', index_col=False) \
    .rename(columns={ 'X': 'idx' })

data, seq = data.iloc[:, :8], data.iloc[:, 8:].iloc[:, :313].values.tolist()

seq = [ np.array(x)[~np.isnan(x)].astype(int) for x in seq ]

data['cmx'] = [ bdm.nbdm(x) for x in seq ]
data['cmx_w'] = [ ';'.join(window_bdm(x, bdm=bdm_short, k=8).astype(str)) for x in seq ]
data['cmx_r'] = [ ';'.join(window_bdm(x, bdm=bdm_short, k=8, normalized=False).astype(str)) for x in seq ]

data.to_csv(DATA / 'proc' / 'study1.tsv', sep='\t', index=False)
