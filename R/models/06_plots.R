
# 06_plots.R — simple pain distribution plots ----------------------------------

suppressPackageStartupMessages({ library(tidyverse); library(yaml) })
cfg <- yaml::read_yaml("config/config.yml")
load("outputs/01_baseline_prepped.RData")

p <- ggplot(dat, aes(x = pain_scale)) +
  geom_histogram(binwidth = 1, boundary = 0, closed = "left") +
  labs(x = "Pain scale (0–10)", y = "Count", title = "Distribution of pain scale")
dir.create("outputs/figures", showWarnings = FALSE, recursive = TRUE)
ggsave("outputs/figures/06_pain_hist.png", p, width = 7, height = 5, dpi = 150)
message("Wrote: outputs/figures/06_pain_hist.png")
