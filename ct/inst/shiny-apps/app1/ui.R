#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

x1 <- matrix(c(12, 5, 9, 7), ncol = 2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Contingency tables"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("rows",
                   "Number of rows:",
                   min = 2,
                   max = 10,
                   value = 2),
       sliderInput("cols",
                   "Number of cols:",
                   min = 2,
                   max = 10,
                   value = 2),
       checkboxInput("contcor",
                     "Continuity correction (2x2)?",
                     value = TRUE),
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
              ct_test(list(m=x1), elementId = "matrix")
            )
          ),
          fluidRow(
            column(width = 12,
              htmlOutput("myText")
            )
          )
        ),
        tabPanel("Calculations", htmlOutput("calcText"))
      )
    )
  )
))
