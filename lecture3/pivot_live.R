# Read in the librarys

library(tidyverse)

# Read in the data
energy <- read_csv('data/energy_consumption_by_sector_fuel.csv')

### Task: use pivot_longer() to make the energy data tidy
pivot_longer()  /  pivot_wider()
gather()  /   spread()

longer <- energy %>% 
  gather(key="fuel",value="consumption",Solid_Fuel:Electricity) %>% system.time()

longer <- energy %>% 
  pivot_longer(Solid_Fuel: Electricity,
               names_to = 'fuel',
               values_to = 'consumption') %>% system.time()

### Task: create the plot on the right with ggplot2 and geom_line()
`data_to_use` %>% 
  ggplot() + 
  geom_line(aes(x = `variable_1`, 
                y = `variable_2`, 
                color = `variable_3`, 
                linetype = `variable_4`))






