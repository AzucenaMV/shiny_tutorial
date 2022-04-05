# https://www.r-bloggers.com/2020/06/penguins-dataset-overview-iris-alternative-in-r/
# https://allisonhorst.github.io/palmerpenguins/articles/articles/examples.html
#install.packages(c('tidyverse','palmerpenguins'))
library(tidyverse)
library(palmerpenguins)

filtered_data <- penguins

select_input_species <- setNames(unique(penguins$species),unique(penguins$species))
select_input_islands <- setNames(unique(penguins$island),unique(penguins$island))


penguins %>%
  count(species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill = species)) +
  geom_label(aes(x = species, y = n, label = n)) +
  scale_fill_manual(values = c("darkorange","purple","cyan4")) +
  theme_minimal()+
  labs(title = 'Penguins Species & Count', xlab = 'Species', ylab = 'Counts')

penguins %>%
  drop_na() %>%
  count(sex, species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill = species)) +
  geom_label(aes(x = species, y = n, label = n)) +
  scale_fill_manual(values = c("darkorange","purple","cyan4")) +
  facet_wrap(~sex) +
  theme_minimal() +
  labs(title = 'Penguins Species ~ Gender')


ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = bill_length_mm)) +
  geom_point(aes(color = species, 
                 shape = species),
             size = 3,
             alpha = 0.8) +
  theme_minimal() +
  scale_color_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
  scale_shape_manual(values = c('Adelie' = 16, 'Gentoo' = 15, 'Chinstrap' = 17)) +
  labs(title = "Flipper and bill length",
       subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER",
       x = "Flipper length (mm)",
       y = "Bill length (mm)",
       color = "Penguin species",
       shape = "Penguin species") +
  theme(legend.position = c(0.85, 0.15),
        legend.background = element_rect(fill = "white", color = NA),
        plot.title.position = "plot",
        plot.caption = element_text(hjust = 0, face= "italic"),
        plot.caption.position = "plot")


