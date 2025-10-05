
# 05_utilization.R — pain vs utilization & satisfaction ------------------------

suppressPackageStartupMessages({ library(tidyverse); library(yaml); library(broom) })
cfg <- yaml::read_yaml("config/config.yml")
load("outputs/01_baseline_prepped.RData")

# satisfaction (0–4) logistic for pain
if (cfg$healthcare$satisfaction %in% names(dat)) {
  f1 <- as.formula(paste0("pain ~ age + sex + bmi + totincom + ", cfg$healthcare$satisfaction))
  m1 <- glm(f1, data = dat, family = binomial())
  readr::write_csv(broom::tidy(m1, conf.int = TRUE), "outputs/tables/05_glm_pain_satisfaction.csv")
}

# gpvisit (numeric) logistic for pain
if (cfg$healthcare$gpvisit %in% names(dat)) {
  f2 <- as.formula(paste0("pain ~ age + sex + bmi + totincom + ", cfg$healthcare$gpvisit))
  m2 <- glm(f2, data = dat, family = binomial())
  readr::write_csv(broom::tidy(m2, conf.int = TRUE), "outputs/tables/05_glm_pain_gpvisit.csv")
}

# rheumvisit (factor) logistic for pain
if (cfg$healthcare$rheumvisit %in% names(dat)) {
  dat[[cfg$healthcare$rheumvisit]] <- as.factor(dat[[cfg$healthcare$rheumvisit]])
  f3 <- as.formula(paste0("pain ~ age + sex + bmi + totincom + ", cfg$healthcare$rheumvisit))
  m3 <- glm(f3, data = dat, family = binomial())
  readr::write_csv(broom::tidy(m3, conf.int = TRUE), "outputs/tables/05_glm_pain_rheumvisit.csv")
}

# ervisit (factor) logistic for pain
if (cfg$healthcare$ervisit %in% names(dat)) {
  dat[[cfg$healthcare$ervisit]] <- as.factor(dat[[cfg$healthcare$ervisit]])
  f4 <- as.formula(paste0("pain ~ age + sex + bmi + totincom + ", cfg$healthcare$ervisit))
  m4 <- glm(f4, data = dat, family = binomial())
  readr::write_csv(broom::tidy(m4, conf.int = TRUE), "outputs/tables/05_glm_pain_ervisit.csv")
}

message("Utilization models written into outputs/tables/ (if variables present).")
