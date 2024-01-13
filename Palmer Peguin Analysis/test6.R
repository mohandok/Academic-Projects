install.packages("tidyverse")
install.packages("tidymodels")
library(tidyverse)
library(tidymodels)
library(doParallel)
my.penguins %>%
select(species, body_mass_g, ends_with("_mm"), sex) %>%
GGally::ggpairs(aes(color = sex, alpha = 0.5))

penguins_df <- my.penguins %>%
  filter(!is.na(sex)) %>%
  select(-year, -island)
penguins_df

levels(penguins_df$sex)

set.seed(123)
penguin_split <- initial_split(penguins_df, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)


penguin_cv <- vfold_cv(data = penguin_train, v = 10, repeats = 10, strata = sex)

glm_spec <- logistic_reg() %>%
  set_engine("glm")

penguin_wf <- workflow() %>%
  add_formula(sex ~ .)

doParallel::registerDoParallel()

glm_rs <- penguin_wf %>%
  add_model(glm_spec) %>%
  fit_resamples(
    resamples = penguin_cv,
    control = control_resamples(save_pred = TRUE, verbose = TRUE)
  )

glm_rs

collect_metrics(glm_rs)
------------------------------------------------

g = sns.relplot(data=df, alpha = 0.6,
                x="bill_length_mm", y="bill_depth_mm",
                hue="island", size="body_mass_g",
                palette="Set1", sizes=(40,250),height = 7)

g.despine(left=True, bottom=True) # removes axis spines
g.set_axis_labels("Bill Length", "Bill Depth")
-------------------------------------------------------
install.packages(c("ggplot2", "ggpubr", "tidyverse", "broom", "AICcmodavg"))
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)
one.way <- aov(my.penguins$bill_length_mm ~ my.penguins$body_mass_g, data = my.penguins)

summary(one.way)

-------------------------------------------
pdf<-my.penguins    %>%
  filter(my.penguins$species=="Gentoo")


pdf<-my.penguins %>%
  filter(my.penguins$species=='Gentoo')

qqnorm(pdf$bill_depth_mm, pch = 1, frame = FALSE)
qqline(pdf$bill_depth_mm, xlab = "test x", ylab = "test y",col = "steelblue", lwd = 2)

par(mfrow=c(1,2))

fn <- fitdist(pdf$bill_length_mm,"norm")
denscomp(fn,main = "Histogram with distribution curve for Bill length(mm) 
         of Gentoo species")
qqcomp(fn,main = "Q-Q plot with normal line for Bill length(mm) 
         of Gentoo species")
---------------------------------------------
hist(my.penguins$bill_length_mm, 
       col="green",
       border="black",
       prob = TRUE,
       xlab = "temp",
       main = "GFG")

lines(density(my.penguins$bill_length_mm),
      lwd = 2,
      col = "chocolate3")
------------------------------------------
  ggplot(data=my.penguins, aes(bill_length_mm, bill_depth_mm, colour=species))+
  geom_point()+
  stat_ellipse(level=0.95)+
  theme_custom()
--------------------------------------------
  
  
  
  