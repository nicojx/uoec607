# Lecture 4 of "Data Science for economists" https://github.com/uo-ec607/lectures
# R language basics https://raw.githack.com/uo-ec607/lectures/master/04-rlang/04-rlang.html#1

`%ni%` <- Negate(`%in%`) ## The backticks (`) help to specify functions.
4 %ni% 5:10
1 != 2
0.1 + 0.2 == 0.3 # doesn't work!
all.equal(0.1 + 0.2, 0.3) #does

vignette("dplyr") #I did not know this!

vignette(all = FALSE) # if you only want to see the vignettes of any loaded packages.


df <- data.frame(x = 1:2, y = 3:4)
class(df)
typeof(df)
str(df)

lm(y ~ x)
lm(y ~ x, data = df)

df2 <- data.frame(x = rnorm(10), y = runif(10))


plot(1:10)
dev.off()















