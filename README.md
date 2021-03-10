
<!-- README.md is generated from README.Rmd. Please edit that file -->

# adjrct

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R build
status](https://github.com/nt-williams/rctSurv/workflows/R-CMD-check/badge.svg)](https://github.com/nt-williams/rctSurv/actions)
<!-- badges: end -->

> Efficient Estimators for Survival and Ordinal Outcomes in RCTs Without
> Proportional Hazards and Odds Assumptions

Nick Williams and Iván Díaz

------------------------------------------------------------------------

# Installation

The development version can be installed from
[GitHub](https://github.com) with:

``` r
devtools::install_github("nt-williams/survrct")
```

# Scope

**survrct** implements efficient estimators for the restricted mean
survival time (RMST) and survival probability in randomized controlled
trials (RCT) without the proportional hazards assumption as introduced
in Diaz et al. (2019). Prognostic baseline variables should be
incorporated to obtain equal or better asymptotic precision compared to
unadjusted estimators. Under random censoring, the primary estimator
(TMLE) is doubly robust–it is consistent if either the outcome or
censoring model is correctly specified. This is an advantage over Cox
proportional hazards which relies on assumptions of only the outcome
model. Estimators are implemented using a formula interface based on
that of the [**survival**](https://CRAN.R-project.org/package=survival)
package for familiar users.

# Example

To allow for estimation of multiple estimands without having to
re-estimate nuisance parameters we first create a Survival metadata
object using the `survrct()` function. We specify the model
paramaterization using a typical `R` formula with `Surv()` (based on the
[**survival**](https://CRAN.R-project.org/package=survival) package)
specifying the left-hand side of the formula.

We also specify the target variable of interest, an optional time
coarsener, and the estimator.

``` r
library(survrct)

data(colon)
surv <- survrct(Surv(time, status) ~ trt + age + sex + obstruct + perfor + adhere + surg,
                target = "trt", data = colon, coarsen = 30, estimator = "tmle")
#> Surv(time, status) ~ trt + age + sex + obstruct + perfor + adhere + 
#>     surg
#> 
#> ● Estimate RMST with `rmst()`
#> ● Estimate survival probability with `survprob()`
#> ● Inspect nuisance parameter models with `get_fits()`
#> 
#>          Estimator: tmle
#>    Target variable: trt
#>   Status Indicator: status
#>     Adjustment set: age, sex, obstruct, perfor, adhere, and surg
#> Max coarsened time: 111
```

Using the metadata from the previous step we can now estimate the
restricted mean survival time and survival probability for a single or
multiple time horizons. If multiple times are evaluated, two confidence
bands are returned: 95% point-wise intervals as well as 95% uniform
confidence bands based on the multiplier-bootstrap from Kennedy (2019).

``` r
rmst(surv, 40)
#> RMST Estimator: tmle
#>   Time horizon: 40
#> 
#> Arm-specific RMST:
#> Treatment Arm
#>       Estimate: 31.95
#>     Std. error: 0.73
#>         95% CI: (30.52, 33.38)
#> Control Arm
#>       Estimate: 27.5
#>     Std. error: 0.84
#>         95% CI: (25.86, 29.14)
#> 
#> Treatment Effect:
#> Additive effect
#>       Estimate: 4.45
#>     Std. error: 1.11
#>         95% CI: (2.27, 6.63)
survprob(surv, 40)
#> Survival Probability Estimator: tmle
#>   Time horizon: 40
#> 
#> Arm-specific Survival Probability:
#> Treatment Arm
#>       Estimate: 0.67
#>     Std. error: 0.03
#>         95% CI: (0.62, 0.73)
#> Control Arm
#>       Estimate: 0.53
#>     Std. error: 0.03
#>         95% CI: (0.48, 0.59)
#> 
#> Treatment Effect:
#> Additive effect
#>       Estimate: 0.14
#>     Std. error: 0.04
#>         95% CI: (0.06, 0.22)
```

# References

Díaz, I., E. Colantuoni, D. F. Hanley, and M. Rosenblum (2019). Improved
precision in the analysis of randomized trials with survival outcomes,
without assuming proportional hazards. Lifetime Data Analysis 25 (3),
439–468.

Edward H. Kennedy (2019) Nonparametric Causal Effects Based on
Incremental Propensity Score Interventions, Journal of the American
Statistical Association, 114:526, 645-656, DOI:
10.1080/01621459.2017.1422737
