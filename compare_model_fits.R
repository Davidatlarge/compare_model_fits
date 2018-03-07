#### fit polynomal regressions of consecutive degrees to data

compare_model_fits <- function(x, y, degrees, plot = TRUE){
  # plot input data
  if(plot){plot(x,y, pch = 16)}
  
  for(degree in 1:degrees){
    if(!exists("summary.df")){summary.df <- data.frame(NULL)}
    # fit the current degree polynomal model
    current <- summary(lm(y ~ poly(x, degree = degree)))
    # extract model summary results
    current.df <- data.frame("polynomal.degree" = degree,
                             "r.squared" = current$r.squared,
                             "r.squared.adj" = current$adj.r.squared,
                             "p.value.model" = pf(current$fstatistic[1], current$fstatistic[2], current$fstatistic[3], lower.tail = FALSE)
    )
    # amend previous results
    summary.df <- rbind(summary.df, current.df)
    # plot the current model
    if(plot){
      lines(sort(x), fitted(lm(y ~ poly(x, degree = degree)))[order(x)], col=degree, type='l', lty=degree)
    }
    # clean up
    rm(current, current.df, degree)
  }
  # print the best fit degree as text
  print(paste("A", summary.df$polynomal.degree[summary.df$r.squared.adj==max(summary.df$r.squared.adj, na.rm=TRUE)], 
              "degree polynomal regression best fits the data", sep = " "))  
  # output the result
  return(summary.df)
  
}

# example
x <- seq(1,20,length.out = 20)
y <- x^seq(1,2,length.out = 20)

compare_model_fits(x, y, degrees = 3)
