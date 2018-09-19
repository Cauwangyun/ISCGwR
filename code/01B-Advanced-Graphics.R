# ImageMagick 工具组合图形/
# composite faithful_hist_orig.png faithful600_light.jpg faithful_hist.png

# page 67
# 用户交互
# locator 定位图形中点的坐标
# identify 识别图中位置/如点对应的名字/标签
# 其它交互工具 Tk/ggobi

# Grid Graphics 另一套图形系统（可完整替代之前的绘图系统）/不要与标准的图形系统（如前所述）混淆
# lattice 包就是 grid 图形系统的一个具体实例
# 将绘图区域拆分为长方形区域/这些区域可能重叠
# 我们称这个叫 Viewports 视角 rectangular regions (called viewports)
library(grid)
?Grid
apropos("^grid\\.")

# 绘制点、线（线段，直线）等的命令不一样了
# 如设置图形参数的命令 从 par 变成 gpar
grid.rect(gp = gpar(fill = "grey"))

# 新建一个画布、设置背景、创建 viewport
grid.newpage()
grid.rect(gp = gpar(fill = "grey"))
pushViewport(...)
...
popViewport()

# 定义一个视角
viewport(
  w = 0.9, h = 0.9, # width and height
  xscale = c(xmin, xmax),
  yscale = c(ymin, ymax)
)
# 给视角lliu'bian'kong'i留边空
viewport(
  w = 0.9, h = 0.9,
  xscale = c(xmin, xmax) + .05 * c(-1, 1),
  yscale = c(ymin, ymax) + .05 * c(-1, 1)
)

# 举例子 来自手册
library(grid)
grid.show.viewport(viewport(
  x = 0.6, y = 0.6,
  w = unit(1, "inches"), h = unit(1, "inches")
))

# 视角里面包含多张图形
viewport(layout = grid.layout(2, 2))

# 例子来自手册
grid.show.layout(grid.layout(4, 2,
                             heights = unit(
                               rep(1, 4),
                               c("lines", "lines", "lines", "null")
                             ),
                             widths = unit(c(1, 1), "inches")
))


# 例子 新建绘图区域、定义一个新的视角，把它拆分为四份，在每个部分中画图

dessine <- function() {
  pushViewport(viewport(
    w = 0.9, h = 0.9,
    xscale = c(-.1, 1.1), yscale = c(-.1, 1.1)
  ))
  grid.rect(gp = gpar(fill = rgb(.5, .5, 0)))
  grid.points(runif(50), runif(50))
  popViewport()
}
grid.newpage()
grid.rect(gp = gpar(fill = rgb(.3, .3, .3)))
pushViewport(viewport(layout = grid.layout(2, 2)))
for (i in 1:2) {
  for (j in 1:2) {
    pushViewport(viewport(
      layout.pos.col = i,
      layout.pos.row = j
    ))
    dessine()
    popViewport()
  }
}
popViewport()


## 非常像 lattice
grid.multipanel(vp = viewport(0.5, 0.5, 0.8, 0.8))

# 其中包含两个关键函数，值得一看
grid.multipanel
grid.panel


# 另一个例子
# 用 box-and-whiskers plots 代替其中的散点图试试
do.it <- function(x = runif(100), y = runif(100),
                  a = .9, b = .1,
                  col1 = rgb(0, .3, 0), col2 = rgb(1, 1, 0)) {
  xscale <- range(x) + c(-1, 1) * .05
  yscale <- range(y) + c(-1, 1) * .05
  grid.newpage()
  grid.rect(gp = gpar(fill = col1, col = col1))
  w1 <- a - b / 2
  w2 <- 1 - a - b / 2
  c1 <- b / 3 + w1 / 2
  c2 <- a + b / 6 + w2 / 2
  vp1 <- viewport(
    x = c1, y = c1, width = w1, height = w1,
    xscale = xscale, yscale = yscale
  )
  pushViewport(vp1)
  grid.rect(gp = gpar(fill = col2, col = col2))
  grid.points(x, y)
  popViewport()
  vp2 <- viewport(
    x = c1, y = c2, width = w1, height = w2,
    xscale = xscale, yscale = c(0, 1)
  )
  pushViewport(vp2)
  grid.rect(gp = gpar(fill = col2, col = col2))
  grid.points(x, rep(.5, length(x)))
  popViewport()
  vp3 <- viewport(
    x = c2, y = c1, width = w2, height = w1,
    xscale = c(0, 1), yscale = yscale
  )
  pushViewport(vp3)
  grid.rect(gp = gpar(fill = col2, col = col2))
  grid.points(rep(.5, length(y)), y)
  popViewport()
}
do.it()


