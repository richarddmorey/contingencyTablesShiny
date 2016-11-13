#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
ct_test <- function(value = list(), label = "", tooltip = "", width = NULL, height = NULL, elementId = NULL)
  {
  
  if(is.matrix(value)){
    value = list(m = value)
  }
  
  if(length(value) == 0){
    x = list(
      m = matrix(c(12, 5, 9, 7, 7, 15), ncol = 2),
    )
  }else{
    x = value
  }
  
  stopifnot(is.matrix(x[["m"]]))
  x[['nrow']] = nrow(x[["m"]])
  x[['ncol']] = ncol(x[["m"]])

  # create widget
  htmlwidgets::createWidget(
    name = 'ct_test',
    x,
    width = width,
    height = height,
    package = 'ct',
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      defaultWidth = 200,
      defaultHeight = 200
    )
  )
}

ctRunApp <- function() {
  appDir <- system.file("shiny-apps", "app1", package = "ct")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `ct`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}



#' Shiny bindings for ct_test
#'
#' Output and render functions for using ct_test within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a ct_test
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name ct_test-shiny
#'
#' @export
ct_testOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'ct_test', width, height, package = 'ct')
}

#' @rdname ct_test-shiny
#' @export
renderCt_test <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, ct_testOutput, env, quoted = TRUE)
}
