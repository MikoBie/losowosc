#######################################################################################
#######################################################################################
####################################### HELEPRS #######################################
#######################################################################################
#######################################################################################


permutaion_test <- function(data = data,R = 100000,group_var = 'Faculty'){
  
  ## This function computes a naive permuation test.
  ## It takes as parameters:
      ## data - a data frame with at leas two columns: 
          ## grouping variable with only two possible values,
          ## cmx - column with numeric values.
      ## R - an integer. It denotes the number of iterations. The defualt is 100,000.
      ## group_var - a string with the name of the column from data which will serve as 
          ## grouping variable.
  ## The function returns a data frame with two columns:
      ## diff_mean - a series with R number of differences in mean,
      ## diff_sd - a series with R number of difference in standard deviation.
  
  results_mean <- vector(mode = 'numeric', length = R)
  results_sd <- vector(mode = 'numeric', length = R)
  
  group_n <- data %>%
    group_by_at(group_var) %>%
    summarise(n = n()) %$%
    {n[1]}
  
  total_n <- data %>%
    nrow
  
  set.seed(8710)
  
  for(i in c(1:R)){
    index <- sample(total_n, group_n, replace = FALSE)
    results_mean[i] <- mean(data$cmx[index]) - mean(data$cmx[-index])
    results_sd[i] <-  sd(data$cmx[-index]) - sd(data$cmx[index])
  }
  results <- tibble(diff_means = results_mean,
                    diff_sd = results_sd)
  return(results)
}


p_value <- function(observed_difference, distribution){
  
  ## This function computes p value for the permuation test computed with
  ## the use of permuation test function.
  ## It takes as parameters:
    ## observed_difference - a data frame with two columns:
        ## mean - observed difference in means,
        ## sd - observed difference in standard deviations.
    ## distribution - a data frame, which is a result of permutaion_test function.
  ## The function returns a data frame with two columns:
      ## mean_p - proportion of mean differences greater than observed difference in means
        ## to all mean differences simulated with permutation_test function,
      ## sd_p - proportion of sd differences greater than observed difference in sd
        ## to all sd differences simulated with permutation_test function.
  
  nperm <- nrow(distribution)
  mean_diff <- observed_difference$mean[1] - observed_difference$mean[2]
  sd_diff <- observed_difference$sd[2] - observed_difference$sd[1]
  mean_p <- (sum(distribution$diff_means >= mean_diff) +1) / (nperm +1)
  sd_p <- (sum(distribution$diff_sd >= (mean_diff)) +1) / (nperm +1)
  results <- tibble(mean = mean_p, sd = sd_p)
  return(results)
}


d_cohen <- function(model){
  
  ## This function computes Cohen's d for linear mixed models computed
  ## with nlme package. It follows Westfall, Kenny, and Judd, (2014) algorithm. 
  ## It takes as arguments:
    ## model - object lme model.
  ## The function returns a data frame with Cohen's d for all fixed effects.
  
  
  eff = bind_cols(variables = summary(model)$tTable %>% rownames,
                  estimates = summary(model)$coefficients$fixed) %>%
    mutate(var = VarCorr(model)[,1] %>% as.numeric() %>% sum(),
           d = (estimates)/sqrt(var))
  return(eff)
}
  
## Westfall, J., Kenny, D. A. and Judd, C. M. (2014). Statistical power and optimal design in experiments in which samples of participants respond to samples of stimuli. Journal of Experimental Psychology: General 143(5): 2020–2045, DOI: https://doi.org/10.1037/xge0000014 
