
# 02_table1.R — descriptive table by pain categories ---------------------------

suppressPackageStartupMessages({
  library(tidyverse); library(yaml); library(table1); library(htmlwidgets)
})

cfg <- yaml::read_yaml("config/config.yml")
load("outputs/01_baseline_prepped.RData")

# Example: Table 1 by pain (0/1)
dat$pain <- factor(dat$pain, levels = c(0,1), labels = c("No pain","Pain > 0"))
tbl <- table1(~ age + bmi + edlevel + totincom + sex + white + smokeev +
                psd + fibcrit + sxtime | pain, data = dat,
              render.missing = NULL, overall = "Total")

# Export an HTML table (lightweight)
html_file <- "outputs/tables/02_table1_pain.html"
dir.create(dirname(html_file), showWarnings = FALSE, recursive = TRUE)
htmlwidgets::saveWidget(as.htmlwidget(tbl), html_file)
message("Wrote: ", html_file)
