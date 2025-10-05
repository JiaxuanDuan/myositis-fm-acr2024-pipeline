
# 03_prevalence_chisq.R — prevalence & chi-square tests ------------------------

suppressPackageStartupMessages({ library(tidyverse); library(yaml) })
cfg <- yaml::read_yaml("config/config.yml")
load("outputs/01_baseline_prepped.RData")

# helpers
chisq_wrap <- function(x, y) {
  tab <- table(x, y, useNA = "no")
  if (all(dim(tab) > 1)) {
    test <- suppressWarnings(chisq.test(tab))
    tibble(var = deparse(substitute(y)), p.value = unname(test$p.value))
  } else tibble(var = deparse(substitute(y)), p.value = NA_real_)
}

cats <- c(cfg$comorbidities, cfg$demographics$sex, cfg$demographics$white, cfg$demographics$smokeev)
cats <- unique(cats)
cats <- cats[cats %in% names(dat)]

res_pain <- purrr::map_dfr(cats, ~chisq_wrap(dat$pain, dat[[.x]]))
res_sig  <- purrr::map_dfr(cats, ~chisq_wrap(dat$significant_pain, dat[[.x]]))

readr::write_csv(res_pain, "outputs/tables/03_chisq_pain.csv")
readr::write_csv(res_sig,  "outputs/tables/03_chisq_significant_pain.csv")
message("Wrote chisq summaries to outputs/tables/")
