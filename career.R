library(ggplot2)
library(dplyr)
career = read.csv('career.csv') %>% mutate(Opportunity = money, Year = year)

gg1 = ggplot(data=career, mapping = aes(x=Year, y=Opportunity))
gg2 = ggplot(data=career, mapping = aes(x=Year, y=academia))
ggp = geom_point()
ggl = geom_line(size=3, col='darkblue')
ggc = geom_col(mapping = aes(y=academia), fill='darkgreen', alpha=0.6)
gglab =  theme(axis.text.y = element_blank())
ggresult = gg1+ggl+ggc+gglab
