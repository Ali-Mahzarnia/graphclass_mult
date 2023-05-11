
Introduction:

This repository contains a modified version of the R package graphclass. The new version incorporates additional features such as the ability to include a multi-category y variable as an outcome, and control for the number of folds by assigning folds = x. It also allows users to pre-choose the lambda or let the system choose it (lambda_selection = TRUE or FALSE). 
Installation:

To install the package, follow the steps below:

Open R or RStudio.

Make sure that the dependency packages, such as "msgl", are installed.

Type the following command in the R console:

```R  
library(devtools)
install_github("Ali-Mahzarnia/graphclass_mult")
```

Usage:

Once the package is installed, users can use the following code to run an example:

```R 
library(graphclassmult)
set.seed(123)


n = 500 # sample size
p = 10 # dimension of connectomes (p * p )
ppminus1by2 = p*(p-1)/2 # length of vectorized connectome

x = matrix( NA, n, ppminus1by2   ) # vectorized data

true_beta1 = c( rep(1,1), rep(0,2), rep( 0.3,3 ) ,rep(0,4), rep( 0.5,5 ) ,rep(0,6), rep( 0.7,7 ),rep(0,8), rep( 0.9,9 ))
true_beta2 = c( rep(0.3,1), rep(0,2), rep( 0.5,3 ) ,rep(0,4), rep( 0.7,5 ) ,rep(0,6), rep( 0.9,7 ),rep(0,8), rep(1,9 ))
true_beta3 = c( rep(0.5,1), rep(0,2), rep( 0.7,3 ) ,rep(0,4), rep( 0.9,5 ) ,rep(0,6), rep( 1,7 ),rep(0,8), rep( 0.3,9 ))
true_beta = rbind (true_beta1 , true_beta2 , true_beta3) # concatenate all threee betas

plot_adjmatrix(true_beta1) # plot of beta1
plot_adjmatrix(true_beta2) # plot of beta2
plot_adjmatrix(true_beta3) # plot of beta3

beta1_matrix = get_matrix(true_beta[1,])
beta2_matrix = get_matrix(true_beta[2,])
beta3_matrix = get_matrix(true_beta[3,])

classes = c("A","B","C") # three classes 


y = NA
for (i in 1:n) {
  x_i = rnorm(ppminus1by2) # generate random numbers for matrix
  scores = t(x_i)%*%t(true_beta) + 0.05 * rnorm(3) # multiply x by true beta
  soft_scores = exp(scores)/sum(exp(scores)) # soft max of scores
  index_y = which(soft_scores == max(soft_scores)) # give x_i the class that has maximized the softmax probs.
  y = c(y,classes[index_y]) # concatenate with previous set of y
  x[i,] = x_i # concatenate with previous set of x_i
}
y = y [2: length(y)]  # remove the first NA
y = as.factor(y) # make it as a factor



gc = graphclass(X = x, Y = as.factor(y), type = "intersection", 
                rho = 1, gamma = 1e-5, folds = 10, lambda_selection = T)

gc$train_error # training erorr
mean(gc$Yfit!=y) # computing train err manually

gc$active_nodes

plot(gc) # plot all three betas and the reduced sum of them

gc$nonzeros_percentage # computing percentage of non sparse beta
mean(colSums(abs(gc$beta))!=0) # computing percentage of non sparse beta manually 

gc$reduced_beta # sum of abs of betas

```


The code above fits a subgraph selection penalty model on the simulation model (log-linear model)  using the graphclass package. It creates a graphclass object, "gc", with various attributes such as "Yfit", "train_error", "lambda", "active_nodes", and "nonzeros_percentage".

Output:

The package generates the following outputs:

"Yfit" - a vector of predicted class labels for the test data.
"train_error" - a scalar value representing the training error.
"lambda" - the optimal value of lambda selected by the package.
"active_nodes" - the nodes selected by the package.
"plot(gc)" - a graphical representation of the model. Each class of Y has a beta and consequently a plot.
"mean(colSums(abs(gc$beta))!=0)" - the mean number of non-zero coefficients.
"gc$nonzeros_percentage" - the percentage of non-zero coefficients.

Note that the package generates multiple beta, intercept, and plot values as there are classes (one for each class) in a one versus other comparision-The last plot is associated with sum of abs of all beta across all classes. The output $reduced_beta and $reduced_b are reduced sums (summation of absolute values) of beta and intercept over the classes.
Alpha is an input parameter between 0 and 1. By default it is set to 0 which implies the group Lasso method, while 1 is associated with Lasso, and any number between 0 and 1 associated with a compromise between group Lasso and Lasso. 



