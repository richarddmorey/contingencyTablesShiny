# contingencyTablesShiny

Interactive demonstration of contingency table statistics using R and shiny. Allows a student to edit a contingency table and get an immediate analysis, so that students can see the relationship between numbers in the contingency table and the analysis. Soon, calculations will be added so that students can see how the numbers are arrived at.

![Screenshot](http://richarddmorey.org/images/ct_test.png)

## To install in R

    devtools::install_github("richarddmorey/contingencyTablesShiny", subdir = "ct")

## To run in R

    library(ct)
    ctRunApp()

## What to do

* Click on a cell in the number matrix to type in a new number and get a new analysis
* Click on one of the arrow buttons to add and remove rows and columns, then enter new numbers. 
