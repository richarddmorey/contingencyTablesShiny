#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ct)

x1 <- matrix(c(12, 5, 9, 7), ncol = 2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Contingency tables"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       checkboxInput("contcor",
                     "Continuity correction (2x2)?",
                     value = TRUE),
       selectizeInput("confcoef",
                     "Confidence coefficient?",
                     choices = c(.50,.68,.90,.95,.99), selected = .95),
       selectInput("groupby", "Group by:",
                   choices = c("none","rows","columns"), selectize = FALSE),
       width = 3
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Table",
          fluidRow(
            column(width = 6,
              plotOutput("myPlot",width = 200, height = 200)
            ),
            column(width = 6,
              #uiOutput("matrix")
              ct::ct_test(list(m=x1), elementId = "matrix")
            )
          ),
          fluidRow(
            column(width = 12,
              htmlOutput("myText")
            )
          )
        ),
        tabPanel(HTML("X<sup>2</sup> statistic"), htmlOutput("calcText")),
        tabPanel(HTML("p value"), htmlOutput("pvalText")),
        tabPanel(HTML("Correlations"), htmlOutput("correlText")),
        tabPanel(HTML("Other effect sizes"), htmlOutput("ESText")),
        tabPanel(HTML("R code"), htmlOutput("rcodeText"))
      )
    )
  )
))
