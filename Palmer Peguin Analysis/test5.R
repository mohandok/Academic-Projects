bill_dens_group <- ggplot(data = my.penguins,
                          mapping = aes(x = bill_length_mm, group=sex))

bill_dens_group +
  geom_density(mapping = aes(fill = sex),
               alpha = 0.3)

ggplot(my.penguins, aes(x = bill_depth_mm  , y = bill_length_mm , color = species))+
  geom_point() +
  labs(
    title = "                                                    Bill depth and length",
    subtitle = "                                    Measurements for Adelie, Chinstrap, and Gentoo penguins",
    x = "Bill depth (mm)", y = "Bill length(mm)",
    legend = "Species",
    caption = "Source: Palmer Station (LTER) | palmerpenguins R package"
  ) +
  scale_color_brewer(palette = "Set2")


ggplot(data=my.penguins, aes(x = bill_length_mm, fill=sex) +
  geom_density()+
  scale_fill_manual(values=c("orange2", "indianred2"))+
  xlab("Bill length(mm)")+
  labs(title = "                                Distribution plot With Bill length(mm)")
  
--------------------------------------------------------------------------
p<-ggplot(df, aes(x=bill_length_mm, fill=sex)) +
  geom_density(alpha=0.4)
p
# Add mean lines
p+geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")
------------------------------------------------------------------

ggplot(my.penguins, aes(x=bill_depth_mm)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") 
# Color by groups
ggplot(my.penguins, aes(x=bill_depth_mm, color=sex, fill=sex)) + 
  geom_histogram(aes(y=..density..), alpha=0.5, 
                 position="identity")+
  geom_density(alpha=.2) 
-----------------------------------------------------------------
  penguins %>%
  select(species, body_mass_g, ends_with("_mm")) %>% 
  GGally::ggpairs(aes(color = species),
                  columns = c("flipper_length_mm", "body_mass_g", 
                              "bill_length_mm", "bill_depth_mm")) +
  scale_colour_manual(values = c("darkorange","purple","cyan4")) +
  scale_fill_manual(values = c("darkorange","purple","cyan4"))
-----------------------------------------------------------------
  penguins %>%
  select(species, body_mass_g, ends_with("_mm")) %>% 
  GGally::ggpairs(aes(color = species),
                  columns = c("flipper_length_mm")) +
  scale_colour_manual(values = c("darkorange","purple","cyan4")) +
  scale_fill_manual(values = c("darkorange","purple","cyan4"))
----------------------------------------------------------------
plot_1 <- ggplot(data = my.penguins, aes(x = flipper_length_mm)) +
geom_point(data = my.penguins, 
           aes(x = flipper_length_mm, y = body_mass_g, colour = species))+
scale_colour_manual(values = c("orange", "purple", "cyan4"))+
labs(x = "Flipper length (mm)", y = "Body mass (g)")
--------------------------------------------------------------

bill_dens_group <- ggplot(data = my.penguins,
                          mapping = aes(x = bill_length_mm, group=species))  
bill_dens_group +
geom_density(mapping = aes(fill = sex),
             alpha = 0.3)
-------------------------------------------------------------
  install.packages("palmerpenguins") # You only need to do this once
library(palmerpenguins)
data("penguins")
penguins = na.omit(penguins) # Removes missing rows
  my.student.number = 220488118 # Replace this with your student number
set.seed(my.student.number)
my.penguins = penguins[sample(nrow(penguins), 100), ]

--------------------------------------------------------------------------   
  Gf<-my.penguins %>%
  filter(my.penguins$species=="Gentoo")
library(ggplot2)
  ggplot(my.penguins, aes(x = body_mass_g,
                       y = flipper_length_mm)) +
  geom_point(aes(color = sex)) +
  scale_color_manual(values = c("magenta","blue"), 
                     na.translate = FALSE) +
    facet_wrap(~species)+
  labs(title="                       Difference in Bill depth (mm) with Body mass (g) for each species (Grouped by sex)",x = "Body mass (g)", y = "bill depth (mm)")
-------------------------------------------------------------
  ggplot(data = my.penguins,
         mapping = aes(x = species, y = flipper_length_mm,
                       color = sex)) +
  stat_summary(position = position_dodge(width = 0.3))+
  labs(y = "Flipper length (mm)")
-------------------------------------------------------------
  my.penguins %>%
    filter(!is.na(sex)) %>%
    ggplot(aes(flipper_length_mm,bill_length_mm , color = species, size = body_mass_g)) +
    geom_point(alpha = 0.5) +
  facet_wrap(~island)+
  labs(x = "Flipper length (mm)", 
  y = "Bill length (mm)", 
  title = "                                    Physical characteristics of penguins between islands")
------------------------------------------------------------
  library(tidyverse)
my.penguins %>% 
  count(species)
my.penguins %>% 
  group_by(species) %>% 
  summarize(across(where(is.numeric), mean,median,sd, na.rm = TRUE))
-------------------------------------------------------------
  library(tidyverse)
library(palmerpenguins)

my.penguins %>%
  ggplot(aes(flipper_length_mm, bill_length_mm,
             color = species,
             shape = sex)) +
  geom_point(size = 2.5) +
  geom_smooth(aes(group = species), method = "lm", se = FALSE,
              show.legend = FALSE) +
  labs(x = "Flipper length [mm]",
       y = "Bill length [mm]",
       title = "Penguins!",
       subtitle = "The 3 penguin species can be differentiated by their flipper- and bill-lengths.",
       color = "Species",
       shape = "Sex") +
  theme_minimal() +
  scale_color_brewer(type = "qual") +
  theme(plot.caption = element_text(hjust = 0))

-----------------------------------------------------------------
  flipper_box <- ggplot(data = my.penguins, aes(x = species, y = flipper_length_mm)) +
  geom_boxplot(aes(color = species), width = 0.3, show.legend = FALSE) +
  geom_jitter(aes(color = species), alpha = 0.5, show.legend = FALSE, position = position_jitter(width = 0.2, seed = 0)) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(x = "Species",
       y = "Flipper length (mm)")
flipper_box

------------------------------------------------------------------
install.packages("tidymodels")
library(tidymodels)


penguin_split <- initial_split(my.penguins, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)


rf_spec <- rand_forest() %>%
  set_mode("classification") %>%
  set_engine("ranger")

rf_spec

collect_metrics(rf_spec)
------------------------------------------------
  ggplot(my.penguins, aes(x)) +
  geom_histogram(binwidth = 0.1) +
  geom_line(data = my.penguins, aes(y = y * 0.1, colour = distr)) +
  facet_grid(row ~ col)
-------------------------------------------------
  library(RColorBrewer)

  op <- par(mfrow=c(1,2), mar=c(5,6,4,2))

boxplot(my.penguins$bill_length_mm ~ species, data=my.penguins,
        main="Bill length Box Plot analysis",
        ylab="Bill Length", cex.lab=2, cex.axis=1.5, cex.main=2, col = brewer.pal(n = 3, name = "Pastel2"))

boxplot(my.penguins$bill_depth_mm ~ species, data=my.penguins,
        main="Bill depth Box Plot analysis",
        ylab="Bill Depth", cex.lab=2, cex.axis=1.5, cex.main=2, col = brewer.pal(n = 3, name = "Pastel2"))

boxplot(my.penguins$flipper_length_mm ~ species, data=my.penguins,
        main="Flipper Length Box Plot analysis",
        ylab="Flipper Length", cex.lab=2, cex.axis=1.5, cex.main=2, col = brewer.pal(n = 3, name = "Pastel2"))

boxplot(my.penguins$body_mass_g ~ species, data=my.penguins,
        main="Body Mass Box Plot analysis",
        ylab="Body Mass", cex.lab=2, cex.axis=1.5, cex.main=2, col = brewer.pal(n = 3, name = "Pastel2"))

