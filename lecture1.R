# https://github.com/uo-ec607

#update.packages(ask = FALSE, checkBuilt = TRUE)
#install.packages(c("ggplot2", "gapminder"), dependencies=T)
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gapminder, tidyverse, mapproj)

###first regression and chart ####
fit = lm(mpg ~ wt, data = mtcars)
summary(fit)

par(mar = c(4, 4, 1, .1)) ## Just for nice plot margins on this slide deck
plot(mtcars$wt, mtcars$mpg)
abline(fit, col = "red")

#same chart but nicer
#library(ggplot2)
ggplot(data = mtcars, aes(x = wt, y = mpg)) + 
  geom_smooth(method = "lm", col = "red") + 
  geom_point()

#### some more ggplot2 ####
#library(gapminder)
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, size = pop, col = continent)) + 
  geom_point(alpha = 0.3) ## "alpha" controls transparency. Takes a value between 0 and 1.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + ## Applicable to all geoms
  geom_point(aes(size = pop, col = continent), alpha = 0.3) ## Applicable to this geom only

p = ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))
p

p + 
  geom_point(alpha = 0.3)  +
  geom_smooth(method = "loess")

p + 
  geom_point(aes(size = pop, col = continent), alpha = 0.3)  +
  geom_smooth(method = "loess")

# Note what happens now: Why?
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, size = pop, col = continent)) +
  geom_point(alpha = 0.3)  +
  geom_smooth(method = "loess")


# And this won't work, because geom_density can't deal with y:
p + geom_density()

# that's better:
ggplot(data = gapminder) + ## i.e. No "global" aesthetic mappings"
  geom_density(aes(x = gdpPercap, fill = continent), alpha=0.3)

p2 =
  p + 
  geom_point(aes(size = pop, col = continent), alpha = 0.3) +
  scale_color_brewer(name = "Continent", palette = "Set1") + ## Different colour scale
  scale_size(name = "Population", labels = scales::comma) + ## Different point (i.e. legend) scale
  scale_x_log10(labels = scales::dollar) + ## Switch to logarithmic scale on x-axis. Use dollar units.
  labs(x = "Log (GDP per capita)", y = "Life Expectancy") + ## Better axis titles
  theme_minimal() ## Try a minimal (b&w) plot theme
p2

#### something really fancy ####
pacman::p_load(hrbrthemes, gganimate)
# library(hrbrthemes)
p2 + theme_modern_rc() + geom_point(aes(size = pop, col = continent), alpha = 0.2)

# library(gganimate)
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')


# Reading chapter 3 of Hadley Wickham's data science book
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#3.2.4 exercises
#1 nothing
ggplot(data = mpg)
#2 234 x 11
mpg
#3 the type of drive train
?mpg
#4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))
#5 both variables categorical, can't see overlaps
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
#3.3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#possible but stupid:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#exercises 3.3.1
#1 colour defined as aes but not linked to variable
#3 shape doesn't work with continuous var
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = hwy))
#4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = hwy))
?geom_point
#6 conditional colouring! nice
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
#3.5 facets
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
#exercises
#1 this still works with continuous
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~displ)
#2 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
#4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#3.6
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#3.6.1 exercises: 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(colour = "black") + 
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(colour = "black") + 
  geom_smooth(mapping = aes(group = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(colour = drv)) + 
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(colour = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(colour = drv))
#3.7
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
diamonds
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
#3.7.1
#1 geom="pointrange"
?stat_summary
?geom_pointrange
ggplot(data = diamonds) + 
  geom_pointrange(mapping = aes(x = cut, y = depth), 
                  stat = "summary",
                  fun.min = min,
                  fun.max = max,
                  fun = median)
#ggplot(diamonds) +
#  geom_pointrange(aes(cut, depth, ymin = depth, ymax = depth))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
#2
?geom_col
ggplot(data = diamonds) +
  geom_col(mapping = aes(x = cut, y = frequency(cut)))
#4
?stat_smooth
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method = lm)
#5
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
# https://stackoverflow.com/questions/39878813/ggplot-geom-bar-meaning-of-aesgroup-1
#3.8
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#3.8.1 exercises
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_jitter()
?geom_jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_jitter(width = 0.2, height = 0.5)
?geom_count
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
?geom_boxplot #default position adjustment = dodge2
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = hwy, y = drv, colour = class))
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = hwy, y = drv, colour = class),
               position = "identity")
#3.9
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = hwy, y = drv, colour = class)) +
  coord_flip()
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) + 
  geom_polygon(fill = "white", colour = "black")
ggplot(nz, aes(long, lat, group = group)) + 
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()

ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar()
ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y")
?labs()
bar + coord_flip() +
  labs(title = "Title",
       caption = paste0("n=", sum(complete.cases(mpg))))

ggplot(nz, aes(long, lat, group = group)) + 
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
ggplot(nz, aes(long, lat, group = group)) + 
  geom_polygon(fill = "white", colour = "black") +
  coord_map() #depends on mapproj package

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
