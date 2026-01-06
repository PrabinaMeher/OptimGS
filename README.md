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

### Genotypic files containing markers for each of the 21 chromosomes
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
- Execute the _**CFMS.R**_ script

        path/to/R-4.0.2/Rscript <script.R>
        
  Example
  
        C:/PROGRA~1/R/R-4.0.2/bin/Rscript CFMS.R
  
# Executing the script using user-provided files
Users can also execute the script using their own files. To do this, they must place their phenotypic and genotypic files in the working directory. The genotypic data should be provided as separate files, each containing marker information for an individual chromosome.

**NOTE:** User must impute values in a genotypic file to infer missing genotypes (SNPs) in their dataset.

Here are few changes they can make in the R script:
- chr (variable stores identifiers for genotypic file name for each chromosome)

        [20] > chr <-c("1A","1B","1D","2A","2B","2D","3A","3B","3D","4A","4B","4D","5A","5B","5D","6A","6B","6D","7A","7B","7D")
  
   - If the user is using their own genotypic file, they can either rename it to match the provided file names or proceed by following the steps below.
  
     For example:
  
         [20] > chr <-c("1","2","3","4","5") # If name is chromosome_1_genotype.txt, chromosome_2_genotype.txt, chromosome_3_genotype.txt, chromosome_4_genotype.txt, chromosome_5_genotype.txt
          
     OR
          
         [20] > chr <-c("A","B","C","D","E") # If name is chromosome_A_genotype.txt, chromosome_B_genotype.txt, chromosome_C_genotype.txt, chromosome_D_genotype.txt, chromosome_E_genotype.txt
          
- y (phenotypic file) represents the numeric vector of trait values for n lines/individuals

        [26] > y <- read.table("D1_reg_20_21_numeric.txt", header=TRUE) # user can add their own phenotypic file in place of D1_reg_20_21_numeric.txt
    
- nexp (number of times the experiments need to be repeated). The user can modify how many times the experiments are repeated by replacing the value against _nexp_, the default value is 20.
 
        [23] > nexp <- 20
          
- path (variable contain path for genotypic files)

        [78] > path <- paste("imputed_std_",chr[i],"_chr_genotype.txt", sep="")
   -  User can change the path as follows:

           [78] > path <- paste("chromosome_",chr[i],"_genotype.txt", sep="") # If name is chromosome_1_genotype.txt or chromosome_A_genotype.txt
        
- Now save and execute the _**CFMS.R**_ script.

# Output description
The script consists of four steps. Each step produces output files that are used as inputs for the corresponding subsequent step.
### Step I
In the first step, 20 iterations (_nexp_) are generated for each of the 14 models. This results in a total of 280 files. In each file, the first column contains the observed values, while the remaining 21 columns represent the predicted values for each chromosome. For example table below shows the observed and predicted values for each chromosome for a single iteration and a model.
|observed|1A|1B|1D|2A|2B|2D|3A|3B|3D|4A|4B|4D|5A|5B|5D|6A|6B|6D|7A|7B|7D|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|0.155517104602023|0.162396675210736|0.160386145998778|0.191315258500127|0.258499672768336|0.288096849473802|0.257089954576361|0.272394645258858|0.173515045978323|0.297996643044949|0.0134002220580925|0.122920271469284|0.218790707989406|0.181541179641292|0.0800374678755906|0.152688176621581|0.283626960727921|-0.000313155045115465|0.0534153688069817|0.219863072530596|0.0720656298737513|-0.104806717355989|
|0.155517104602023|0.241984384231317|0.0261374874877208|0.138058560865701|0.219964135418048|0.190292232960879|0.255060021669742|0.164616657734068|0.173069285035167|0.250332006256634|0.0167578485357712|0.180985951709752|0.112919071478468|0.184486436205154|0.182097769347044|0.0983055368721676|0.29163228838498|0.0357676178860765|0.140102719739309|0.333200773087979|0.110358027399231|-0.178741903012493|
|1.235033397|0.358091254086921|0.228161486734579|0.289936726075328|0.172886497073048|0.272931855662995|0.305276840367842|0.258685443637155|0.211783069445742|0.299903679125678|0.097616555572882|0.186574079990298|0.0364651619099811|0.246194363814008|0.186106267212897|0.108630258149869|0.192564629362069|-0.0363524170751556|0.0958516263548776|0.117802233016604|0.0593385455238328|-0.00764512257525961|
|0.155517104602023|0.323286159126824|0.16934148051842|0.193710994464954|-0.0720555310125469|0.14896144596482|0.153773079511267|0.229123635003441|0.178819259283488|0.233002937282297|0.00172909577667508|0.101952839460856|0.041024454361542|0.0680755791309632|0.15786065607628|-0.013892675331955|0.213131763566052|0.0661759693730492|0.251600194070809|0.16788815599906|0.0903316115560668|0.031849361147589|

### Step II
In the second step all the predicted values for each chromosomes are combined into a single column for each model and a table is created as follows


### Step III
|observed|BayesCpi|BayesA|BayesL|BayesR|BayesB|BayesC|BayesBpi|BayesRR|gblup|rrblup|rf|xgb|svm|lgbm|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|0.155517104602023|0.1897665792317|0.100687965705974|0.160568028679981|0.161634956001077|0.103769605893534|0.171052056581153|0.120145377853713|0.120744260604229|0.195861733063588|0.139709093818644|0.181172204050498|0.158149710610513|0.434519317969138|0.461126261160716|
|0.155517104602023|0.0971626667100704|-0.0309659236803847|0.0523072142552085|0.0548821218920502|-0.0151810020680457|0.0888770807303007|0.0391096331706689|0.00598407475951763|0.0859914576386341|0.0276395096294818|0.431439485446347|0.650405284844075|0.573651435490874|0.614810760556217|
|1.235033397|0.20535342796524|0.0312858102969223|0.169771515548292|0.167908065807069|0.121616209897218|0.202535801747726|0.162666517676677|0.109351880457816|0.199778322120153|0.142355602977235|0.192814943382263|0.358705387139966|0.156341149063464|0.14548841152334|
|0.155517104602023|0.178071741338455|0.039096769817626|0.149227350359213|0.146984276691963|0.0991186516566065|0.176536985539715|0.130651717661322|0.08900304487657|0.17623023635644|0.117662371580922|0.203564759996764|-0.0269077449053597|0.183839868220156|0.15397070821182|
