\name{profRegr}
\alias{profRegr}
\title{Profile Regression}
\description{Fit a profile regression model.}
\usage{
profRegr(covNames, fixedEffectsNames, outcome="outcome", 
        outcomeT=NA, data, output="output", hyper, predict, 
        nSweeps=1000, nBurn=1000, nProgress=500, nFilter=1, 
        nClusInit, seed, yModel="Bernoulli", xModel="Discrete", 
        sampler="SliceDependent", alpha=-1, excludeY, 
        extraYVar, varSelectType, entropy,reportBurnIn=FALSE,
        run=TRUE, discreteCovs, continuousCovs)
}
\arguments{
\item{covNames}{A vector of strings of the covariate names as by the column names in the data argument.}
\item{fixedEffectsNames}{A vector of strings of the fixed effect names as by the column names in the data argument.}
\item{outcome}{A string of column of the data argument that contains the outcome. The outcome cannot have missing values - you could consider predicting the value of the outcome for those subjects for which it has not been observed.}
\item{outcomeT}{A string of column of the data argument that contains the offset (for Poisson outcome) or the number of trials (for Binomial outcome).}
\item{data}{A data frame which has as columns the outcome, the covariates, the fixed effects if any and the offset (for Poisson outcome) or the number of trials (for Binomial outcome). The outcome cannot have missing values - you could consider predicting the value of the outcome for those subjects for which it has not been observed.}
\item{output}{Path to folder to save all output files. The covariates can have missing values, which must be coded as 'NA'. There cannot be missing values in the fixed effects - if there are, use an imputation method before using profile regression.}
\item{hyper}{Object of type setHyperparams with hyperparameters specifications. This is optional, default values are provided for all hyperparameters. See ?setHyperparams for details.}
\item{predict}{Data frame containing the predictive scenarios. This is only required if predictions are requested. 

At each iteration the predictive subjects are assigned to one of the current
clusters according to their covariate profiles (but ignoring missing values), or
their Rao Blackwellised estimate of theta is recorded (a weighted average of all
theta, weighted by the probability of allocation into each cluster.

The predictive subjects have no impact on the likelihood and so do not determine
the clustering or parameters at each iteration. The predictive allocations are
then recorded as extra entries in each row of the output_z.txt file. This can
then be processed in the post processing to create a dissimilarity matrix with
the fitting subjects. The post procesing function calcPredictions will create
predicted response values for these subjects.

See ?calcPredictions for more details and examples.
}
\item{nSweeps}{Number of iterations of the MCMC after the burn-in period. By default this is 1000.}
\item{nBurn}{Number of initial iterations of the MCMC to be discarded. By default this is 1000.}
\item{reportBurnIn}{If TRUE then the burn in iterations are reported in the output files, if set to FALSE they are not. It is set to FALSE by default.}
\item{nProgress}{The number of sweeps at which to print a progress update. By default this is 500.}
\item{nFilter}{The frequency (in sweeps) with which to write the output to file. The default value is 1.}
\item{nClusInit}{The number of clusters individuals should be initially randomly assigned to (Unif[50,60]).}
\item{seed}{The value for the seed for the random number generator. The default value is the current time.}
\item{yModel}{The model type for the outcome variable. The options currently available are "Bernoulli", "Poisson", "Binomial", "Categorical" and "Normal". The default value is Bernoulli.}
\item{xModel}{The model type for the covariates. The options currently available are "Discrete", "Normal" and "Mixed". The default value is "Discrete".}
\item{sampler}{The sampler type to be used. Options are "SliceDependent", "SliceIndependent" and "Truncated".  The default value is "SliceDependent".}
\item{alpha}{The value to be used if alpha is to remain fixed. If a negative value is used then alpha is updated. The default value is -1.}
\item{excludeY}{If included only the covariate data X is modelled. By default this is not included.}
\item{extraYVar}{If included extra Gaussian variance is included in the response model. By default the extra Gaussian variance is not included.}
\item{varSelectType}{The type of variable selection to be used "None", "BinaryCluster" or "Continuous".  The default value is "None".}
\item{entropy}{If included then we compute allocation entropy. By default the allocation entropy is not included.}
\item{run}{Logical. If TRUE then the MCMC is run. Set run=FALSE if the MCMC has been run already and it is only required to collect information about the run.}
\item{discreteCovs}{The names of the discrete covariates among the covariate names, if xModel="Mixed". This and continuousCovs must be defined if xModel="Mixed", while covNames is ignored.}
\item{continuousCovs}{The names of the discrete covariates among the covariate names, if xModel="Mixed". This and continuousCovs must be defined if xModel="Mixed", while covNames is ignored.}
}
\value{
Once the C++ has completed the output from fitting the regression is stored in a number of text files in the directory specified. Files are produced
containing the MCMC traces for all of the values of interest, along with a log file and files for monitoring the acceptance rates of the adaptive Metropolis Hastings moves.

It returns a number of files in the output directory as well as a list with the following elements. This an object of type runInfoObj.
\item{directoryPath}{String. Directory path of the output files.}
\item{fileStem}{String. The }
\item{inputFileName}{String. Location and file name of input dataset as created by this function for the C++ routines}
\item{nSweeps}{Integer. The number of sweeps of the MCMC after the burn-in.}
\item{nBurn}{Integer. The number of iterations in the burn-in period of the MCMC.}
\item{reportBurnIn}{Logical. Whether the output of the burn-in report should be included.}
\item{nFilter}{Integer. The frequency (in sweeps) with which to write the output to file. The default value is 1.}
\item{nSubjects}{Integer. The number of subjects.}
\item{nPredictSubjects}{Integer. The number of subjects for which to run predictions.}
\item{covNames}{A vector of strings with the names of the covariates.}
\item{xModel}{String. The model type for the covariates.}
\item{includeResponse}{Logical. If FALSE only the covariate data X is modelled.}
\item{yModel}{String. The model type for the outcome.}
\item{varSelect}{Logical. If FALSE no variable selection is performed.}
\item{varSelectType}{String. It specifies what type of variable selection has been performed, if any.} 
\item{nCovariates}{Integer. The number of covariates.}
\item{nFixedEffects}{Integer. The number of fixed effects.}
\item{nCategoriesY}{Integer. The number of categories of the outcome, if yModel = "Categorical". It is 1 otherwise.}
\item{nCategories}{Vector of integers. The number of categories of each covariate, if xModel = "Discrete". It is 1 otherwise.}
\item{xMat}{A matrix of the covariate data.}
\item{yMat}{A matrix of the outcome data, including the offset if the outcome is Poisson and the number of trials if the outcome is Binomial.}
\item{wMat}{A matrix of the fixed effect data.}
}
\section{Authors}{
David Hastie, Department of Epidemiology and Biostatistics, Imperial College London, UK

Silvia Liverani, Department of Epidemiology and Biostatistics, Imperial College London and MRC Biostatistics Unit, Cambridge, UK

and a contribution for mixed covariates by Lamiae Azizi, MRC Biostatistics Unit, Cambridge, UK

Maintainer: Silvia Liverani <liveranis@gmail.com>
}
\references{

Liverani, S., Hastie, D. I. and Richardson, S. (2013) PReMiuM: An R package for Profile Regression Mixture Models using Dirichlet Processes. \emph{Submitted}.

}
\examples{
# example for Poisson outcome and Discrete covariates
inputs <- generateSampleDataFile(clusSummaryPoissonDiscrete())
runInfoObj<-profRegr(yModel=inputs$yModel, 
    xModel=inputs$xModel, nSweeps=10, nClusInit=20,
    nBurn=20, data=inputs$inputData, output="output", 
    covNames = inputs$covNames, outcomeT = inputs$outcomeT,
    fixedEffectsNames = inputs$fixedEffectNames)


# example with Bernoulli outcome and Mixed covariates
inputs <- generateSampleDataFile(clusSummaryBernoulliMixed())
runInfoObj<-profRegr(yModel=inputs$yModel, 
    xModel=inputs$xModel, nSweeps=10, nClusInit=15,
    nBurn=20, data=inputs$inputData, output="output", 
    discreteCovs = inputs$discreteCovs,
    continuousCovs = inputs$continuousCovs)

}
\keyword{profileRegression}
