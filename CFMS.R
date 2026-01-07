
setwd("/Users/assiyaafroz/Desktop/optimization/source_code/D1")

##########################################STEP-I####################
#Prediction using 14 models independently for each chromosome###############
library(hibayes) #to execute 8 Bayesian models
library(xgboost) #to execute XGBoost model
library(e1071) #to execute SVM model
library(lightgbm)# to execute LightGBM model
library(rrBLUP) #to execute rrBLUP and GBLUP model
library(magrittr)
library(Matrix)
library(MASS)
library(randomForest) #to execute random Forest model

library(GA)

model <- c("BayesCpi", "BayesA", "BayesL", "BayesR", "BayesB", "BayesC", "BayesBpi", "BayesRR","gblup","rrblup","rf","xgb","svm","lgbm") 

chr <-c("1A","1B","1D","2A","2B","2D","3A","3B","3D","4A","4B","4D","5A","5B",
"5D","6A","6B","6D","7A","7B","7D")

nexp <- 20 #number of times experiments to be repeated
#read the phenotypic data file
#reading phenotypic dataset with header
y <- read.table("D1_reg_20_21_numeric.txt", header=TRUE)
# reading the first column of the data which is one of the trait and normalization
y1 <- as.numeric(scale(y[,1]))
nl <- length(y1) #number of lines
tst <- floor(nl/5)
nchr <- length(chr) #number of chromosomes 
##For Bayesian

