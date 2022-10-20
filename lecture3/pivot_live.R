# Read in the librarys

library(tidyverse)
# install.packages("caTools")
library(caTools)
library(broom)

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

plot + facet_wrap(~Sector, scales = 'free_y',
                  ncol=1)

### Task: use facet_grid() to create a line plot for each fuel and sector (see right)

### Task: create a bar plot of consumption vs. year, coloured by Sector, faceted by fuel

longer %>% 
  ggplot() + 
  geom_col(aes(x = Year, 
               y = consumption,
               fill = Sector)) +
  facet_wrap(~fuel, scales = 'free_y')+
  coord_flip()+
  theme_bw()+
  theme(rect=element_blank(),
                   panel.grid = element_blank(),
                   panel.background= element_blank(),
                   plot.background = element_blank(),
                   legend.position="top",
                   axis.text.x=element_text(colour="orange"),
                   axis.text.y=element_text(colour="black"),
                   text = element_text(colour="blue"),
                   axis.line.x.bottom=element_line(color="green"),
                   axis.line.y.left=element_line(color="red")
  )

### Task: replace facet_grid() with facet_wrap() and set the y scale to be free

longer %>% 
  ggplot() + 
  geom_line(aes(x = Year, 
                y = consumption)) +
  facet_wrap(Sector ~ fuel, scales = 'fixed')

# Exploratory Data analysis -----------------------------------------------

df<-mpg %>% 
  select(hwy,displ,class,cyl,drv)


library(broom)
### Preparing the data

df <- mpg %>% 
  select(hwy, displ, cyl, drv, class) %>%
  mutate_if(is.character, as.factor) # Convert the character variables to factors

### Splitting into train and test sets

set.seed(123)

split<-sample.split(df$hwy,0.75) # '1:nrow(df)' rempresents a vector
#  'df$hwy' would also work
train_data <-subset(df,split==TRUE)       #  Take 75% of the rows from df
test_data <-subset(df,split==FALSE)       # All rows in df that are NOT in train


### Some exploratory analysis

##### Categorical variables with boxplot

plot1<-df %>% 
  pivot_longer(drv:class) %>%
  ggplot() + 
  geom_boxplot(aes(x = value, y = hwy)) + 
  facet_wrap(~ name, scales = 'free') + 
  coord_flip()

##### Continuous variables with hexplot
plot2<-df %>% 
  pivot_longer(displ:cyl) %>%
  ggplot() + 
  geom_hex(aes(x = value, y = hwy)) + 
  facet_wrap(~ name, scales = 'free')+
  theme(legend.position = "left")

library(gridExtra)
grid.arrange(plot1,plot2)


### Linear model fitting
# Fit a linear model: predict hwy with all other variables
linear_model <- lm(hwy ~ ., data = train_data)

summary(linear_model)
broom::tidy(linear_model)


### Decision tree fitting
library(rpart)
library(rpart.plot)

# Fit a decision tree: predict hwy with all other variables
dt <- rpart(hwy ~ ., data = train_data, 
            minsplit = 10,
            minbucket = 2,
            cp = 0.01)


rpart.plot(dt)

### Predictions on training set
train <- train_data %>% 
  mutate(linear_model = predict(linear_model, newdata = train_data),
         decision_tree = predict(dt, newdata = train_data)) %>% 
  pivot_longer(linear_model:decision_tree,
               names_to = 'model', 
               values_to = 'predicted') 

### Add residuals 
train <- train %>% 
  mutate(residual = predicted - hwy)

### Plots residuals for training set 
train %>% 
  ggplot(aes(x = hwy, y = residual)) + 
  geom_point() + 
  geom_smooth(method = 'lm') +  
  facet_wrap(~model)














