#-----------------------BREASTCANCER ANALYSIS CODE TO PREDICT CLASS OF THE DISEASE-------------------------------------------

#--------------------------------------------------------------------------------
#Loading the libraries

library("mlbench")
list.of.packages <- c("dplyr", "qwraps2", "ggplot2", "gridExtra", "car","arm","psych","caTools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
options(qwraps2_markup = "markdown")
library("keras")
library("corrplot")
library("pROC")
library('ggplot2')
library("MASS")
library("caTools")
library("lattice")
library("corrgram")
library("ROCR")
library("ggcorrplot")
library('caret')
library("PerformanceAnalytics")
library("bestglm")
install.packages('pscl')
library('pscl')
library('nclSLR')
library('car')
library('glmnet')
#--------------------------------------------------------------------------------
#LOADING BREASTCANCER DATASET AND PRE-PROCESSING IT
 
data(BreastCancer) #Loading Data

#showing the dimension fo the dataset
dim(BreastCancer)
#type of each column feature
str(BreastCancer)

#Checking Dataset columns are factors or not
is.factor(BreastCancer$Cl.thickness)
is.factor(BreastCancer$Cell.size)
is.factor(BreastCancer$Cell.shape)
is.factor(BreastCancer$Marg.adhesion)
is.factor(BreastCancer$Epith.c.size)
is.factor(BreastCancer$Bare.nuclei)
is.factor(BreastCancer$Bl.cromatin)
is.factor(BreastCancer$Normal.nucleoli)
is.factor(BreastCancer$Mitoses)
is.factor(BreastCancer$Cl.thickness)

#Converting the factors to numeric values
BreastCancer$Cell.size<-as.numeric(BreastCancer$Cell.size)
BreastCancer$Cl.thickness<-as.numeric(BreastCancer$Cl.thickness)
BreastCancer$Cell.shape<-as.numeric(BreastCancer$Cell.shape)
BreastCancer$Marg.adhesion<-as.numeric(BreastCancer$Marg.adhesion)
BreastCancer$Epith.c.size<-as.numeric(BreastCancer$Epith.c.size)
BreastCancer$Bare.nuclei<-as.numeric(BreastCancer$Bare.nuclei)
BreastCancer$Mitoses<-as.numeric(BreastCancer$Mitoses)
BreastCancer$Bl.cromatin<-as.numeric(BreastCancer$Bl.cromatin)
BreastCancer$Normal.nucleoli<-as.numeric(BreastCancer$Normal.nucleoli)
BreastCancer$Class<-(as.numeric(BreastCancer$Class))-1

#Removing Null values
BreastCancerWNA <- na.omit(BreastCancer)

#calculate proportion of benign and malignant class
round(prop.table(table(BreastCancerWNA$Class)), 2) 

#remove the Id columns for further analysis
FinalBCDS = data.frame(BreastCancerWNA[,-1])

## Print first few rows:
head(FinalBCDS)

#--------------------------------------------------------------------------------
#EXPLORATORY DATA ANALYSIS
  
#Plot Scattermatrix for the predictor variable and response variable
pairs(FinalBCDS[,1:9],col=FinalBCDS[,10]+1)

#summary of Final preprocessed BreastCancer Dataset
summary(FinalBCDS)

#Finding COrrelation
corMatMy <- cor(FinalBCDS)

#Plotting the correaltion matrix
corrplot(corMatMy, order = "hclust")
ggcorrplot(cor(FinalBCDS[-1]), type = 'lower', lab = TRUE) +
  ggtitle("Correlation Plot of All Covariates") + 
  theme(plot.title = element_text(hjust = 0.5, size = 22))

#Apply correlation filter at 0.70
highlyCor <- colnames(FinalBCDS[,1:9])[findCorrelation(corMatMy, cutoff = 0.7, verbose = TRUE)]
highlyCor

#--------------------------------------------------------------------------------
#LOGISTIC REGRESSION ON PRE-PROCESSSED BREASTCANCER DATASET
set.seed(99) 
#Splitting our data into 70% training and 30% testing data sets
library(caret)
training <- createDataPartition(FinalBCDS$Class, p=0.7, list=FALSE)
train <- FinalBCDS[ training, ]
test <- FinalBCDS[ -training, ]
table(train$Class)
table(test$Class)

#Logit Model fit using glm function for the train samples
breast_cancer_glm <- glm(Class ~ ., data = train, family = "binomial")
summary(breast_cancer_glm)

test_prob <- predict(breast_cancer_glm, test, type="response")
test_pred <- ifelse(test_prob < 0.5, 0, 1)
test_acc <- mean(test_pred == test$Class)


#plot the logistic fit model for the unregularised data
par(mfrow=c(1,2))
plot(breast_cancer_glm, which=1:2)

#Accuracy of unregularized Data
cat("Testing Accuracy: ", test_acc)

#McFadden R Square-test for evaluating predictive power
pR2(breast_cancer_glm)['McFadden']

#calculate Variance Inflation Factor (VIF) values for each predictor variable in our model
vif(breast_cancer_glm)


#--------------------------------------------------------------------------------
#Extracting predictor variables
set.seed(99)
BC_X1 = FinalBCDS[,1:9]
matbc= data.matrix(BC_X1)
# Extracting response variable
BC_y = as.factor(FinalBCDS[,10])

# Combine to create new data frame
BC_data = data.frame(BC_X1, BC_y)

#Capturing the number of rows and columns of FinalBCDS and storing it in bc_n and bc_p
bc_n = nrow(BC_data); bc_p = ncol(BC_data) - 1

#--------------------------------------------------------------------------------
#BEST SUBSET SELECTION
set.seed(1)  
# Apply best subset selection
bss_fit_AIC = bestglm(FinalBCDS, family=binomial, IC="AIC")
bss_fit_BIC = bestglm(FinalBCDS, family=binomial, IC="BIC")

#Subsets displayed from the results
bss_fit_AIC$Subsets
bss_fit_BIC$Subsets

## Identify best-fitting models
(best_AIC = bss_fit_AIC$ModelReport$Bestk)
(best_BIC = bss_fit_BIC$ModelReport$Bestk)

# Create multi-panel plotting device
par(mfrow=c(1,2))

# Producing plots highlighting optimal value of k
plot(0:bc_p, bss_fit_AIC$Subsets$AIC, xlab="Number of predictors", ylab="AIC", type="b")
points(best_AIC, bss_fit_AIC$Subsets$AIC[best_AIC+1], col="red", pch=16)
plot(0:bc_p, bss_fit_BIC$Subsets$BIC, xlab="Number of predictors", ylab="BIC", type="b")
points(best_BIC, bss_fit_BIC$Subsets$BIC[best_BIC+1], col="red", pch=16)

# Check which predictors are in the 6-predictor model
pstar = 6
bss_fit_AIC$Subsets[pstar+1,]

# Construct a reduced data set containing only the selected predictor
(indices = as.logical(bss_fit_AIC$Subsets[pstar+1, 2:(bc_p+1)]))

BC_data_red = data.frame(BC_X1[,indices], BC_y)
training1 <- createDataPartition(BC_data_red$BC_y, p=0.7, list=FALSE)
train1 <- BC_data_red[ training1, ]
test1 <- BC_data_red[ -training1, ]
table(train1$BC_y)
table(test1$BC_y)
logreg1_fit = glm(BC_y ~ ., data=train1, family="binomial")
summary(logreg1_fit)
test_prob1 <- predict(logreg1_fit, test1, type="response")
test_pred1 <- ifelse(test_prob1 < 0.5, 0, 1)
test_acc1 <- mean(test_pred1 == test1$BC_y)

cat("Test Accuracy: ", test_acc1)
pR2(logreg1_fit)['McFadden']

#--------------------------------------------------------------------------------
# RIDGE REGRESSION
set.seed(99)
grid=10^seq(5,-3,length=100)
#fit ridge regression model
par(mfrow=(c(1,1)))
BC_ridge <- glmnet(train[,1:9], train[,10], alpha = 0,family = "binomial",lambda = grid)
plot(BC_ridge,xvar = "lambda",col=1:9,label = T)


#perform k-fold cross-validation to find optimal lambda value
BC_cv_ridge <- cv.glmnet(as.matrix(train[,1:9]), train[,10], alpha = 0,family = "binomial",lambda = grid)
plot(BC_cv_ridge)

#find optimal lambda value that minimizes test MSE
BCbest_lambda_ridge <- BC_cv_ridge$lambda.min
BCbest_lambda_ridge

coef(BC_ridge,s=BCbest_lambda_ridge)

# Which tuning parameter was the minimum?
(i = which(BC_cv_ridge$lambda == BC_cv_ridge$lambda.min))

# Extract corresponding mean MSE
BC_cv_ridge$cvm[i]

#The lambda value that minimizes the test MSE turns out to be 0.005336699

#find coefficients of best fit model
BCbest_model_ridge <- glmnet(train[,1:9], train[,10], alpha = 0, lambda = BCbest_lambda_ridge, family = "binomial")
coef(BCbest_model_ridge)

#find prediction and accuracy
BC_prediction_tr <- predict(BCbest_model_ridge,newx = as.matrix(test[,1:9]),s = BCbest_lambda_ridge)
BC_predictions <- rep(0, nrow(test))
BC_predictions[BC_prediction_tr >0.5] = 1
#tabulating the confusion matrix
conf_mat <- confusionMatrix(as.factor(BC_predictions), as.factor(test$Class))
conf_mat

#Prediction for the test data for the model 
BC_pred_rr <- prediction(BC_prediction_tr, test$Class)
BC_perf_rr <- performance(BC_pred_rr, measure = "tpr", x.measure = "fpr")

#finding the auc value to estimate the accuracy
BC_auc_rr <- performance(BC_pred_rr, measure = "auc")
BC_auc_rr <- BC_auc_rr@y.values[[1]]
BC_auc_rr

#Plotting the AUC curve
par(mfrow = c(1,1))
plot(BC_perf_rr,colorize=T, main = "Regularized Logit Performance")

auc <- round(BC_auc_rr, 4)
legend(.5, .4, BC_auc_rr, title = "AUC", cex = 1)

#--------------------------------------------------------------------------------
#LINEAR DISCRIMINANT ANALYSIS
set.seed(99)
#Fit LDA model
lda1_fit = lda(Class ~ . , data = train)
#model output
lda1_fit

#prediction over the test data for the model
lda_predict = predict(lda1_fit,test)

lda.class = lda_predict$class
yhat = ifelse(lda_predict$x>0.5,1,0)
#find the err value
err = 1 - mean(test$Class == yhat)
#displaying the confusion matrix for the model over the test data
confusionMatrix(as.factor(lda.class),as.factor(test$Class))
#Calculate the accuracy of the model
mean(lda.class==test$Class)
