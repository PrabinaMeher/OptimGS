# Overview


# Requirements
R 4.0.2 version (The program runs only in the R version 4.0.2, no older or latest version will work)

## R packages
- hibayes 1.0.0 (install only version 1.0.0, no older or latest version will work) #to execute 8 Bayesian models
  - Link to download hibayes 1.0.0 -> https://cran.r-project.org/src/contrib/Archive/hibayes/hibayes_1.0.0.tar.gz
  - After downloading hibayes_1.0.0.tar.gz file, run following command in the R interface to install hibayes 1.0.0
        > install.packages("hibayes_1.0.0.tar.gz")
- xgboost (to execute XGBoost model)
- e1071 (to execute SVM model)
- lightgbm (to execute LightGBM model)
- rrBLUP (to execute rrBLUP and GBLUP model)
- randomForest (to execute random Forest model)
- GA (genetic algorithms for stochastic optimisation)
- magrittr
- Matrix
- MASS

## Models
    bayesA
    bayesB
    bayesC
    bayesBpi
    bayesCpi
    bayesL
    bayesR
    bayesRR
    gblup
    rrblup
    SVM
    LGBM
    RF
    XGB

# Download files
- CFMS.R
- D1_reg_20_21_numeric.txt
- imputed_std_1A_chr_genotype.txt
- imputed_std_1B_chr_genotype.txt
- imputed_std_1D_chr_genotype.txt
- imputed_std_2A_chr_genotype.txt
- imputed_std_2B_chr_genotype.txt
- imputed_std_2D_chr_genotype.txt
- imputed_std_3A_chr_genotype.txt
- imputed_std_3B_chr_genotype.txt
- imputed_std_3D_chr_genotype.txt
- imputed_std_4A_chr_genotype.txt
- imputed_std_4B_chr_genotype.txt
- imputed_std_4D_chr_genotype.txt
- imputed_std_5A_chr_genotype.txt
- imputed_std_5B_chr_genotype.txt
- imputed_std_5D_chr_genotype.txt
- imputed_std_6A_chr_genotype.txt
- imputed_std_6B_chr_genotype.txt
- imputed_std_6D_chr_genotype.txt
- imputed_std_7A_chr_genotype.txt
- imputed_std_7B_chr_genotype.txt
- imputed_std_7D_chr_genotype.txt

# File description
### CFMS.R
R script to run prediction using 14 models independently for each chromosome

### D1_reg_20_21_numeric.txt
Phenotypic file

### Genotypic files containing markers for each of the 20 chromosomes
- imputed_std_1A_chr_genotype.txt
- imputed_std_1B_chr_genotype.txt
- imputed_std_1D_chr_genotype.txt
- imputed_std_2A_chr_genotype.txt
- imputed_std_2B_chr_genotype.txt
- imputed_std_2D_chr_genotype.txt
- imputed_std_3A_chr_genotype.txt
- imputed_std_3B_chr_genotype.txt
- imputed_std_3D_chr_genotype.txt
- imputed_std_4A_chr_genotype.txt
- imputed_std_4B_chr_genotype.txt
- imputed_std_4D_chr_genotype.txt
- imputed_std_5A_chr_genotype.txt
- imputed_std_5B_chr_genotype.txt
- imputed_std_5D_chr_genotype.txt
- imputed_std_6A_chr_genotype.txt
- imputed_std_6B_chr_genotype.txt
- imputed_std_6D_chr_genotype.txt
- imputed_std_7A_chr_genotype.txt
- imputed_std_7B_chr_genotype.txt
- imputed_std_7D_chr_genotype.txt

# Usage 
- Create a working directory.
- Place all the downloaded files in the working directory.
- Now set working directory by executing following command on the R interface.
        > setwd("path/to/your/working/directory")
- Execute the _**CFMS.R**_ script.
        path/to/R-4.0.2/Rscript <script.R>
        
       Example
        C:/PROGRA~1/R/R-4.0.2/bin/Rscript CFMS.R

# Running script using user's files
If user wants to use their own phenotypic and genotypic files. They can make a phenotypic file containing trait values and separate genotypic files containing markers for each chromosome.
Here are few changes they can make in the R script:
    - chr (variable contains chromosome byse genotypic files name identifiers)
        [20] > chr <-c("1A","1B","1D","2A","2B","2D","3A","3B","3D","4A","4B","4D","5A","5B","5D","6A","6B","6D","7A","7B","7D")
  
       - If user is using their own file they can change values for the chromosome's name identifiers.
       For example:
        [20] > chr <-c("1","2","3","4","5") # If name is chromosome_1_genotype.txt, chromosome_2_genotype.txt, chromosome_3_genotype.txt, chromosome_4_genotype.txt, chromosome_5_genotype.txt
          
       OR
          
        [20] > chr <-c("A","B","C","D","E") # If name is chromosome_A_genotype.txt, chromosome_B_genotype.txt, chromosome_C_genotype.txt, chromosome_D_genotype.txt, chromosome_E_genotype.txt
          
    - y (phenotypic file) represents the numeric vector of trait values for n lines/individuals
        [26] > y <- read.table("D1_reg_20_21_numeric.txt", header=TRUE) # user can add their own phenotypic file in place of D1_reg_20_21_numeric.txt
    
    - nexp (number of times the number of experiments need to be repeated). The user can modify how many times the experiments are repeated by replacing the value against _nexp_, the default value is 20.
        [23] > nexp <- 20
          
    - path (genotypic files represents the data frame of n rows and m columns, where n is the number of lines/individuals and m is the number of markers)
        [78] > path <- paste("imputed_std_",chr[i],"_chr_genotype.txt", sep="")
          
       - If user is using their own file they can change the path as follows:
        [78] > path <- paste("chromosome_",chr[i],"_genotype.txt", sep="") # If name is chromosome_1_genotype.txt or chromosome_A_genotype.txt
        
       - Now save and execute the _**CFMS.R**_ script.

# Output description
There are four steps in the script, and each step generates output files which will be used in the next step correspondingly. The output files are as follows:
### 1_pred_BayesA_result.txt
First iteration will be generated for each chromosome. Each file’s first column lists the observed values and rest 20 columns represent predicted values for each chromosome. The second column displays the PCC values along with their standard errors, while the third column presents the MSE values and their respective standard errors.

