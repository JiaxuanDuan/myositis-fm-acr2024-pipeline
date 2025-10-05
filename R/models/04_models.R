
# 04_models.R — determinants of pain and PSD ----------------------------------

suppressPackageStartupMessages({ library(tidyverse); library(yaml); library(broom) })
cfg <- yaml::read_yaml("config/config.yml")
load("outputs/01_baseline_prepped.RData")

covars <- c("age","sxtime","subtype","sex","white","smokeev","bmi","edlevel","totincom")
covars <- covars[covars %in% names(dat)]

# Logistic: pain ~ covariates
f_pain <- as.formula(paste0("pain ~ ", paste(covars, collapse = " + ")))
glm_pain <- glm(f_pain, data = dat, family = binomial())
readr::write_csv(broom::tidy(glm_pain, conf.int = TRUE), "outputs/tables/04_glm_pain.csv")

# Linear: pain_scale ~ covariates
f_ps <- as.formula(paste0("pain_scale ~ ", paste(covars, collapse = " + ")))
lm_pain_scale <- lm(f_ps, data = dat)
readr::write_csv(broom::tidy(lm_pain_scale, conf.int = TRUE), "outputs/tables/04_lm_pain_scale.csv")

# Logistic: fibcrit ~ covariates
f_fib <- as.formula(paste0("fibcrit ~ ", paste(covars, collapse = " + ")))
glm_fib <- glm(f_fib, data = dat, family = binomial())
readr::write_csv(broom::tidy(glm_fib, conf.int = TRUE), "outputs/tables/04_glm_fibcrit.csv")

# Linear: psd ~ covariates (+ global severity if present)
covars_psd <- unique(c(covars, "glb_severity"))
covars_psd <- covars_psd[covars_psd %in% names(dat)]
f_psd <- as.formula(paste0("psd ~ ", paste(covars_psd, collapse = " + ")))
lm_psd <- lm(f_psd, data = dat)
readr::write_csv(broom::tidy(lm_psd, conf.int = TRUE), "outputs/tables/04_lm_psd.csv")

message("Model summaries written into outputs/tables/")