# xtable 可以转化统计结果为 latex 代码
# 类似地 Hmisc 中有 latex 命令作转化 做表格的神器

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17, 5.58, 5.18, 6.11, 4.50, 4.61, 5.17, 4.53, 5.33, 5.14)
trt <- c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83, 6.03, 4.89, 4.32, 4.69)
group <- gl(2, 10, 20, labels = c("Ctl", "Trt"))
weight <- c(ctl, trt)

library(xtable)
xtable(anova(lm.D9 <- lm(weight ~ group)))
xtable(summary(lm(weight ~ group)))


# lattice  Treillis 是被注册的，所以不能再叫这个名字
# 绘图想法：通过切片的方式展示完整的图形，以三维或更高维的点云为例，
# 将云切成片，截面映射到二维空间，每个截面都可以得到一个图形。
# 具体解释：将目标观察值分组，每组画一个图

library(help = lattice)
library(lattice)
?Lattice
?xyplot

data(quakes)
head(quakes)

library(lattice)
# 按深度分组
Depth <- equal.count(quakes$depth, number = 8, overlap = .1)
xyplot(lat ~ long | Depth, data = quakes)


plot(lat ~ long, data = quakes)

op <- par(mfrow = c(2, 2))
plot(lat ~ long, data = quakes)
plot(lat ~ -depth, data = quakes)
plot(-depth ~ long, data = quakes)
par(op)


library(mva)
biplot(princomp(quakes[1:3]))

pairs(princomp(quakes[1:3])$scores)


library(scatterplot3d)
scatterplot3d(quakes[, 1:3],
  highlight.3d = TRUE,
  pch = 20
)

# 多重组合
data(barley)
head(barley)
barchart(yield ~ variety | year * site, data = barley)

barchart(yield ~ variety | year * site,
  data = barley,
  ylab = "Barley Yield (bushels/acre)",
  scales = list(x = list(0,
    abbreviate = TRUE,
    minlength = 5
  ))
)
# page 90

dotplot(yield ~ variety | year * site, data = barley)
dotplot(variety ~ yield | year * site, data = barley)
data(barley)
## BUG in print_dotplot...
dotplot(variety ~ yield | site,
  groups = year,
  data = barley,
  layout = c(1, 6), aspect = .5, pch = 16,
  col.line = c("grey", "transparent"),
  panel = "panel.superpose",
  panel.groups = "panel.dotplot"
)


library(nlme)
data(bdf)
d <- data.frame(iq = bdf$IQ.perf, sex = bdf$sex, den = bdf$denomina)
d <- d[1:100, ]
bwplot(~d$iq | d$sex + d$den)
histogram(~d$iq | d$sex + d$den)
densityplot(~d$iq | d$sex + d$den)
stripplot(~d$iq | d$sex + d$den)


d <- data.frame(x = bdf$aritPOST, y = bdf$sex, z = equal.count(bdf$langPRET))
bwplot(~x | y + z, data = d)
histogram(~x | y + z, data = d)
densityplot(~x | y + z, data = d)


d <- data.frame(x = (bdf$IQ.perf > 11), y = bdf$sex, z = bdf$denomina)
d <- as.data.frame(table(d))
barchart(Freq ~ x | y * z, data = d)

