# Read in the librarys

library(tidyverse)

# Read in the data
energy <- read_csv('data/energy_consumption_by_sector_fuel.csv')

### Task: use pivot_longer() to make the energy data tidy
pivot_longer()  /  pivot_wider()
gather()  /   spread()

## Option 1 
longer <- energy %>% 
  gather(key="fuel",value="consumption",Solid_Fuel:Electricity) 


# Option 2
longer <- energy %>% 
  pivot_longer(Solid_Fuel: Electricity,
               names_to = 'fuel',
               values_to = 'consumption')


# To decide which option to use consider system.time() 
# Or simply how well the documentation is written
??tidyr::pivot_longer
??tidyr::gather 

### Task Hint (Solution to follow): create the plot on the right with ggplot2 and geom_line()
`data_to_use` %>% 
  ggplot() + 
  geom_line(aes(x = `variable_1`, 
                y = `variable_2`, 
                color = `variable_3`, 
                linetype = `variable_4`))

### Task: use pivot_wider() to return the pivoted energy data frame back to its original

longer %>%
  ggplot() +
  geom_line(aes(x = Year,
                y = consumption,
                color = fuel,
                linetype = Sector))+
 labs(y="Consumption",x="Year",title="Energy Consumption by Sector")


### Task: use pivot_wider() to create a new data frame with the following columns: Sector, fuel, 1970, 1971,…2017
# longer<-longer %>% 
#   pivot_wider(names_from = Year, values_from = consumption)

### Task: use facet_wrap() to create a bar plot for each sector (see right)
plot <- longer %>%
  ggplot() + 
  geom_col(aes(x = Year, 
               y = consumption,
               fill = fuel)) 

### Task: use the `scales` argument to allow each panel to be freely scaled by consumption
plot+
  facet_wrap(~Sector)

### Task: create a bar plot of consumption vs. year, coloured by Sector, faceted by fuel

### Task: use facet_grid() to create a line plot for each fuel and sector (see right)


### Task: replace facet_grid() with facet_wrap() and set the y scale to be free


# Exploratory Data analysis -----------------------------------------------

library(tidyverse)
# install.packages("caTools")
library(caTools)
library(broom)
### Preparing the data


### Splitting into train and test sets

#  'df$hwy' would also work


# Matrix

### Some exploratory analysis

##### Categorical variables with boxplot

##### Continuous variables with hexplot

library(gridExtra)
grid.arrange(plot1,plot2)

#     This looks messy try put the legend on the left of the plot with theme(legend.position="left)
# plot2<-df %>% 
#   pivot_longer(displ:cyl) %>%
#   ggplot() + 
#   geom_hex(aes(x = value, y = hwy)) + 
#   facet_wrap(~ name, scales = 'free')+
#   theme(legend.position = "left")


### Linear model fitting
# Fit a linear model: predict hwy with all other variables




# This function prints the model as a tidy data frame



### Decision tree fitting
library(rpart)
library(rpart.plot)

# Fit a decision tree: predict hwy with all other variables


### Predictions on training set


### Add residuals 


### Plots residuals for training set 


### Predictions on test set


### Predicted vs. actual


### Error metrics: MSE

### Error metrics: RMSE

### Error metrics: MAE

### Accuracy metrics








