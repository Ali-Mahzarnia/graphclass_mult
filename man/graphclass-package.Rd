% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkgname.R
\docType{package}
\name{graphclass-package}
\alias{graphclass}
\alias{graphclass-package}
\title{Graph classification with node penalized logistic regression}
\description{
Network classification with applications to brain connectomics.
}
\details{
This package performs classification with network valued covariates
using a penalized logistic regression as in \insertCite{relion2017network;textual}{graphclass}.

The function \code{\link{graphclass}} fits a regularized logistic regression
to a set of graphs with associated class labels. 
The package also provides a function \code{\link{plot_adjmatrix}} to plot the adjacency matrix
of a graph or square matrix.
Two datasets of fMRI brain networks are available in the package. See \code{\link{COBRE.data}} and 
\code{\link{UMich.data}}.
}
\author{
\strong{Maintainer}: Jesus Daniel Arroyo Relion \email{jarroyor@umich.edu}

}
\keyword{internal}
