rm(water_buddies)
getwd()
source('scripts/data_manipulation.R')
library(data.table)
library(readxl)
water_buddies <- read_excel("~/Downloads/HB/Pmaca/vodni_utvary_QMd_final_2018_1_30_mm.xlsx", 
                            sheet = "All")
View(water_buddies)

str(water_buddies)

wb <- water_buddies[, c(1,
                        grep(pattern = 'm3',
                             x = names(x = water_buddies)))]

wb <- as.data.table(wb)

wb

names(wb) <- gsub(pattern = '\\[m3.s-1\\]',
                  replacement = '',
                  x = names(wb))
long <- melt(data = wb[1:100],
             id.vars = 1)

setnames(x = long,
         old = 'Identifikátor',
         new = 'id')
wbm
long
str(object = long)
object.size(x = long)

long[, id := as.factor(x = id)]
str(object = long)
object.size(x = long)

library(ggplot2)

ggplot(data = long) +
  geom_boxplot(mapping = aes(x = variable,
                             y = value,
                             group = variable))

ggplot(data = long) +
  geom_boxplot(mapping = aes(x = id,
                             y = value,
                             group = id))

long <- long[value < max(value),]

ggplot(data = long) +
  geom_boxplot(mapping = aes(x = variable,
                             y = value,
                             group = variable))

ggplot(data = long) +
  geom_boxplot(mapping = aes(x = id,
                             y = value,
                             group = id))

ggplot(data = long) +
  stat_ecdf(mapping = aes(x = value,
                          colour = variable)) +
  facet_wrap(facets = ~ variable,
             ncol = 5)
install.packages("RColorBrewer")

library(RColorBrewer)

ggplot(data = long) +
  stat_ecdf(mapping = aes(x = value,
                          colour = variable)) +
  labs(x = 'an x-axis',
       y = 'prob',
       title = 'plot',
       subtitle = 'something') +
  scale_colour_discrete()
  
cols <- sample(x = colors(),
               size = length(
                 x = levels(
                   x = long[, variable]
                 )
               ))

ggplot(data = long) +
  stat_ecdf(mapping = aes(x = value,
                          colour = variable,
                          linetype = variable)) +
  labs(x = 'an x-axis',
       y = 'prob',
       title = 'plot',
       subtitle = 'something') +
  lims(x = c(0,25),
       y = c(.75, 1)) +
  scale_colour_manual(values = cols,
                      name = 'legend') +
  coord_polar()

ggplot(data = clean.dta) +
  geom_line(mapping = aes(x = date,
                          y = value,
                          colour = ID),
            colour = 'white',
            show.legend = FALSE) +
  facet_wrap(facets = ~ ID,
             ncol = 3) + 
  theme_dark() +
  coord_polar()

clean.dta2 <- dta[,c('ID','month', 'value')]

ggplot(data = clean.dta2) +
  geom_histogram(mapping = aes(x = value),
                 binwidth = 5,
                 fill = 'red',
                 colour = 'white')+
  facet_grid(facets = ID~month,
             scales = 'free')+
  theme_dark()
