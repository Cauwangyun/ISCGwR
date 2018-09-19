# https://mirrors.tuna.tsinghua.edu.cn/CRAN/web/packages/xkcd/vignettes/xkcd-intro.pdf

library(xkcd)

font_import(paths = "ISCGwR/data/", pattern = "[X/x]kcd", prompt = FALSE)
loadfonts()

pdf(file = "ISCGwR/data/xkcd_origin.pdf", family = "xkcd")
ggplot(aes(x = mpg, y = wt), data = mtcars) +
  geom_point() +
  theme(text = element_text(size = 16, family = "xkcd"))
# ggplot(aes(mpg, wt), data = mtcars) + geom_point() +
#   theme_xkcd()
dev.off()

extrafont::embed_fonts("ISCGwR/data/xkcd.pdf", outfile = "ISCGwR/data/xkcd_embed.pdf")
