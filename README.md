
# SNPgrou

<!-- badges: start -->
<!-- badges: end -->

The goal of SNPgrou is to associate multi-level phenotypic traits with multiple loci to genome wide SNP data. 

## Installation

You can install the released version of SNPgrou by:

``` r
require("devtools")
install_github("Kevinpen/SNPgrou", build_vignettes = TRUE)
library("SNPgrou")
```

## Overview

This R package is intended to use as a tool to assist GWAS: asscociate phenotypic response to genotype data. In existing GWAS packages, phenotype response variable are limited to continues or binary, this package specifically extends the response to categorical and have multiple levels. So this package can be used for situations where phenotype data are like eye colours or subtypes of breast cancer. 

This package use lda function from MASS package, but to give an explicit metric of how each locus is related to the phenotype, it build a "gScore", which is the measure of how accurately the lda model generate phenotype in repeated cross-validation. This practice is based on the idea that when using leave-one-out cross-validation to predicate the phenotype, those locus with strong relation to phenotype should be able to accurately predicate phenotype. 

An overview of the package is illustrated below. 

![](./inst/extdata/PENG_G_A1.png) 



## Contributions

The author of the package is Gang Peng. The functions available within this package include:

``` r
library("SNPgrou")
lsf.str("package:SNPgrou")
```
- prep
- snpgrou
- gws
- groupView
- plotGws
- summaryGws
- is.gScore
- summarySNP
- is.SNP

The package use GWS data from package "SNPassoc", but the original phenotype data is binary, here three levels phenotype is simulated. The workflow of this package is simialr to SNPassoc. The concept gSCore is similar to  "Classification accuracy" in the package "genephen", which use other statistical learning model.

## References 
- González JR1, Armengol L, Solé X, Guinó E, Mercader JM, Estivill X, Moreno V(2007). SNPassoc: an R package to perform whole genome association studies. Bioinformatics. 2007 Mar 1;23(5):644-5. Epub 2007 Jan 31. DOI: 10.1093/bioinformatics/btm025.

- Thanks package "genphen"(DOI: 10.18129/B9.bioc.genphen, Author: Simo Kitanovski) inspired the concept of gScore. 

## Acknowledgments

- This package was developed as part of an assessment for 2019 BCB410H: Applied Bioinformatics, University of Toronto, Toronto, CANADA.
