library(tidymodels)
my.penguins %>%
  ggplot(aes(bill_depth_mm, bill_length_mm, size = body_mass_g)) +
  geom_point(aes(color = sex), alpha = 0.5, show.legend = FALSE) +
  geom_text(aes(label = if_else(is.na(sex),"X","")), size = 12)+
  # viridis::scale_color_viridis(discrete = TRUE, direction = -1, option = "D", na.value = 'black')+
  facet_wrap(~species) +
  theme_bw()+
  theme(plot.title.position = "plot")+
  labs(title = "Palmer Penguins with those Missing Gender as X")

sex <- my.penguins %>%
  filter(!is.na(sex)) %>%
  select(-year, -island)

penguin_split <- initial_split(sex, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)

penguin_boot <- bootstraps(penguin_train)
penguin_boot

glm_spec <- logistic_reg() %>%
  set_engine("glm")

glm_spec

penguin_wf <- workflow() %>%
  add_formula(sex ~ .)

penguin_wf

glm_rs <- penguin_wf %>%
  add_model(glm_spec) %>%
  fit_resamples(
    resamples = penguin_boot,
    control = control_resamples(save_pred = TRUE)
  )

glm_rs

rf_spec <- rand_forest() %>%
  set_mode("classification") %>%
  set_engine("ranger")

rf_spec

rf_rs <- penguin_wf %>%
  add_model(rf_spec) %>%
  fit_resamples(
    resamples = penguin_boot,
    control = control_resamples(save_pred = TRUE)
  )

rf_rs

collect_metrics(glm_rs)


collect_metrics(glm_rs)


glm_rs %>%
  collect_predictions() %>%
  group_by(id) %>%
  roc_curve(sex, .pred_female) %>%
  ggplot(aes(1 - specificity, sensitivity, color = id)) +
  geom_abline(lty = 2, color = "gray80", size = 1.5) +
  geom_path(show.legend = FALSE, alpha = 0.6, size = 1.2) +
  coord_equal()+
  theme(plot.title.position = "plot")+
  labs(title = "GLM Model Receiver Operating Characteristic Curve")


penguin_final <- penguin_wf %>%
  add_model(glm_spec) %>%
  last_fit(penguin_split)

penguin_final

collect_metrics(penguin_final)

collect_predictions(penguin_final) %>%
  conf_mat(sex, .pred_class)

penguin_final$.workflow[[1]] %>%
  tidy(exponentiate = TRUE)