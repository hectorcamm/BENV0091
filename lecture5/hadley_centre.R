library(tidyverse)
library(zoo)

# Filename
f <- 'https://raw.githubusercontent.com/owid/owid-datasets/master/datasets/Global%20average%20temperature%20anomaly%20-%20Hadley%20Centre/Global%20average%20temperature%20anomaly%20-%20Hadley%20Centre.csv'

# Read data
df <- read_csv(f)
names(df) <- c('entity', 'year', 'anomaly')

# Wrangle the data for plotting
plot_df <- df %>% 
  pivot_wider(id_cols = year, 
              names_from = entity,
              values_from = anomaly) %>%
  mutate_at(c("lower", "median", "upper"), na.aggregate) %>% 
  mutate(roll_avg = rollmean(median, 10, na.pad = TRUE))

# Create the plot
ggplot(plot_df) + 
  geom_pointrange(aes(x = year, 
                  ymin = lower, 
                  ymax = upper,
                  y = median)) + 
  geom_line(aes(x = year, y = roll_avg),
            color = 'red') + 
  theme_light() + 
  labs(x = 'Year',
       y = 'Temperature anomaly (C)',
       title = 'Global average temperature anomaly - Hadley Centre',
       subtitle = paste0('Red line indicates 10 year moving average of median prediction\n',
                         'Ranges show median, lower and upper prediction intervals'),
       caption = 'Data downloaded from Our World In Data\nhttps://github.com/owid/owid-datasets')  +
  theme(plot.caption = element_text(size = 10,
                                   color = "gray30"))

