
# 01_prep.R — baseline filter, factor coding, derived variables -----------------

suppressPackageStartupMessages({
  library(tidyverse); library(yaml); library(janitor); source("R/functions/helpers.R")
})

cfg <- yaml::read_yaml("config/config.yml")
stopifnot(file.exists(cfg$paths$data_csv))

raw <- readr::read_csv(cfg$paths$data_csv, show_col_types = FALSE) |>
  janitor::clean_names()

# baseline subset
baseline_flag <- janitor::make_clean_names(cfg$filters$baseline_flag)
dat0 <- raw |>
  dplyr::filter(.data[[baseline_flag]] == 1)

# standard names
nm <- function(x) janitor::make_clean_names(x)
dat <- dat0 |>
  dplyr::rename(
    patient_id = !!nm(cfg$id_vars$patient_id),
    pain_scale = !!nm(cfg$pain_vars$pain_scale),
    psd        = !!nm(cfg$psd_vars$psd),
    fibcrit    = !!nm(cfg$psd_vars$fibcrit),
    age        = !!nm(cfg$demographics$age),
    sex        = !!nm(cfg$demographics$sex),
    white      = !!nm(cfg$demographics$white),
    bmi        = !!nm(cfg$demographics$bmi),
    edlevel    = !!nm(cfg$demographics$edlevel),
    totincom   = !!nm(cfg$demographics$totincom),
    sxtime     = !!nm(cfg$demographics$sxtime),
    subtype    = !!nm(cfg$demographics$subtype),
    smokeev    = !!nm(cfg$demographics$smokeev)
  )

# derive pain binaries
dat <- dat |>
  dplyr::mutate(
    pain = dplyr::if_else(pain_scale > 0, 1L, 0L),
    significant_pain = dplyr::if_else(pain_scale > 3, 1L, 0L),
    pain_three_level = dplyr::case_when(
      pain_scale > 7 ~ 2L,
      pain_scale >= 4 ~ 1L,
      TRUE ~ 0L
    ),
    fibcrit = as.integer(fibcrit)
  )

# age deciles
dat <- add_age_deciles(dat, "age", out_var = cfg$options$age_deciles_var)

# save
dir.create("outputs", showWarnings = FALSE)
save(dat, file = "outputs/01_baseline_prepped.RData")
message("Saved: outputs/01_baseline_prepped.RData")