# 公式语法
# x ~ y Plot x as a function of y (on a single plot)
# x ~ y | z Plots x as a function of y after cutting the data into slices for different values of z
# x ~ y | z1 * z2  Idem, we cut with according the values of (z1,z2)
# x ~ y | z, groups=t Idem, but we use a different symbol (or a different colour) according to the values of t
# But it also works with univariate data
# ~ y
# ~ y | z
# ~ y | z1 * z2
# ~ y | z1 * z2, groups=t

n <- 200
x <- rnorm(n)
y <- x^3 + rnorm(n)
plot1 <- xyplot(y ~ x)
plot2 <- bwplot(x)
# Beware, the order is xmin, ymin, xmax, ymax
print(plot1, position = c(0, .2, 1, 1), more = T)
print(plot2, position = c(0, 0, 1, .2), more = F)


n <- 200
x <- rnorm(n)
y <- x^4 + rnorm(n)
k <- .7
op <- par(mar = c(0, 0, 0, 0))
# Attention : l'ordre est xmin, xmax, ymin, ymax
par(fig = c(0, k, 0, k))
plot(y ~ x)
par(fig = c(0, k, k, 1), new = T)
boxplot(x, horizontal = T)
par(fig = c(k, 1, 0, k), new = T)
boxplot(y, horizontal = F)
par(op)


# 例子

# From the manual
# BUG in print_dotplot...
dotplot(variety ~ yield | site,
  data = barley,
  groups = year,
  panel = function(x, y, subscripts, ...) {
    dot.line <- trellis.par.get("dot.line")
    panel.abline(
      h = y,
      col = dot.line$col,
      lty = dot.line$lty
    )
    panel.superpose(x, y, subscripts, ...)
  },
  key = list(
    space = "right",
    transparent = TRUE,
    points = list(
      pch = trellis.par.get("superpose.symbol")$pch[1:2],
      col = trellis.par.get("superpose.symbol")$col[1:2]
    ),
    text = list(c("1932", "1931"))
  ),
  xlab = "Barley Yield (bushels/acre) ",
  aspect = 0.5,
  layout = c(1, 6),
  ylab = NULL
)

# 查询图形参数设置
str(trellis.par.get())

show.settings()


# 再一个例子

y <- cars$dist
x <- cars$speed
vitesse <- shingle(x, co.intervals(x, number = 6))
histogram(~x | vitesse,
  type = "density",
  panel = function(x, ...) {
    ps <- trellis.par.get("plot.symbol")
    nps <- ps
    nps$cex <- 1
    trellis.par.set("plot.symbol", nps)
    panel.histogram(x, ...)
    panel.densityplot(x, col = "brown", lwd = 3)
    panel.xyplot(x = jitter(x), y = rep(0, length(x)), col = "brown")
    panel.mathdensity(
      dmath = dnorm,
      args = list(mean = mean(x), sd = sd(x)),
      lwd = 3, lty = 2, col = "white"
    )
    trellis.par.set("plot.symbol", ps)
  }
)

apropos("^panel\\.*")
apropos("^prepanel\\.*")


data(sunspot.year)
sunspot <- sunspot.year[20 + 1:37]
xyplot(sunspot ~ 1:37,
  type = "l",
  scales = list(y = list(log = TRUE)),
  sub = "log scales"
)

xyplot(sunspot ~ 1:37,
  type = "l", aspect = "xy",
  scales = list(y = list(log = TRUE)),
  sub = "log scales"
)


# ggplot2
# 基于图形语法 不用在意那些绘图细节如绘制图例
library(ggplot2)
library(ggmap)
# help(hadley)
## hadley 大侠的帅照 Highly unofficial ggplot2 image
# Garrett Grolemund grolemund@gmail.com
pdf(file = "hadley.pdf",width=5,height=8)
ggimage(hadley)
dev.off()

