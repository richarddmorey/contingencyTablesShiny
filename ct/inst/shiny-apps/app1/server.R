#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(lsr)
library(psych)
library(vcd)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # output$matrix <- renderCt_test({
  #   
  #   x1 <- matrix(c(12, 5, 9, 7, 7, 15), ncol = 2)
  #   
  #   x = list(
  #     nrow = nrow(x1),
  #     ncol = ncol(x1),
  #     m = x1
  #   )
  #   
  #   return(x)
  # })
  
  output$myPlot <- renderPlot({
    
    #return(NULL)
    
    json = input$matrix
    mat = as.matrix(jsonlite::fromJSON(json)[["m"]])
    
    x = as.integer(mat)
    dim(x) = dim(mat)
    
    dimnames(x) = list(rows = 1:nrow(x), columns = 1:ncol(x))
    vcd::mosaic(x, shade = FALSE)
    
    
  })
  
  output$calcText <- renderUI({
    return("Hi.")
  })
  
  output$myText <- renderUI({
    
    #return(NULL)
    correct = input$contcor
      
    json = input$matrix
    mat = as.matrix(jsonlite::fromJSON(json)[["m"]])

    x = as.integer(mat)
    dim(x) = dim(mat)
    
    op = myTryCatch( { z = chisq.test(x, correct = correct) } )
    
    if(!is.null(op$error)){
      all.out = paste("<pre class='ct_error'>",op$error,"</pre>", collapse = "\n")
    }else{
      stat = z$statistic
      pval = z$p.value
      p.text = ifelse(pval < .001, "<i>p</i> < .001", paste("<i>p</i> = ", round(pval,3)))
      df = z$parameter
      cV = lsr::cramersV(x)
      polych = psych::polychoric(as.table(x))$rho
      if(df == 1){
        phi = psych::phi(x)
        yuleQ = psych::Yule(x)
        tetra = psych::tetrachoric(as.table(x))[[1]]
        cor.text = paste("<i>&phi;</i> = ", round(phi,3),
                         ", Yule's <i>Q</i> = ", round(yuleQ, 3),
                         ", tetrachoric <i>&rho;</i> = ", round(tetra,3),
                         ".", sep="")
      }else{
        phi = yuleQ = tetra = NA
        cor.text = paste("Cramér's <i>V</i> = ", round(cV,3),
                         ", polychoric <i>&rho;</i> = ", round(polych, 3),
                         ".",sep="")
      }
      stat.text = paste("<i>X<sup>2</sup>(", df ,")</i> = ", round(stat, 3),
                        ", ", p.text, ". ", cor.text, sep="")
      
      st = stat.text
      if(is.null(op$warning)){
        wn=""
      }else{
        wn = paste("<br><pre class='ct_warning'>",paste(op$warning,collapse="\n"),"</pre>", sep="\n")
      }
      all.out = paste(st, wn, sep = "<br>")
    }
    
    return(HTML(all.out))

  })
  
})
