# Choose Which Package to Use

install.packages("formattable")
devtools::install_github("ropenscilabs/packagemetrics")

library(formattable)
library(packagemetrics)
library(dplyr)

address <- sprintf("%s/web/packages/packages.rds", getOption("repos")["CRAN"])
con <- url(address, "rb")
pdb <- as.data.frame(readRDS(gzcon(con)), stringsAsFactors = FALSE)
close(con)

packages <- subset(pdb, Maintainer == maintainer("rmarkdown"), select = "Package")

pd <- apply(packages, 1, combine_metrics) %>%
  data.table::rbindlist() %>%
  select(
    package, published, dl_last_month,
    stars, forks, last_commit,
    depends_count, watchers
  ) %>%
  mutate(last_commit = round(last_commit, 1))

pd[is.na(pd)] <- ""

formattable(pd, list(
  package = formatter("span",
    style = x ~ style(font.weight = "bold")
  ),
  contributors = color_tile("white", "#1CC2E3"),
  depends_count = color_tile("white", "#1CC2E3"),
  reverse_count = color_tile("white", "#1CC2E3"),
  tidyverse_happy = formatter("span",
    style = x ~ style(color = ifelse(x, "purple", "white")),
    x ~ icontext(ifelse(x, "glass", "glass"))
  ),
  vignette = formatter("span",
    style = x ~ style(color = ifelse(x, "green", "white")),
    x ~ icontext(ifelse(x, "ok", "ok"))
  ),
  has_tests = formatter("span",
    style = x ~ style(color = ifelse(x, "green", "red")),
    x ~ icontext(ifelse(x, "ok", "remove"))
  ),
  dl_last_month = color_bar("#56A33E"),
  forks = color_tile("white", "#56A33E"),
  stars = color_tile("white", "#56A33E"),
  last_commit = color_tile("#F06B13", "white", na.rm = T)
))

webshot::webshot(url = "http://localhost:16977/session/viewhtml150c673821fc/index.html",file = "figures/packages.png")

# ggplot2 生态
grep('^(gg)', .packages(T), value = TRUE)
