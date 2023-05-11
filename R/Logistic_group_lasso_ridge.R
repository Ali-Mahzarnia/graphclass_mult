# Fits a logistic group lasso and returns list with optimal value and information
logistic_group_lasso_ridge <- function(X,Y, D, lambda1, lambda2, gamma,
                                 jobID = "NULL",verbose = F,
                                 beta_start, b_start, 
                                 NODES, MAX_ITER, 
                                 CONV_CRIT = 1e-06, MAX_TIME = Inf, folds= 5 , lambda_selection=TRUE, alpha = 0, minlambda=0.1) {
  
  
 require(msgl) 
nnminus1 = dim(X)[2]
p = 0.5 + sqrt(1+8*nnminus1)/2
pminus = p-1


index = NA
for (i in 1:pminus) {
  temp =rep(i,i)
  index = c(index, temp)
    
}
  
  
index= index[2:length(index)]

  
 optimal = list()
 
  
  
#if  (lambda_selection==TRUE) {   
 fit.cv =  msgl::cv(X, as.factor(Y), fold = folds, use_parallel = F, grouping =index, alpha = alpha, lambda =minlambda)
 fit = msgl::fit(X, as.factor(Y), alpha = alpha , grouping =index , lambda = minlambda)  
#}
  
# if  (lambda_selection==FALSE) { 
   
# fit.cv =  msgl::cv(X, as.factor(Y), fold = folds, use_parallel = F, grouping =index, alpha = alpha, lambda =c(lambda1))

# fit = msgl::fit(X, as.factor(Y), alpha = alpha , grouping =index , lambda = c(lambda1))     
 
# }
  
  


  
  
  
  
  
  

optimal$fit =fit
optimal$cv = fit.cv  
  return(optimal)
}
