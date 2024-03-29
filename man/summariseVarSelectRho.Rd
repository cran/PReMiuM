\name{summariseVarSelectRho}
\alias{summariseVarSelectRho}
\title{summariseVarSelectRho}
\description{This function summarises the posterior distribution of rho, a parameter for variable selection only.}
\usage{
summariseVarSelectRho(runInfoObj)
}
\arguments{
\item{runInfoObj}{Object of type runInfoObj}
}
\value{A list with the following elements.
\item{rho}{A matrix that has as many columns as the number of covariates and as many rows as the number of sweeps. This matrix records the samples from the posterior distribution of rho for each covariate at each sweep.}
\item{rhoMean}{Vector with the column means of the matrix rho above. Each value corresponds to the posterior mean of rho for each covariate.}
\item{rhoMedian}{Vector with the column medians of the matrix rho above. Each value corresponds to the posterior median of rho for each covariate.}
\item{rhoLowerCI}{Vector with the column lower confidence intervals of the matrix rho above. Each value corresponds to the lower confidence interval of the posterior distribution of rho for each covariate.}
\item{rhoUpperCI}{Vector with the column upper confidence intervals of the matrix rho above. Each value corresponds to the upper confidence interval of the posterior distribution of rho for each covariate.}
}
\section{Authors}{
David Hastie, Department of Epidemiology and Biostatistics, Imperial College London, UK

Silvia Liverani, Department of Epidemiology and Biostatistics, Imperial College London and MRC Biostatistics Unit, Cambridge, UK

Maintainer: Silvia Liverani <liveranis@gmail.com>
}
\references{

Silvia Liverani, David I. Hastie, Lamiae Azizi, Michail Papathomas, Sylvia Richardson (2015). PReMiuM: An R Package for Profile Regression Mixture Models Using Dirichlet Processes. Journal of Statistical Software, 64(7), 1-30. \doi{10.18637/jss.v064.i07}.

}
\examples{
\dontrun{
inputs <- generateSampleDataFile(clusSummaryVarSelectBernoulliDiscrete())

runInfoObj<-profRegr(yModel=inputs$yModel, 
    xModel=inputs$xModel, nSweeps=10, nClusInit=15, 
    nBurn=20, data=inputs$inputData, output="output", 
    covNames = inputs$covNames, varSelect="Continuous")

rho<-summariseVarSelectRho(runInfoObj)
}
}
\keyword{variableSelection}

