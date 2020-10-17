pacman::p_load(gapminder, tidyverse, mapproj, ggthemes, scales, RColorBrewer)


mycolors <- colorRampPalette(ggthemes::ggthemes_data$excel$themes$`Office Theme`$accents)(8)
ggplot(data=diamonds, aes(x=clarity)) +
  geom_bar(aes(fill = clarity), width = 0.5) +
#  scale_fill_brewer(palette = "Set1") + 
  theme_excel_new() +
#  scale_fill_excel_new(theme = "Office Theme") +
#  scale_fill_manual(values = mycolors) +
  ggtitle("Diamonds") +
  ylab("Count") + 
  xlab("Clarity") + 
  geom_text(stat='count', aes(label=..count..), hjust=-0.1, size = 3) +
  coord_flip() +
  scale_y_continuous(breaks = breaks_extended(10), limits = c(0,13300)) +
  scale_x_discrete(breaks = NULL)

