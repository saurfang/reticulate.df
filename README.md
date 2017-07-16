
<!-- README.md is generated from README.Rmd. Please edit that file -->
reticulate.df
=============

The goal of reticulate.df is to experiment conversion between R data.frame and Python pandas DataFrame in reticulate.

Installation
------------

You can install reticulate.df from github with:

``` r
# install.packages("devtools")
devtools::install_github("saurfang/reticulate.df")
```

Example
-------

From Python to R

``` r
library(reticulate.df)

library(reticulate)
pd <- import("pandas")
np <- import("numpy")


df <- pd$DataFrame(
  list(
    'A' = 1.,
    'B' = pd$Timestamp('20130102'),
    'C' = pd$Series(1, index = seq(4), dtype = 'float32'),
    'D' = np$array(rep(3L, 4), dtype='int32'),
    'E' = pd$Categorical(c("test","train","test","train")),
    'F' = 'foo'
  )
)
class(df)
#> [1] "pandas.core.frame.DataFrame"     "pandas.core.generic.NDFrame"    
#> [3] "pandas.core.base.PandasObject"   "pandas.core.base.StringMixin"   
#> [5] "pandas.core.base.SelectionMixin" "python.builtin.object"

as.data.frame(df)
#> # A tibble: 4 x 6
#>       A                   B     C     D      E     F
#>   <dbl>              <dttm> <dbl> <int> <fctr> <chr>
#> 1     1 2013-01-01 16:00:00     1     3   test   foo
#> 2     1 2013-01-01 16:00:00     1     3  train   foo
#> 3     1 2013-01-01 16:00:00     1     3   test   foo
#> 4     1 2013-01-01 16:00:00     1     3  train   foo
```

From R to Python

``` r
py_longley <- as_pandas(longley)

# http://scikit-learn.org/stable/tutorial/statistical_inference/supervised_learning.html#linear-regression
sklearn <- import("sklearn")
regr <- sklearn$linear_model$LinearRegression()
regr$fit(as_pandas(select(longley, -Employed)), py_longley$Employed)
#> LinearRegression(copy_X=True, fit_intercept=True, n_jobs=1, normalize=False)
regr$coef_
#> [1]  0.01506187 -0.03581918 -0.02020230 -0.01033227 -0.05110411  1.82915146
```
