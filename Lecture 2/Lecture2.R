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

cor_mpg_dipl <- function(x){
  
  df <- mpg %>%
    filter(class == x)
  
  answer <- cor(df$cty,df$displ)
  
  return(answer)
}

cor_mpg_dipl("compact")



if(13.7 %% 1 != 0){
  print("Not an Integer")
} else if(13 %% 2 != 0 ){
  print("odd")
} else{
  print("even")
} 


mpg%>%
  mutate(model = ifelse(manufacturer == "audi", "German","notaudi"))

file_path <- ("data/beis_headcount/")
files <- list.files(file_path)

all_df  <- tibble()
for (f in files) {
  df  <- read.csv(file.path(file_path,f))
  all_df  <- all_df %>% bind_rows(df)
}

wind_turbines  <- read.csv("data/canada_wind_turbines.csv")
colnames(wind_turbines)

ggplot(wind_turbines)+
  geom_point(aes(x = rotor_diameter_m, y = turbine_rated_capacity_k_w, color = manufacturer, size = 0.3, alpha = 0.7))

wind_turbines%>%
ggplot()+
  geom_bar(aes(x = province_territory, y = turbine_rated_capacity_k_w), stat = "identity")


wind_turbines %>%
  #mutate(province_territory = as.factor(province_territory))%>%
  mutate(province_territory = fct_rev(fct_infreq(province_territory)))%>%
  ggplot()+
  geom_bar(aes(x = province_territory))

wind_turbines  %>%
  ggplot()+
  geom_bar(aes(x = province_territory, fill = manufacturer), position = "stack")
  
colnames(wind_turbines)
