
suppressPackageStartupMessages({ library(tidyverse); library(broom) })

safe_factor <- function(x, lvls=NULL, ref=NULL) {
  x <- as.factor(x)
  if (!is.null(lvls)) x <- factor(x, levels = lvls)
  if (!is.null(ref) && ref %in% levels(x)) x <- relevel(x, ref = ref)
  x
}

write_table <- function(df, path) {
  readr::write_csv(df, path)
  message("Wrote: ", path)
}

add_age_deciles <- function(df, age_var, out_var="age_deciles") {
  cut_points <- c(10,20,30,40,50,60,70,80,90)
  df[[out_var]] <- cut(df[[age_var]], breaks = cut_points, include_lowest = TRUE, right = TRUE)
  df
}
