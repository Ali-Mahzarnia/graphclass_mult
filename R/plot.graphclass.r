#' Plot function for graph classifier.
#'
#' Plots the coefficients matrix obtained with 
#' the function \code{\link{graphclass}}.
#' 
#' @rdname graphclass
#' @export
#'
#' @param object trained graphclass object
#' @examples
#' data(COBRE.data)
#' X <- COBRE.data$X.cobre
#' Y <- COBRE.data$Y.cobre
#' 
#' # An example of the subgraph selection penalty
#' gc = graphclass(X, Y = factor(Y), lambda = 1e-5, rho = 1)
#' 
#' plot(gc)
#' @encoding UTF-8
#' @importFrom Rdpack reprompt
plot.graphclass <- function(object, ...) {
  if (!inherits(object, "graphclass"))  {
    stop("Object not of class 'graphclass'")
  }
  
for (i in 1:dim(object$beta)[1]){
  beta= object$beta[i,]
  cat("The plot number " , i ," is associated with class {",rownames(object$beta)[i] ,"} \n")
  print(plot_adjmatrix(beta) )
   }
  cat("The last plot is associated with sum of abs of all beta across all classes \n")
  print(plot_adjmatrix(object$reduced_beta) )
}


