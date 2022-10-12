##### Install libraries
library(tidyverse)

##### Task: write a function addition(x, y) which returns the sum of two arguments

addition <- function(x, y){
  return(x + y)
}
addition(1,2)

##### Task: Write a function to calculate the interquartile range of a vector

iqr <- function(v){
  upper <- as.numeric(quantile(v, 0.75))
  lower <- as.numeric(quantile(v, 0.25))
  return(upper - lower)
}

vector <- rnorm(10000)
iqr(vector)


### mpg tasks

##### Task: Calculate the average hwy MPG for a specified manufacturer 

average_hwy_mpg <- function(m){
  df <- mpg %>%
    filter(manufacturer == m)
  ans <- mean(df$hwy)
  return(ans)
}

average_hwy_mpg('audi')

##### Task: Return the highest cty MPG for a specified class and drv

max_cty_mpg <- function(c, d){
  df <- mpg %>%
    filter(class == c,
           drv == d)
  ans <- max(df$cty)
  return(ans)
}

max_cty_mpg('compact', 'f')

##### Task: Calculate the correlation between cty MPG and displ for a specified class

cor_mpg_displ <- function(c){
  df <- mpg %>%
    filter(class == c)
  
  ans <- cor(df$cty, df$displ)
  
  return(ans)
}

cor_mpg_displ('suv')

##### Task: write a function that prints “Even” or “Odd” depending if the input an even/odd number

if (13.5 %% 1 != 0){
  print("Not an integer")
} else if (13.5 %% 2 == 0){
  print("Even") 
} else {
  print("Odd")
}

even_or_odd <- function(x){
  if (x %% 1 != 0){
    print("Not an integer")
  } else if (x %% 2 == 0){
    print("Even") 
  } else {
    print("Odd")
  }
}

even_or_odd(1521.5)

##### Task: Write a function that checks if a letter is a vowel or consonant

is_vowel <- function(letter){
  if (letter %in% c('a', 'e', 'i', 'o', 'u')){
    return(TRUE)
  } else{
    return(FALSE)
  }
}

is_vowel('b')

##### Task: Using a nested if-else statement, write a function that prints: 

number_func <- function(x){
  if (x > 10){
    if (x %% 2 == 0){
      print("Big and even!")
    } else {
      print("Big and odd!") }
  } else {
    print("Small :(")
  }
}

number_func(11259125)


##### Task: Write a function that finds the roots of a quadratic equation given coefficients a, b, c

find_roots <- function(a, b, c){
  z = b**2 - 4*a*c
  if (z < 0){
    print("No real solution")
    return()
  }
  
  x1 = (-b + sqrt(z)) / 2*a
  x2 = (-b - sqrt(z)) / 2*a
  
  return(c(x1, x2))
}

find_roots(1, 10, -5)

##### Task: Write a function to change a word to lower case and remove vowels

convert_string <- function(word){
  word <- word %>%
    tolower() %>%
    str_remove_all('[aeiou]')
  return(word)
}

convert_string('ESDA')

##### add a `engine_category` column to mpg that is “large” for cars with at least a 2L engine displacement (`displ`), and small for all other cars

mpg %>% 
  mutate(engine_category = if_else(displ >= 2, 'large', 'small'))

##### Task: write a for loop that prints the numbers 1 to 100 (multiples of 7)

for (i in 1:100){
  if (i %% 7 == 0){
    print(i)
  }
}

### BEIS Headcount Tasks

data_dir <- 'data/beis_headcount'
files <- list.files(data_dir)
for (f in files){
  df <- read_csv(file.path(data_dir, f))
}

data_dir <- 'data/beis_headcount'
files <- list.files(data_dir)
for (f in files){
  df <- read_csv(file.path(data_dir, f)) %>%
    drop_na(`Total Headcount`)
  hc <- sum(df$`Total Headcount`)
  year <- str_extract(f, "[0-9]+")
  print(year)
  print(hc)
}

data_dir <- 'data/beis_headcount'
files <- list.files(data_dir)
for (f in files){
  df <- read_csv(file.path(data_dir, f))
  hc <- df %>% 
    filter(`Organisation name` == 'UK Space Agency') %>% 
    pull(`Total Headcount`)
  print(f)
  print(hc)
}

data_dir <- 'data/beis_headcount'
files <- list.files(data_dir)
for (f in files){
  df <- read_csv(file.path(data_dir, f))
  largest <- df %>% 
    filter(`Total Headcount` == max(`Total Headcount`)) %>% 
    pull(`Organisation name`)
  print(f)
  print(largest)
}

data_dir <- 'data/beis_headcount'
files <- list.files(data_dir)
all_df <- tibble()
for (f in files){
  df <- read_csv(file.path(data_dir, f))
  all_df <- all_df %>% bind_rows(df)
}







############### Visualisation #################

turbines <- read_csv('data/canada_wind_turbines.csv')

ggplot(data = turbines) + 
  geom_point(aes(x = rotor_diameter_m, y = turbine_rated_capacity_k_w))


turbines %>%
  ggplot() +
  geom_bar(aes(x = province_territory))

turbines %>%
  count(province_territory) %>%
  ggplot() +
  geom_col(aes(x = province_territory, y = n))


turbines %>%
  mutate(province_territory = fct_rev(fct_infreq(province_territory))) %>%
  ggplot() +
  geom_bar(aes(x = province_territory))


turbines %>%
  count(province_territory) %>%
  mutate(province_territory = fct_reorder(province_territory, n)) %>%
  ggplot() + 
  geom_col(aes(x = province_territory, y =n))


turbines %>%
  mutate(province_territory = fct_lump(province_territory, 3)) %>%
  ggplot() +
  geom_point(aes(x = turbine_rated_capacity_k_w, 
                 y = hub_height_m, 
                 color = province_territory))


turbines %>% 
  drop_na(turbine_rated_capacity_k_w) %>%
  mutate(large_cap = turbine_rated_capacity_k_w > 2000,
         province_territory = fct_lump(province_territory, 3)) %>% 
  ggplot() + 
  geom_bar(aes(x = province_territory, fill = large_cap),
           position = 'dodge')

turbines %>% 
  ggplot() + 
  geom_hex(aes(x = hub_height_m, y = rotor_diameter_m))

turbines %>% 
  mutate(commissioning_date = commissioning_date %>%
           str_extract('[0-9]+') %>%
           as.numeric()) %>%
  ggplot(aes(x = commissioning_date, y = hub_height_m)) + 
  geom_point() + 
  geom_smooth(method = 'lm')



turbines %>% 
  mutate(commissioning_date = commissioning_date %>%
           str_extract('[0-9]+')) %>%
  ggplot() + 
  geom_boxplot(aes(x = commissioning_date, y = turbine_rated_capacity_k_w)) + 
  coord_flip()


turbines %>% 
  drop_na(turbine_rated_capacity_k_w) %>%
  mutate(province_territory = fct_lump(province_territory, 4)) %>% 
  group_by(province_territory) %>% 
  summarise(mean_capacity = mean(turbine_rated_capacity_k_w),
            se = sd(turbine_rated_capacity_k_w)) %>%
  ggplot(aes(x = province_territory, 
             y = mean_capacity,
             fill = mean_capacity,
             ymin = mean_capacity - se,
             ymax = mean_capacity + se)) + 
  geom_col() + 
  geom_errorbar()



