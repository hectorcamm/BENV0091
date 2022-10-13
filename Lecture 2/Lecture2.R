library(tidyverse)

my_function <- function(number1, number2){
  a+b
}
my_function()

iqr <- function(v){
  upper <- as.numeric(quantile(v,0.75))
  lower <- as.numeric(quantile(v,0.25))
  return(upper  - lower)
}

iqr(mpg$hwy)


if(13 %% 2 != 0 ){
  print("odd")
} else{
  print("even")
  
}