for(j in 1:nexp){

res_bayesA <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesB <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesC <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesBpi <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesCpi <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesL <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesR <- matrix(0, nrow=tst, ncol=nchr+1)
res_bayesRR <- matrix(0, nrow=tst, ncol=nchr+1)
res_gblup <- matrix(0, nrow=tst, ncol=nchr+1)
res_rrblup <- matrix(0, nrow=tst, ncol=nchr+1)
res_svm <- matrix(0, nrow=tst, ncol=nchr+1)
res_lgbm <- matrix(0, nrow=tst, ncol=nchr+1)
res_rf <- matrix(0, nrow=tst, ncol=nchr+1)
res_xgb <- matrix(0, nrow=tst, ncol=nchr+1)

sam <- sample(nl) 

y2 <- y1[sam]
yr <- y2
tr.y <- yr[-c(1:tst)]
Ytrain <- tr.y
y3 <- y2[1:tst]
ts.y <- y3
Ytest <- y3
y2[1:tst]<-NA

res_bayesA[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesB[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesC[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesBpi[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesCpi[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesL[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesR[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_bayesRR[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_gblup[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_rrblup[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_svm[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_lgbm[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_rf[,1] <- as.matrix(y3, nrow=tst, ncol=1)
res_xgb[,1] <- as.matrix(y3, nrow=tst, ncol=1)

for(i in 1:nchr){
<<<<<<< HEAD
path <- paste(chr[i],"_chr_genotype.txt", sep="")
=======
path <- paste(chr[i],"_chr_genotype.txt", sep="")
>>>>>>> 01041ee (Files add)

x <- read.table(path)
x1 <- x[sam,] 

#############

fit <- bayes(y=y2, M=x1, model = "BayesA", lambda=0.0001)
res_bayesA[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

####################

fit <- bayes(y=y2, M=x1, model = "BayesB", lambda=0.0001)
res_bayesB[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

###########

fit <- bayes(y=y2, M=x1, model = "BayesC", lambda=0.0001)
res_bayesC[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

###############

fit <- bayes(y=y2, M=x1, model = "BayesBpi", lambda=0.0001)
res_bayesBpi[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

##############

fit <- bayes(y=y2, M=x1, model = "BayesCpi", lambda=0.0001)
res_bayesCpi[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

##########

fit <- bayes(y=y2, M=x1, model = "BayesL", lambda=0.0001)
res_bayesL[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

################

fit <- bayes(y=y2, M=x1, model = "BayesR", lambda=0.0001)
res_bayesR[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

############

fit <- bayes(y=y2, M=x1, model = "BayesRR", lambda=0.0001)
res_bayesRR[,i+1] <- as.matrix(round(fit$g[1:850],4), ncol=1)

#####################gblup

tr.x <- x1[-c(1:tst),]
ts.x <- x1[c(1:tst),]

G3 <- A.mat(as.matrix(tr.x))  
zz <- mixed.solve(y=tr.y, K=G3, method="REML")#for gblup
g_est <- zz$u
u_est <- ginv(as.matrix(tr.x))%*%as.matrix(g_est,ncol=1)#for gblup
res_gblup[,i+1] <- as.matrix(round(as.matrix(ts.x)%*%u_est,4), ncol=1)# for gblup
########################rrblup

G4 <- as.matrix(tr.x) #for rrBLUP
zz <- mixed.solve(y=tr.y, Z=G4, method="REML")#forrrBLUP
g_est <- zz$u
res_rrblup[,i+1] <- as.matrix(round(as.matrix(ts.x)%*%as.matrix(g_est,ncol=1) ,4), ncol=1)#for rrBLUP

###############svm

Xtrain     <- tr.x
Xtest      <- ts.x

svm_model <- svm(x = Xtrain, y = Ytrain, type = "eps-regression", kernel = "radial")
res_svm[,i+1] <- as.matrix(round(predict(svm_model, newdata = Xtest),4), ncol=1)

#######################lgbm

dtrain <- lgb.Dataset(data = as.matrix(Xtrain), label = Ytrain)
dtest <- as.matrix(Xtest) 

params <- list(
  objective = "regression",
  metric = "rmse",
  boosting = "gbdt",
  learning_rate = 0.3,
  num_leaves = 31,
  max_depth = 20
  )

lgb_model <- lgb.train(
  params = params,
  data = dtrain,
  nrounds = 100,
  verbose = 0
)

res_lgbm[,i+1] <- as.matrix(round(predict(lgb_model, dtest),4), ncol=1)

#####################rf

qrf <- randomForest(x=Xtrain, y=Ytrain, ntree=500)
res_rf[,i+1] <- as.matrix(round(predict(qrf,  Xtest, what=mean),4), ncol=1)

########################xgb

dtrain <- xgb.DMatrix(data = as.matrix(Xtrain), label = Ytrain)
dtest <- xgb.DMatrix(data = as.matrix(Xtest))

xgb_model <- xgboost(
  data = dtrain,
  objective = "reg:squarederror",  # regression with squared loss
  nrounds = 100,                   # number of boosting rounds
  eta = 0.3,                        # learning rate
  max_depth = 20,                    # tree depth
  verbose = 0                       # silent output
)

res_xgb[,i+1] <- as.matrix(round(predict(xgb_model, dtest), 4), ncol=1)
}

path1 <- paste(j,"_","pred_BayesA_result.txt", sep="")
write.table(res_bayesA, path1, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path2 <- paste(j,"_","pred_BayesB_result.txt", sep="")
write.table(res_bayesB, path2, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path3 <- paste(j,"_","pred_BayesC_result.txt", sep="")
write.table(res_bayesC, path3, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path4 <- paste(j,"_","pred_BayesBpi_result.txt", sep="")
write.table(res_bayesBpi, path4, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path5 <- paste(j,"_","pred_BayesCpi_result.txt", sep="")
write.table(res_bayesCpi, path5, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path6 <- paste(j,"_","pred_BayesL_result.txt", sep="")
write.table(res_bayesL, path6, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path7 <- paste(j,"_","pred_BayesR_result.txt", sep="")
write.table(res_bayesR, path7, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path8 <- paste(j,"_","pred_BayesRR_result.txt", sep="")
write.table(res_bayesRR, path8, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path9 <- paste(j,"_","pred_gblup_result.txt", sep="")
write.table(res_gblup, path9, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path10 <- paste(j,"_","pred_rrblup_result.txt", sep="")
write.table(res_rrblup, path10, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path11 <- paste(j,"_","pred_svm_result.txt", sep="")
write.table(res_svm, path11, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path12 <- paste(j,"_","pred_lgbm_result.txt", sep="")
write.table(res_lgbm, path12, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path13 <- paste(j,"_","pred_rf_result.txt", sep="")
write.table(res_rf, path13, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)

path14 <- paste(j,"_","pred_xgb_result.txt", sep="")
write.table(res_xgb, path14, sep="\t", col.names=c("Öbserved",chr), row.names=FALSE, quote=FALSE)
}
     

############################STEP-II##################

#############DETERMINATION OF WEIGHT FOR EACH CHROMOSOME########################

#The weight was assigned to the predited phenotypic values for each chromosome for a given prediction model.
##The weights were assigned in such a way that the correlation between the observed phenotypic values 
####and the weighted linear combination of the predicted phenotypic values is maximized.
##This was repeated for repeatation of each of the prediction model.

wt_chr <- matrix(0, nrow=21, ncol=nexp) #wn-mse to wt_chr row represent the number of chromosome and column is the number of iteration
rownames(wt_chr) <- chr

for(k in 1:14){ #for 14 models

for (i in 1:nexp){ #for number of iterations
path <- paste(i,"_pred_",model[k],"_result.txt", sep="")# Contains predicted phenotypic values for each model for all the 21 chromosomes 
zz <- read.table(path, header=TRUE)
###optimised weight based on genetic algorithm
Actual=zz[,1]
A1=zz[,2]
B1=zz[,3]
D1=zz[,4]
A2=zz[,5]
B2=zz[,6]
D2=zz[,7]
A3=zz[,8]
B3=zz[,9]
D3=zz[,10]
A4=zz[,11]
B4= zz[,12]
D4= zz[,13]
A5= zz[,14]
B5= zz[,15]
D5=zz[,16]
A6=zz[,17]
B6= zz[,18]
D6= zz[,19]
A7= zz[,20]
B7= zz[,21]
D7= zz[,22]
f<- function(x)
{
g <- cor(Actual,(x[1]*A1+x[2]*B1+x[3]*D1+x[4]*A2+x[5]*B2+x[6]*D2+x[7]*A3+x[8]*B3+x[9]*D3+x[10]*A4+x[11]*B4+x[12]*D4+x[13]*A5+x[14]*B5+x[15]*D5+x[16]*A6+x[17]*B6+x[18]*D6+x[19]*A7+x[20]*B7++x[21]*D7))
   h<-x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]+x[9]+x[10]+x[11]+x[12]+x[13]+x[14]+x[15]+x[16]+x[17]+x[18]+x[19]+x[20]+x[21]
  k<-ifelse(h==1,g,g)
}
GA <- ga(type = "real-valued",
         fitness =f,
         lower = rep(0,21), upper = rep(1,21),
         popSize = 300, maxiter = 1000, pmutation=0.1, pcrossover=0.2)


ww_pcc <- as.numeric(attr(GA, "solution")[1,])
wt_chr[,i] <- as.matrix(ww_pcc/sum(ww_pcc), nrow=21, ncol=1) #change wn[,i] 


}
wt_chr <- wt_chr
wt_ph <-  matrix(0, nrow=nrow(zz), ncol=20)


for(j in 1:nexp){
path <- paste(j,"_pred_",model[k],"_result.txt", sep="")
zz <- read.table(path, header=TRUE)
mm <- as.matrix(zz)

wt_ph[,j] <- mm[,-1]%*%as.matrix(wt_chr[,j], ncol=1) #weighted phenotypic values by combining all chromosomal prediction for each model over number of iteration

} 
path2 <- paste("chr_weighted_phenotype_",model[k],"_iteration.txt", sep="")##the nexp column of each model represents the number of iteration
write.table(wt_ph,path2, row.names=FALSE, quote=FALSE, col.names=FALSE, sep="\t") 


}


########################################STEP-III########################

#################MAKING ONE FILE FOR EACH ITERATION WICH CONTAIN THE WEIGHTED PREDICTED PHENOTYPIC 
####VALUES FOR 14 GENOMIC PREDICTION MODELS AS WELL AS THE OBSERVED PHENOTYPIC VALUES FOR THE CORRESPONDING ITERATION WHICH IS SAME FOR ALL THE MODELS FOR A GIVEN ITERATION###########

for(j in 1:nexp){
path <- paste(j,"_pred_BayesA_result.txt", sep="")
zz1 <- read.table(path, header=TRUE)
wt_ph1 <- matrix(0, nrow=nrow(zz1), ncol=15) #The first column is observed phenotype and rest 14 columns are weithed predicted phenotype
wt_ph1[,1] <- zz1[,1]

for(k in 1:14){

path2 <- paste("chr_weighted_phenotype_",model[k],"_iteration.txt", sep="")
zz2 <- read.table(path2)
wt_ph1[,k+1] <- zz2[,j]

}
colnames(wt_ph1) <- c("observed",model)
path3 <- paste(j,"_iteration_chr_weighted_phenotype_model.txt", sep="")
write.table(wt_ph1,path3, row.names=FALSE, quote=FALSE, sep="\t")  

}
############################STEP-IV###############

######################ENSEMBLE OF MODEL FOR EACH ITERATION###############
#####The final predicted phenotypic values for each iteration was obtained by combining the weight 
####predicted phenotypic values of all the 14 models where the optimum weight for each model was 
#####determined using genetic algorithm

wt_model <- matrix(0, nrow=14, ncol=nexp)
rownames(wt_model) <- model

for (i in 1:nexp){
path <- paste(i,"_iteration_chr_weighted_phenotype_model.txt", sep="")
zz <- read.table(path, header=TRUE)

Actual=zz[,1]
BCPi=zz[,2]
BA=zz[,3]
BL=zz[,4]
BR=zz[,5]
BB=zz[,6]
BC=zz[,7]
BBPi=zz[,8]
BRR=zz[,9]
GBL=zz[,10]
RRB=zz[,11]
RF= zz[,12]
XGB= zz[,13]
SVM= zz[,14]
LGB= zz[,15]

f<- function(x)
{
g <- cor(Actual,(x[1]*BCPi+x[2]*BA+x[3]*BL+x[4]*BR+x[5]*BB+x[6]*BC+x[7]*BBPi+x[8]*BRR+x[9]*GBL+x[10]*RRB+x[11]*RF+x[12]*XGB+x[13]*SVM+x[14]*LGB))
   h<-x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]+x[9]+x[10]+x[11]+x[12]+x[13]+x[14]
  k<-ifelse(h==1,g,g)
}
GA <- ga(type = "real-valued",
         fitness =f,
         lower = rep(0,14), upper = rep(1,14),
         popSize = 300, maxiter = 1000, pmutation=0.1, pcrossover=0.2)


ww_m <- as.numeric(attr(GA, "solution")[1,])
wt_model[,i] <- as.matrix(ww_m/sum(ww_m), nrow=14, ncol=1) #change wn[,i] 


}

wt_model <- wt_model

pred_ph <- matrix(0, nrow=nrow(zz), ncol=nexp)
obs_ph <- matrix(0, nrow=nrow(zz), ncol=nexp)
colnames(obs_ph) <- colnames(pred_ph) <- paste("iteration_", seq(nexp))

for(j in 1:nexp){
path <- paste(j,"_iteration_chr_weighted_phenotype_model.txt", sep="")
zz <- read.table(path, header=TRUE)
mm <- as.matrix(zz)
obs_ph[,j] <- as.matrix(mm[,1], ncol=1) #observed phenotypic trait values for nexp iterations in the columns
pred_ph[,j] <- as.matrix(mm[,-1]%*%as.matrix(wt_model[,j], ncol=1), ncol=1) #predicted phenotypic values ensembled over models with nexp iterations in columns
} 
write.table(obs_ph,"final_observed_ph_iteration.txt", row.names=FALSE,  sep="\t", quote=FALSE)
write.table(pred_ph,"final_pred_ph_iteration.txt", row.names=FALSE,  sep="\t", quote=FALSE)

#By computing the Pearson's correlation coefficient and mean square error 
##between the respecpective columns of the obs_ph and pred_ph file 
##one can obtain the genomic prediction accuracy for nexp number of iteratiins
##and the final accuracy cab obtained by taking average over the iterations. 
##This end the CFMS model for genomic prediction###############
########CFMS completed here#########################