When letting the system choose the lambda (lambda_selection = T), there will be an oputput lambda_index. This out put can be used as an input to fit the model next time with lambda_selection = F. 


```R 

gc.fit = graphclass(X = x, Y = as.factor(y), type = "intersection", 
                rho = 1, gamma = 1e-5, folds = 10, lambda_selection = F, lambda_index = gc$lambda_index)

gc.fit$train_error # training erorr
mean(gc.fit$Yfit!=y) # computing train err manually

gc.fit$active_nodes

plot(gc.fit) # polot all three betas and the reduced sum of them

gc.fit$nonzeros_percentage # computing percentage of non sparse beta
mean(colSums(abs(gc.fit$beta))!=0) # computing percentage of non sparse beta manually 

gc.fit$reduced_beta # sum of abs of betas
```

If you want to use a specific functionality of a package, you can use the "::" operator. This operator allows you to call a specific function from a package without loading the entire package.

For example, if you want to use the "read_csv" function from the "readr" package, you can call it using the following syntax:
```R
readr::read_csv("file.csv")
```
This will call the "read_csv" function from the "readr" package and read in the data from the specified CSV file. For another example, related to this package we could write the following line instead of above:

```R
gc = graphclassmult :: graphclass(X = x, Y = as.factor(y), type = "intersection", 
                rho = 1, gamma = 1e-5, folds = 10, lambda_selection = T)
```

Using the "::" operator is particularly useful if you have multiple packages loaded in your workspace and want to avoid naming conflicts between functions with the same name from different packages. It also saves memory by only loading the functions you need from a package, rather than the entire package. Below is the above example with "::" operator instead of "library(graphclassmult)".

```R 
rm(list = ls()) # clean all variables in the R environment
detach("package:graphclassmult", unload = TRUE) # detaching the library(graphclassmult) if already loaded
set.seed(123)


n = 500 # sample size
p = 10 # dimension of connectomes (p * p )
ppminus1by2 = p*(p-1)/2 # length of vectorized connectome

x = matrix( NA, n, ppminus1by2   ) # vectorized data

true_beta1 = c( rep(1,1), rep(0,2), rep( 0.3,3 ) ,rep(0,4), rep( 0.5,5 ) ,rep(0,6), rep( 0.7,7 ),rep(0,8), rep( 0.9,9 ))
true_beta2 = c( rep(0.3,1), rep(0,2), rep( 0.5,3 ) ,rep(0,4), rep( 0.7,5 ) ,rep(0,6), rep( 0.9,7 ),rep(0,8), rep(1,9 ))
true_beta3 = c( rep(0.5,1), rep(0,2), rep( 0.7,3 ) ,rep(0,4), rep( 0.9,5 ) ,rep(0,6), rep( 1,7 ),rep(0,8), rep( 0.3,9 ))
true_beta = rbind (true_beta1 , true_beta2 , true_beta3) # concatenate all threee betas

graphclassmult::plot_adjmatrix(true_beta1) # plot of beta1
graphclassmult::plot_adjmatrix(true_beta2) # plot of beta2
graphclassmult::plot_adjmatrix(true_beta3) # plot of beta3

beta1_matrix = graphclassmult::get_matrix(true_beta[1,])
beta2_matrix = graphclassmult::get_matrix(true_beta[2,])
beta3_matrix = graphclassmult::get_matrix(true_beta[3,])

classes = c("A","B","C") # three classes 


y = NA
for (i in 1:n) {
  x_i = rnorm(ppminus1by2) # generate random numbers for matrix
  scores = t(x_i)%*%t(true_beta) + 0.05 * rnorm(3) # multiply x by true beta
  soft_scores = exp(scores)/sum(exp(scores)) # soft max of scores
  index_y = which(soft_scores == max(soft_scores)) # give x_i the class that has maximized the softmax probs.
  y = c(y,classes[index_y]) # concatenate with previous set of y
  x[i,] = x_i # concatenate with previous set of x_i
}
y = y [2: length(y)]  # remove the first NA
y = as.factor(y) # make it as a factor



gc = graphclassmult::graphclass(X = x, Y = as.factor(y), type = "intersection", 
                rho = 1, gamma = 1e-5, folds = 10, lambda_selection = T)

gc$train_error # training erorr
mean(gc$Yfit!=y) # computing train err manually

gc$active_nodes

plot(gc) # polot all three betas and the reduced sum of them

gc$nonzeros_percentage # computing percentage of non sparse beta
mean(colSums(abs(gc$beta))!=0) # computing percentage of non sparse beta manually 

gc$reduced_beta # sum of abs of betas

```

