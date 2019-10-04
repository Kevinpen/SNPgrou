
# SNPgrou

<!-- badges: start -->
<!-- badges: end -->

The goal of SNPgrou is to associate multi-level phenotypic traits with multiple loci to genome wide SNP data. 

## Installation

You can install the released version of SNPgrou by:

``` r
require("devtools")
install.packages("SNPgrou")
library("SNPgrou")
```

## Overview
An overview of the package is illustrated below. 

![](./inst/extdata/PENG_G_A1.png) 
![](./inst/extdata/Rplot_GWS.png) 

## Contributions

The author of the package is Gang Peng. The functions available within this package include:

``` r
library("SNPgrou")
lsf.str("package:SNPgrou")
```
- prep
- snpgrou
- gws

The function prep() transform the data to class "SNP" object, with alleles separated with "/". The function snpgrou() input data prepared by prep function, use linear discriminant analysis to classify response phenotype according to genotype SNP, the response have more than two levels, genotype allow multi-allelic. The result of this function is a set of gScores for each locus, which is a metric for how strongly a locus is related to the phenotype. The function gws() accept input of genome wide SNP data and use snpgrou function to calculate and visualize the gScore of all loci.

In existing GWS packages, phenotype response variable are limited to continues or binary, my package specifically extends the response to categorical and have multiple levels. So this package can be used for situations where phenotype data are like eye colours or subtypes of breast cancer. 

This package use lda function from MASS package, but to give a explicit metric of how each locus is related to the phenotype, it build a "gScore", which is the measure of how accurately the lda model generate phenotype in repeated cross-validation. This practice is based on the idea that when using leave-one-out cross-validation to predicate the phenotype, those locus with strong relation to phenotype should be able to accurately predicate. This concept is similar to  "Classification accuracy" in the package "genephen", which use other statistical learning model.

The package use GWS data from package "SNPassoc", but the original phenotype data is binary, here three levels phenotype is simulated. 

