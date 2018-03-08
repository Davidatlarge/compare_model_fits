Compare the fit of multiple polynomal regressions
================
David Kaiser
2018-03-07

Description
-----------

This function fits multiple polynomal regressions to x and y data. The user supplies the highest degree of polynomal that should be included and all polynomals from one to that degree will be calculated. A summary table and a printed result will be output.

Arguments
---------

-   *x* - a vector of x values
-   *y* - a vector of y values
-   *degrees* - numeric value for the highest degree polynomal
-   *plot* - logical, should the results be plotted? defaults to TRUE

Result
------

A data frame giving for each polynomal the R², the adjusted R² and the p-value of the regression A printed sentence showing which polynomal best fits the data. A plot showing the data and the different fits (if plot = TRUE).

Example
-------

``` r
x <- seq(1,20,length.out = 20)
y <- x^seq(1,2,length.out = 20)
compare_model_fits(x, y, degrees = 3)
```

![](README_files/figure-markdown_github/example-1.png)

    ## [1] "A 3 degree polynomal regression best fits the data"

    ##        polynomal.degree r.squared r.squared.adj p.value.model
    ## value                 1 0.7332036     0.7183815  1.457740e-06
    ## value1                2 0.9617806     0.9572842  8.900550e-13
    ## value2                3 0.9966997     0.9960809  4.691585e-20
