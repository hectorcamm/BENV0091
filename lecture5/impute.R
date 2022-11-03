library(zoo)

# Create the dummy time series
values <- c(7,3,NA,2,3,1,NA,4,7,10,NA,NA,9,8,7,5,4,NA,1,-1,-5,NA,NA,NA,-20,-6,-3,-1)
N <- length(values)

# Data frame of imputations
fills <- tibble(values = values) %>% 
  transmute(
    x = 1:N, 
    `Lin. interp.` = zoo::na.approx(values),
    `Carry forward` = zoo::na.locf(values),
    `Mean` = zoo::na.aggregate(values, FUN = mean),
    `Splines` = zoo::na.spline(values)) %>% 
  pivot_longer(-x)

# Create the plot
ggplot() + 
  geom_line(data = fills , 
            mapping = aes(x = x, 
                          y = value,
                          color = name),
            alpha = .8) + 
  geom_line(data = tibble(x = 1:N,
                          values = values),
            mapping = aes(x = x, y = values, color = 'Real data'),
            size=1.2) + 
  theme_minimal() + 
  scale_color_manual(name = 'Method', 
                     values = c("Lin interp." = 'red', 
                                "Carry forward" = 'blue',
                                "Mean" = 'forestgreen', 
                                "Splines" = 'orange', 
                                "Real data" = 'black'))
