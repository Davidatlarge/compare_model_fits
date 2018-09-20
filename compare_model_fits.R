#### fit polynomal regressions of consecutive degrees to data

compare_model_fits <- function(x, y, degrees, plot = TRUE){
  # fit models to data
  models <- lapply(1:degrees, function(deg) {lm(x ~ poly(y, degree = deg))}) # runs the models up to n degrees and stores them all in a list
  
  # run anova on models to see p-value for the reduction fo risidual sum of squares
  # https://stackoverflow.com/questions/43436047/anova-on-a-sequence-of-models-stored-in-a-list
  models_anova <- eval( # runs the anova by evalualting the parsed text as a function
    parse(text = # parses the text into an expression
            paste("anova(", # creates the text string containing anova() 
                  paste("models[[",1:length(models),"]]", sep = "", collapse=", "), # cycles through all models in the list
                  ")", sep = "")
    )
  )
  
  # create a df with results for output
  results <- data.frame(
    "degree" = 1:degrees,
    "r.squared" = unlist( # turns the list result of lapply into a vector
      lapply(models, function(element) summary(element)$r.squared)), # for each element of the list makes a summary and gets the r.squared from it
    "adj.r.squared" = unlist(lapply(models, function(element) summary(element)$adj.r.squared)),
    "f.statistic" = unlist(lapply(models, function(element) summary(element)$fstatistic[1])),
    "regression.P" = pf( # calculated p-value
      unlist(lapply(models, function(element) summary(element)$fstatistic[1])), # extacts f-statistic from summary
      unlist(lapply(models, function(element) summary(element)$fstatistic[2])), # extracts df1 from summary
      unlist(lapply(models, function(element) summary(element)$fstatistic[3])), # extracts df2 from summary
      lower.tail = FALSE),
    "RSS" = models_anova$RSS, # residual sum of squares
    "anova.P" = models_anova$`Pr(>F)` # p-value of anova on one model vs the preceding model (e.g. cubic vs. quadratic)
  )
  
  # plot data and fits
  if(plot){
    plot(x,y, pch = 16) # plot the data
    lapply(1:degrees, function(deg) # plot the regression lines
    {lines(sort(x), fitted(lm(y ~ poly(x, degree = deg)))[order(x)], col = deg, type = 'l', lty = "dashed")}
    )
    legend("topleft", title = "degree", legend = c(1:degrees), col = c(1:degrees), lty = "dashed") # add legend
  }
  
  
  # output the result
  return(results)
}
