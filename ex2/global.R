# https://www.r-bloggers.com/2020/06/penguins-dataset-overview-iris-alternative-in-r/
# https://allisonhorst.github.io/palmerpenguins/articles/articles/examples.html
#install.packages(c('tidyverse','palmerpenguins'))
library(tidyverse)
library(palmerpenguins)


islands <- as.character(unique(penguins$island))
select_input_islands <- setNames(islands,islands)

penguins %>%
  filter(island %in% c('Torgersen','Dream')) %>%
  count(species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill = species)) +
  geom_label(aes(x = species, y = n, label = n)) +
  scale_fill_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
  theme_minimal()+
  labs(title = 'Penguins Species Count', x = 'Species', y = 'Counts')

penguins %>%
  filter(island %in% c('Torgersen','Dream')) %>%
  ggplot(data = ., aes(x = flipper_length_mm)) +
    geom_histogram(aes(fill = species), 
                   alpha = 0.5, 
                   position = "identity") +
    scale_fill_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
    theme_minimal() +
    labs(x = 'Flipper length (mm)',
         y = "Frequency",
         title = "Penguin Flipper Length"
    )



#pickerInput("select_islands","Select island:", 
#            choices = select_input_islands, 
#            options = list(`actions-box` = TRUE),
#            multiple = T, 
#            selected = select_input_islands)