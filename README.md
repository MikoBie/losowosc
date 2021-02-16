# `The effect of context and individual differences in human-generated series`

This is a repository for the article in which we investigated the randomness of human-generated series. Unlike the majority of the research on the topic, we focused on the effect of context on the human-generated randomness and individual difference in producing responses at random. In two studies we tested four hypotheses using modern and objective methods for quantifying randomness grounded in the Algorithmic Information Theory and based on the notion of algorithmic (Kolmogorov) complexity. In the repository, you will find data sets (raw and processed) and all scripts for data processing, analysis, and plotting the charts.

## The structure of the repository

The repository is organized as follows:

* [data](data) - it consists of two files in `csv` format with raw data for Study 1 and Study 2, and one folder with processed data for both studies. In the latter, you will find two files for Study 1 (`Study1.csv` and `Study1_seq8.csv`) and one for Study 2 -- `Study2.csv`. 
* [codebooks](codebooks) - it consists codebooks for all data in `txt` format. However, they are aggregated by the study. It means that for example codebook for Study 1 consists of variables description for both, raw and processed, data.  
* [notebooks](notebooks) -  this folder is named after `R` notebooks because we performed all the statistical analysis using `R` programming language. It consists of three files: `Main.Rmd`, `Process_raw_data.Rmd`, and `Supplementary_Materials.Rmd`. Each script is written in `R` programming language, however, `Process_raw_data.Rmd` and `Supplementary_Materials.Rmd` require also having `python3` virtual environment created (see Setup to learn how to do it).
* [png](png) - it contains all pictures used in the article in the png format.

## Data structure

All raw data files are in so-called wide format where a participant is a record. The processed data sets are in either long or wide format. It depends on the type of performed analysis, i.e. `Study1.csv` is in wide format, therefore, a participant is a record; `Study1_seq8.csv` is in long format with the measurement as a record; and `Study2.csv` is in long format with the measurement as a record.

## Main Dependencies

To rerun the analysis from the article it is enough to use only `R` programming language. `Main.Rmd` is written in plain `RMarkdown` and processed data sets are already available in the repository with no need to first run `Process_raw_data.Rmd`. Therefore, the main dependencies are as follows:

* R >= 4.0.2 ([R-project](https://www.r-project.org)), however, it should work fine also with earlier versions of R;
* R packages are specified in the scripts and will install if needed, however, it is best to update them if they are not in their latest stable versions;
* RStudio >= 1.2.5019 ([RStudio](https://rstudio.com)).

However, to run `Process_raw_data.Rmd` and `Supplementary_Materials.Rmd` it is necessary to use `python3` in `R`. Therefore, we advise to also have installed:

* Anaconda distribution of python3.7 ([Anaconda](https://www.anaconda.com))
* python modules specified in `requirenments.txt`


## Setup

Regardless of whether you want to perform only analysis from `Main.Rmd` or you would also like to run the code from `Process_raw_data.Rmd` and `Supplementary_Materials.Rmd` we recommend creating a new `R` project with the repository. It would make your life much easier and after that, you can run `Main.Rmd` without further delays. If you want to also execute the code from `Process_raw_data.Rmd` and `Supplementary_Materials.Rmd` please do as follows:

1. Install Anaconda distribution of python3.7 ([Anaconda](https://www.anaconda.com)). It is available for computers with Mac OS, Linux, and Windows for free.
2. Create a new virtual environment called `bdm`. You should execute in the Anaconda console (or Terminal) the following command:
    ```bash
    conda create -n bdm python=3.7
    ```
    Afterward, the prompt will ask about the installation of packages to which you should agree by pressing `Y` and enter (return on Macs) afterward. Setting the environment might take a few minutes.
3. Activate the newly created environment by typing in Anaconda console (or Terminal):
    ```bash
    conda activate bdm
    ``` 
4. Install required modules from `requirenments.txt`. Navigate in Anaconda console (or Terminal) to the folder with `requirenments.txt` and type: 
    ```bash
    pip install -r requirenments.txt
    ```
5. Open `RStudio` by double-clicking on `.Rproj` file in the repository folder.

That's it. Now you should be able to run `python3.7` in `R`. Note that every time you want to execute one of the scripts in the repository that require the usage of `python` you will have to activate the `bdm` virtual environment before opening `RStudio` (vide step 3).

