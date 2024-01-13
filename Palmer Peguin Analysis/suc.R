library(palmerpenguins)
library(tidyverse)
library(tidycharts)

penguins <- as.data.frame(my.penguins)

p <- penguins %>%
  drop_na(bill_length_mm, bill_depth_mm)
scatter_plot(p, p$bill_length_mm, p$bill_depth_mm, p$species, 10, 5, c("bill length", "in mm"), c("bill depht", "in mm"), "Legend") %>% 
  add_title("Relationship between bill length and bill depth","","")

p <- penguins %>%
  drop_na(bill_length_mm, body_mass_g)
scatter_plot(p, p$bill_length_mm, p$body_mass_g, p$species, 10, 1000, c("bill length", "in mm"), c("body mass", "in g"), "Legend") %>% 
  add_title("Relationship between bill length and body mass","","") 

ggplot(my.penguins, aes(x=bill_length_mm, fill=sex)) +
  geom_density()
# Use semi-transparent fill
-----------------------------------------------------------------
par(mfrow=c(2,2))
ggplot(my.penguins, aes(x=bill_length_mm, fill=sex)) +
  geom_density(alpha=0.1)+
  scale_fill_manual(values=c("orange2", "indianred2"))+
  xlab("Bill length(mm)")+
  labs(title = "                                Distribution plot With Bill length(mm)")

ggplot(my.penguins, aes(x=bill_depth_mm, fill=sex)) +
  geom_density(alpha=0.1)+
  scale_fill_manual(values=c("orange2", "indianred2"))+
  xlab("Bill length(mm)")+
  labs(title = "                                Distribution plot With Bill length(mm)")

ggplot(my.penguins, aes(x=flipper_length_mm, fill=sex)) +
  geom_density(alpha=0.1)

ggplot(my.penguins, aes(x=body_mass_g, fill=sex)) +
  geom_density(alpha=0.1)
p

------------------------------------------------------------------------
library(gridExtra)
library(ggplot2)
library(ggridges)
hist_cl <- ggplot(data = my.penguins, aes(x=bill_length_mm,y= species))+ 
geom_density_ridges(alpha=.4, aes(fill=species))+
theme_bw() + 
ylab("Density")+
xlab("Bill Length(mm)")+
theme(panel.grid.major = element_blank(),     #Background is white
      legend.position = "none")+
  ggtitle("Density Plots For Numerical variable")
  

hist_cd <- ggplot(data = my.penguins, aes(x=bill_depth_mm,y= species))+ 
  geom_density_ridges(alpha=.4, aes(fill=species))+
  theme_bw() + 
  ylab("Density") + 
  xlab("Bill Depth(mm)")+
  theme(panel.grid.major = element_blank(),     #Background is white
        legend.position = "none")   

hist_fl <- ggplot(data = my.penguins, aes(x=flipper_length_mm,y= species))+ 
  geom_density_ridges(alpha=.4, aes(fill=species))+
  theme_bw() +  
  ylab("Density") +
  xlab("Flipper Length(mm)")+
  theme(panel.grid.major = element_blank(),     #Background is white
        legend.position = "none")   

hist_bm <- ggplot(data = my.penguins, aes(x=body_mass_g,y= species))+ 
  geom_density_ridges(alpha=.4, aes(fill=species))+
  theme_bw() +  
  ylab("Density") +
  xlab("Body mass(g)")+
  theme(panel.grid.major = element_blank(),     #Background is white
        legend.position = "none")   

grid.arrange(hist_cl,hist_cd,hist_fl,hist_bm, nrow = 2)
  ----------------------------------------------------------------------
# Add mean lines
p+geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")
------------------------------------------------------------------------
  ggplot(data = my.penguins, aes(x = species, y = bill_length_mm)) +
  geom_jitter(aes(color = species),
              width = 0.1, 
              alpha = 0.7,
              show.legend = FALSE) +
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))

# Histogram example: flipper length by species
ggplot(data = my.penguins, aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), alpha = 0.5, position = "identity") +
  scale_fill_manual(values = c("darkorange","darkorchid","cyan4"))

------------------------------------------------------------------------
install.packages('nortest')
library(nortest)

#make this example reproducible
set.seed(1)

#defined vector of 100 values that are normally distributed
x <- rnorm(my.penguins$body_mass_g, 0, 1)

#conduct Anderson-Darling Test to test for normality
ad.test(x)
  