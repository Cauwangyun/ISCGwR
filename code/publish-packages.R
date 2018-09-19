# 抓取网页数据
library(rvest)
library(dplyr)
library(zoo)
url <- "https://cran.r-project.org/web/packages/available_packages_by_date.html"
page <- read_html(url)
page %>%
  html_node("table") %>%
  html_table() %>%
  mutate(count = rev(1:nrow(.))) %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(Month = format(Date, format = "%Y-%m")) %>%
  group_by(Month) %>%
  summarise(published = min(count)) %>%
  mutate(Date = as.Date(as.yearmon(Month))) -> pkgs
# 计算自2013年以来R包增长速度
pkgs %>%
  filter(Date > as.Date("2012-12-31")) %>%
  mutate(publishedGrowth = c(tail(.$published, -1), NA) / published) %>%
  mutate(counter = 1:nrow(.)) -> new_pkgs
# 绘图
library(ggplot2)
library(grid)
gg <- ggplot(pkgs, aes(x = Date, y = published)) +
  geom_line(size = 1.5) +
  scale_y_log10(
    breaks = c(0, 10, 100, 1000, 10000),
    labels = c("1", "10", "100", "1.000", "10.000")
  ) +
  labs(
    x = "", y = "# Packages (log)",
    title = "Packages published on CRAN ever since"
  ) +
  theme_minimal(base_size = 14, base_family = "sans") +
  theme(panel.grid.major.x = element_blank()) +
  geom_hline(yintercept = 0, size = 1, colour = "#535353")

gg2 <- ggplot(new_pkgs, aes(x = Date, y = published)) +
  geom_line(size = 1) +
  geom_line(
    data = new_pkgs, aes(y = (min(published) * 1.048^counter)),
    color = "red", size = .7, linetype = 1
  ) +
  annotate("segment",
           x = as.Date("2015-04-01"), xend = as.Date("2015-08-01"),
           y = 1000, yend = 1000, colour = "red", size = 1
  ) +
  annotate("text",
           x = as.Date("2016-12-01"),
           y = 1000, label = "4.6% growth estimation", size = 3.5
  ) +
  scale_y_continuous(
    breaks = seq(from = 0, to = 12000, by = 2000),
    labels = seq(from = 0, to = 12000, by = 2000)
  ) +
  labs(y = "# Packages", x = "", 
       subtitle = "Packages published on CRAN since 2013") +
  theme_minimal(
    base_size = 11, base_family = "sans"
  ) +
  theme(panel.grid.major.x = element_blank()) +
  geom_hline(yintercept = 0, size = .6, colour = "#535353")
pdf(file = "images/publish-packages.pdf", width = 8, height = 6)
gg
print(gg2, vp = viewport(.70, .31, .43, .43))
dev.off()
