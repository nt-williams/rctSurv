% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimator.R
\name{mannwhitney}
\alias{mannwhitney}
\title{Estimate the Mann-Whitney Statistic}
\usage{
mannwhitney(metadata)
}
\arguments{
\item{metadata}{An object of class "Ordinal" generated by a call to \code{ordinalrct()}.}
}
\value{
A list of class \code{mannwhit} containing the computed estimates
  including the efficient influence function, standard errors,
  and confidence intervals.
}
\description{
Computes the Mann-Whitney estimand; the probability that a randomly drawn patient
from the treated arm has a better outcome than a randomly drawn patient from
the control arm, with ties broken at random
}
\examples{
rct <- ordinalrct(state_ordinal ~ A + age, A ~ 1, data = c19.ordinal)
mannwhitney(rct)
}
\seealso{
\code{\link{ordinalrct}} for creating \code{metadata}.

Other ordinalrct functions: 
\code{\link{cdf}()},
\code{\link{log_or}()},
\code{\link{pmf}()}
}
\concept{ordinalrct functions}
