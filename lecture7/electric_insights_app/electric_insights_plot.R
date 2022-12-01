# Function for plotting generation by fuel type for a specific week
plot_generation <- function(df, week_no){
  
  # Filter the data,pivot, group by and summarise
  df_summary <- df %>% 
    filter(week == week_no) %>% 
    pivot_longer(nuclear:solar,
                 names_to = 'fuel',
                 values_to = 'MWh') %>%
    mutate(MWh = replace_na(MWh, 0)) %>%
    group_by(fuel) %>% 
    summarise(total_gen = sum(MWh))
  
  # Create the plot
  plot <- df_summary %>% 
    ggplot(aes(x = fuel, y = total_gen, fill = fuel)) + 
    geom_col() 
  
  return(plot)
}
