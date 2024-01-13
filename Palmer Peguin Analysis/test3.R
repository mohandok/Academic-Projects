install.packages("palmerpenguins") # You only need to do this once
library(palmerpenguins)
data("penguins")
penguins = na.omit(penguins) # Removes missing rows
my.student.number = 220488118
set.seed(my.student.number)
my.penguins = penguins[sample(nrow(penguins), 100), ]

library(tidyverse)
my.penguins %>%
  group_by(species) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=species, y=count, fill=species))+
  geom_col()+
  geom_text(aes(label=count))

ggplot(data=my.penguins,mapping=aes(x=island, fill=species))+
  geom_bar()+
  labs(title="                                                             Penguins species count in each island")
  
library(tidyverse)
my.penguins %>%
  count(species) %>%
  ggplot()+geom_col(aes(x=species, y=n, fill=species))+
  geom_label(aes(x=species, y=n, label=n))+
  scale_fill_manual(values=c("green","red","cyan4"))+
  theme_minimal()+
  labs(title="                                                             Count of Penguins species")+
  ylab("Penguins count")

ggplot(data=my.penguins,aes(x=bill_length_mm,y=bill_depth_mm))+
  geom_point(aes(color=species,
                 shape=species),
             size=2)+
  geom_smooth(method="lm",se=FALSE,aes(color=species))+
  scale_color_manual(values=c("darkorange","darkorchid","darkgreen"))+
  ylab("Penguins bill depth in mm")+
  xlab("Penguins bill length in mm")+
  labs(title="                                                   Bill depth and Bill length comparison between species ")


ggplot(data=my.penguins,
       mapping = aes(x=flipper_length_mm,y=bill_length_mm,color=sex))+
  geom_point()

ggplot(data=my.penguins,mapping = aes(x=species,y=body_mass_g,xlab='species type',colour=sex))+
  geom_boxplot()+
  theme_minimal()+
  ylab("Penguins body mass")+
  labs(title="                                                   MQMQM Summary of species based on their sex")


pen_plot_base <- ggplot(data = penguins,
                        mapping = aes(x = body_mass_g, y = species,
                                      color = species))
pen_plot_base +
  geom_jitter()+
  xlab("Body mass in g")+
  labs(title="                                                   Body mass with species type ")


ggplot(data = penguins,
       mapping = aes(x = species, y = flipper_length_mm,
                     color = sex)) +
  stat_summary(position = position_dodge(width = 0.3))


my.penguins <- my.penguins %>% filter(sex == 'MALE' | sex == 'FEMALE')
summary(my.penguins)
# Green, Orange, Purple
pCol <- c('darkgreen', '#ff8401', '#bf5000')
names(pCol) <- c('Gentoo', 'Adelie', 'Chinstrap')
plot(my.penguins, col = pCol[my.penguins$species], pch = 19)

library(palmerpenguins)
library(tidyverse)
library(tidycharts)
p<- my.penguins %>% count(year)
column_chart(p, "year", series=c("n")) %>% 
  add_title("Histogram of number of studied penguin during the years", "","")

---------------

A<-my.penguins%>%filter(my.penguins$species=="Adelie")
B<-my.penguins%>%filter(my.penguins$species=="Chinstrap")
C<-my.penguins%>%filter(my.penguins$species=="Gentoo")
Bi<-my.penguins%>%filter(my.penguins$island=="Biscoe")
D<-my.penguins%>%filter(my.penguins$island=="Dream")
T<-my.penguins%>%filter(my.penguins$island=="Torgersen")

summary(Bi)
summary(D)
summary(T)

summary(A)
summary(B)
summary(C)
----------------------------------------
  
library(tidyverse)
library(plotly)
library(skimr)
library(GGally)
library(ggthemes)
library(ggforce)
library(patchwork)
library(grid)
install.packages("BeyondBenford")
install.packages("beyondWhittle")
library(beyonce)

islands <- ggplot(data = my.penguins, aes(bill_length_mm, flipper_length_mm)) + 
  geom_mark_ellipse(expand = 0, aes(color = species)) + 
  geom_point(aes(color = species, alpha = .8)) +
  facet_wrap(~island) + ylab('Flipper Length (mm)') + xlab('Bill Length (mm)') + ggtitle('Species Breakdown by Island') +     theme_fivethirtyeight()
island_breakdown <- islands + theme(axis.title = element_text(family = 'sans'), strip.text = element_text(size = 15),
                                    panel.spacing = unit(2, "lines")) + scale_color_manual("Species") +                                     guides(alpha = 'none')