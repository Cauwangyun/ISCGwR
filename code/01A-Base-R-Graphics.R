#
# Redefine statistical significance 平生仅见的复杂图形
# 代码见 code_r/advanced-plot.R


library(MASS)
data(beav1)
plot(temp ~ time, data = beav1)

apropos("^plot\\.")
methods(plot)
# 带星号*的方法
plot.histogram
getAnywhere("plot.histogram")
str(getAnywhere("plot.histogram"))
str(getAnywhere("plot.histogram")$objs[[1]])


head(EuStockMarkets)

matplot(time(EuStockMarkets), EuStockMarkets,
  main = "Daily Closing Prices of Major European Stock Indices, 1991–1998\nGermany DAX (Ibis), Switzerland SMI, France CAC, and UK FTSE",
  xlab = "Date", ylab = "closing prices",
  pch = 17, type = "l", col = 1:4
)
legend("topleft", colnames(EuStockMarkets), pch = 17, lty = 1, col = 1:4)


head(longley)

pairs(longley,
  gap = 0,
  diag.panel = function(x, ...) {
    par(new = TRUE)
    hist(x,
      col = "light blue",
      probability = TRUE,
      axes = FALSE,
      main = ""
    )
    lines(density(x),
      col = "red",
      lwd = 3
    )
    rug(x)
  }
)
# 一维云图/点图
stripchart(longley$Unemployed)

hist(longley$Unemployed,
  probability = TRUE, # Change the vertical units,
  # to overlay a density estimation
  col = "light blue"
)
lines(density(longley$Unemployed),
  col = "red",
  lwd = 3
)

hist(longley$Unemployed, density = 3, angle = 45)


boxplot(longley$Unemployed)
# 水平放置
boxplot(longley$Unemployed,
  horizontal = TRUE,
  col = "pink",
  main = "Box-and-whiskers plot (boxplot)"
)

data(InsectSprays)
boxplot(count ~ spray,
  data = InsectSprays,
  col = "pink",
  xlab = "Spray",
  ylab = "Count",
  main = "Insect sprays"
)

boxplot(count ~ spray,
  data = InsectSprays,
  col = "pink",
  horizontal = TRUE,
  las = 1, # Horizontal labels
  xlab = "Count",
  ylab = "Spray",
  main = "Insect sprays"
)

# 等高线图
N <- 50
x <- seq(-1, 1, length = N)
y <- seq(-1, 1, length = N)
xx <- matrix(x, nr = N, nc = N)
yy <- matrix(y, nr = N, nc = N, byrow = TRUE)
z <- 1 / (1 + xx^2 + (yy + .2 * sin(10 * yy))^2)
contour(x, y, z,
  main = "Contour plot"
)
# 热图
image(z)

image(x, y, z,
  xlab = "",
  ylab = ""
)
contour(x, y, z, lwd = 3, add = TRUE)
# 透视图
persp(z)

op <- par(mar = c(0, 0, 3, 0) + .1)
persp(x, y, z,
  theta = 45, phi = 30,
  shade = .5,
  col = rainbow(N),
  border = "green",
  main = "perspective plot, theta=45, phi=30"
)
par(op)

library(sp)
library(raster)
library(spDataLarge)
plot(elevation, asp = NA, main = "Elevation of The Zion National Park Area")
# http://srtm.csi.cgiar.org/SRT-ZIP/SRTM_V41/SRTM_Data_GeoTiff/srtm_14_05.zip
plot(nz_elev, asp = NA, main = "Elevation of The New Zeleand Area")
# https://aws.amazon.com/public-datasets/terrain/
# 添加文本

set.seed(1)
plot.new()
plot.window(xlim = c(0, 1), ylim = c(0, 1))
box()
N <- 50
text(
  runif(N), runif(N),
  sample( # Random words...
    # scan("/usr/share/dict/cracklib-small", character(0)),
    colors(),
    N
  )
)

# 在图的边缘添加文字
N <- 200
x <- runif(N, -4, 4)
y <- sin(x) + .5 * rnorm(N)
plot(x, y,
  xlab = "", ylab = "",
  main = paste(
    "The \"mtext\" function",
    paste(rep(" ", 60), collapse = "")
  )
)
mtext("Line 0", 3, line = 0)
mtext("Line 1", 3, line = 1)
mtext("Line 2", 3, line = 2)
mtext("Line 3", 3, line = 3)

# 图标题/子标题 x轴标题/子标题
N <- 200
x <- runif(N, -4, 4)
y <- sin(x) + .5 * rnorm(N)
plot(x, y, xlab = "", ylab = "", main = "")
mtext("Subtitle", 3, line = .8)
mtext("Title", 3, line = 2, cex = 1.5)
mtext("X axis", 1, line = 2.5, cex = 1.5)
mtext("X axis subtitle", 1, line = 3.7)

# 双Y轴
N <- 200
x <- seq(-4, 4, length = N)
y1 <- sin(x)
y2 <- cos(x)
op <- par(mar = c(5, 4, 4, 4)) # Add some space in the right margin
# The default is c(5,4,4,2) + .1
xlim <- range(x)
ylim <- c(-1.1, 1.1)
plot(x, y1,
  col = "blue", type = "l",
  xlim = xlim, ylim = ylim,
  axes = F, xlab = "", ylab = "", main = "Title"
)
axis(1)
axis(2, col = "blue")
par(new = TRUE)
plot(x, y2,
  col = "red", type = "l",
  xlim = xlim, ylim = ylim,
  axes = F, xlab = "", ylab = "", main = ""
)
axis(4, col = "red")
mtext("First Y axis", 2, line = 2, col = "blue", cex = 1.2)
mtext("Second Y axis", 4, line = 2, col = "red", cex = 1.2)
# 1,2,3,4 分别代表下左上右四个位置



x <- seq(-5, 5, length = 200)
y <- sqrt(1 + x^2)
plot(y ~ x,
  type = "l",
  ylab = expression(sqrt(1 + x^2))
)
title(main = expression(
  "graph of the function f"(x) == sqrt(1 + x^2)
))

# substitute  神奇的函数哦

x <- seq(-5, 5, length = 200)
op <- par(mfrow = c(2, 2))
for (i in 1:4) { # 画四个图
  y <- sqrt(i + x^2)
  plot(y ~ x,
    type = "l",
    ylim = c(0, 6),
    ylab = substitute(
      expression(sqrt(i + x^2)),
      list(i = i)
    )
  )
  title(main = substitute(
    "graph of the function f"(x) == sqrt(i + x^2),
    list(i = i)
  ))
}
par(op)


# 符号

op <- par(mar = c(1, 1, 4, 1) + .1)
plot(0, 0,
  xlim = c(1, 5), ylim = c(-.5, 4),
  axes = F,
  xlab = "", ylab = "",
  main = "Available symbols"
)
for (i in 0:4) {
  for (j in 1:5) {
    n <- 5 * i + j
    points(j, i,
      pch = n,
      cex = 3
    )
    text(j, i - .25, as.character(n))
  }
}
par(op)


# 多图排列/分屏 page 47
# 最常用的是 par mfrow mfcol分别按行/列放置图形

op <- par(mfrow = c(2, 2))
for (i in 1:4)
  plot(runif(20), runif(20),
    main = paste("random plot (", i, ")", sep = "")
  )
par(op)
mtext("Four plots, without enough room for this title",
  side = 3, font = 2, cex = 2, col = "red"
) # 总/大标题放不下

# 设置外边空放置大标题
op <- par(
  mfrow = c(2, 2),
  oma = c(0, 0, 3, 0) # Outer margins
)
for (i in 1:4)
  plot(runif(20), runif(20),
    main = paste("random plot (", i, ")", sep = "")
  )
par(op)
mtext("Four plots, with some room for this title",
  side = 3, line = 1.5, font = 2, cex = 2, col = "red"
)

# 设置每个子图的边空 mar
op <- par(
  mfrow = c(2, 2),
  oma = c(0, 0, 3, 0),
  mar = c(3, 3, 4, 1) + .1 # Margins
)
for (i in 1:4)
  plot(runif(20), runif(20),
    xlab = "", ylab = "",
    main = paste("random plot (", i, ")", sep = "")
  )
par(op)
mtext("Title",
  side = 3, line = 1.5, font = 2, cex = 2, col = "red"
)
par(op)

# par 之 fig 参数 很神奇

n <- 20
x <- rnorm(n)
y <- x^2 - 1 + .3 * rnorm(n)
plot(y ~ x,
  main = "The \"fig\" graphic parameter"
)
op <- par()
for (i in 2:10) {
  done <- FALSE
  while (!done) {
    a <- c(
      sort(runif(2, 0, 1)),
      sort(runif(2, 0, 1))
    )
    par(fig = a, new = T)
    r <- try(plot(runif(5), type = "l", col = i))
    done <- !inherits(r, "try-error")
  }
}
par(op)


# fig 参数控制图形的位置 属于组合图形

n <- 1000
x <- rt(n, df = 10)
hist(x,
  col = "light blue",
  probability = "TRUE",
  ylim = c(0, 1.2 * max(density(x)$y))
)
lines(density(x),
  col = "red",
  lwd = 3
)
op <- par(
  fig = c(.02, .4, .5, .98),
  new = TRUE
)
qqnorm(x,
  xlab = "", ylab = "", main = "",
  axes = FALSE
)
qqline(x, col = "red", lwd = 2)
box(lwd = 2)
par(op)


# layout 布局 用于复杂组合图形

op <- par(oma = c(0, 0, 3, 0))
layout(matrix(c(
  1, 1, 1,
  2, 3, 4,
  2, 3, 4
), nr = 3, byrow = TRUE))
hist(rnorm(n), col = "light blue")
hist(rnorm(n), col = "light blue")
hist(rnorm(n), col = "light blue")
hist(rnorm(n), col = "light blue")
mtext("The \"layout\" function",
  side = 3, outer = TRUE,
  font = 2, cex = 1.2
)
par(op)


# 真的分屏函数 split.screen

random.plot <- function() {
  N <- 200
  f <- sample(
    list(
      rnorm,
      function(x) {
        rt(x, df = 2)
      },
      rlnorm,
      runif
    ),
    1
  ) [[1]]
  x <- f(N)
  hist(x, col = "lightblue", main = "", xlab = "", ylab = "", axes = F)
  axis(1)
}
op <- par(bg = "white", mar = c(2.5, 2, 1, 2))
split.screen(c(2, 1))
split.screen(c(1, 3), screen = 2)
screen(1)
random.plot()
# screen(2); random.plot() # Screen 2 was split into three screens: 3, 4, 5
screen(3)
random.plot()
screen(4)
random.plot()
screen(5)
random.plot()
close.screen(all = TRUE)
par(op)

# 覆盖图形 add = T or par(new=TRUE)

plot(runif(5), runif(5),
  xlim = c(0, 1), ylim = c(0, 1)
)
points(runif(5), runif(5),
  col = "orange", pch = 16, cex = 3
)
lines(runif(5), runif(5), col = "red")
segments(runif(5), runif(5), runif(5), runif(5),
  col = "blue"
)
title(main = "Overlaying points, segments, lines...")

# 例子 密度估计

library(MASS)
data(galaxies)
galaxies <- galaxies / 1000
# Bandwidth Selection by Pilot Estimation of Derivatives
c(width.SJ(galaxies, method = "dpi"), width.SJ(galaxies))
# 3.256151 2.566423

plot(
  x = c(5, 40), y = c(0, 0.2), type = "n", bty = "l",
  xlab = "velocity of galaxy (km/s)", ylab = "density"
)
rug(galaxies)
lines(density(galaxies, width = 3.25, n = 200), col = "blue", lty = 1)
lines(density(galaxies, width = 2.56, n = 200), col = "red", lty = 3)


# 黎曼函数
# eta 函数 gammaz 函数
library(pracma)
##  First zero on the critical line s = 0.5 + i t
x <- seq(0, 20, len = 1001)
z <- 0.5 + x * 1i
fr <- Re(zeta(z))
fi <- Im(zeta(z))
fa <- abs(zeta(z))
plot(x, fa,
  type = "n", xlim = c(0, 20), ylim = c(-1.5, 2.5),
  xlab = "Imaginary part (on critical line)", ylab = "Function value",
  main = "Riemann's Zeta Function along the critical line"
)
grid()
lines(x, fr, col = "blue")
lines(x, fi, col = "darkgreen")
lines(x, fa, col = "red", lwd = 2)
points(14.1347, 0, col = "darkred")
legend(0, 2.4, c("real part", "imaginary part", "absolute value"),
  lty = 1, lwd = c(1, 1, 2), col = c("blue", "darkgreen", "red")
)


## 区域重叠 polygon 函数
my.col <- function(f, g, xmin, xmax, col, N = 200,
                   xlab = "", ylab = "", main = "") {
  x <- seq(xmin, xmax, length = N)
  fx <- f(x)
  gx <- g(x)
  plot(0, 0,
    type = "n",
    xlim = c(xmin, xmax),
    ylim = c(min(fx, gx), max(fx, gx)),
    xlab = xlab, ylab = ylab, main = main
  )
  polygon(c(x, rev(x)), c(fx, rev(gx)),
    col = "red", border = 0
  )
  lines(x, fx, lwd = 3, col = "green")
  lines(x, gx, lwd = 3, col = "blue")
}
op <- par(mar = c(3, 3, 4, 1) + .1)
my.col(function(x) x^2, function(x) x^2 + 10 * sin(x),
  -6, 6,
  main = "The \"polygon\" function"
)
par(op)


## 区域重叠 累积分布函数

x <- seq(from = 110, to = 174, by = 0.5)
y1 <- dnorm(x, mean = 145, sd = 9)
y2 <- dnorm(x, mean = 138, sd = 8)
plot(x, y1,
  type = "l", lwd = 2, col = "red",
  main = "Systolic Blood Pressure Before and After Treatment",
  xlab = "Systolic Blood Pressure (mmHg)",
  ylab = "Frequency", yaxt = "n",
  xlim = c(110, 175), ylim = c(0, 0.05)
)
lines(x, y2)
polygon(c(110, x, 175), c(0, y2, 0),
  col = "firebrick3",
  border = "white"
)
polygon(c(117, x, 175), c(0, y1, 0),
  col = "dodgerblue4",
  border = "white"
)
ylab <- c(seq(from = 0, to = 175, by = 25))
y <- c(seq(from = 0, to = 0.05, length.out = 8))
axis(2, at = y, labels = ylab, las = 1)
text(x = 120, y = 0.045, "- Pre-Treatment BP", col = "dodgerblue4", cex = 0.9)
text(x = 120, y = 0.04, " - Post-Treatment BP", col = "firebrick3", cex = 0.9)
points(109, 0.0445, pch = 15, col = "dodgerblue4")
points(109, 0.0395, pch = 15, col = "firebrick3")

# From the manual
ch.col <- c(
  "rainbow(n, start=.7, end=.1)",
  "heat.colors(n)",
  "terrain.colors(n)",
  "topo.colors(n)",
  "cm.colors(n)"
) # 选择颜色
n <- 16
nt <- length(ch.col)
i <- 1:n
j <- n / nt
d <- j / 6
dy <- 2 * d
plot(i, i + d,
  type = "n",
  yaxt = "n",
  ylab = "",
  main = paste("color palettes; n=", n)
)
for (k in 1:nt) {
  rect(i - .5, (k - 1) * j + dy, i + .4, k * j,
    col = eval(parse(text = ch.col[k]))
  ) # 咬人的函数/字符串解析为/转函数
  text(2 * j, k * j + dy / 4, ch.col[k])
}


# 添加图例
# 三角函数
x <- seq(-6, 6, length = 200)
y <- sin(x)
z <- cos(x)
plot(y ~ x,
  type = "l", lwd = 3,
  ylab = "", xlab = "angle", main = "Trigonometric functions"
)
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
lines(z ~ x, type = "l", lwd = 3, col = "red")
legend(-6, -1,
  yjust = 0,
  c("Sine", "Cosine"),
  lwd = 3, lty = 1, col = c(par("fg"), "red")
)

# 设置图例的位置
xmin <- par("usr")[1]
xmax <- par("usr")[2]
ymin <- par("usr")[3]
ymax <- par("usr")[4]

plot(y ~ x,
  type = "l", lwd = 3,
  ylab = "", xlab = "angle", main = "Trigonometric functions"
)
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
lines(z ~ x, type = "l", lwd = 3, col = "red")
legend("bottomleft",
  c("Sine", "Cosine"),
  lwd = 3, lty = 1, col = c(par("fg"), "red")
)

# insert 很有意思 微调图例位置
plot(y ~ x,
  type = "l", lwd = 3,
  ylab = "", xlab = "angle", main = "Trigonometric functions"
)
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
lines(z ~ x, type = "l", lwd = 3, col = "red")
legend("bottomleft",
  c("Sine", "Cosine"),
  inset = c(.03, .03),
  lwd = 3, lty = 1, col = c(par("fg"), "red")
)

# 将图例放在绘图区域外面
op <- par(no.readonly = TRUE)
plot(y ~ x,
  type = "l", lwd = 3,
  ylab = "", xlab = "angle", main = "Trigonometric functions"
)
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
lines(z ~ x, type = "l", lwd = 3, col = "red")
par(xpd = TRUE) # Do not clip to the drawing area 关键一行/允许出界
lambda <- .025
legend(par("usr")[1],
  (1 + lambda) * par("usr")[4] - lambda * par("usr")[3],
  c("Sine", "Cosine"),
  xjust = 0, yjust = 0,
  lwd = 3, lty = 1, col = c(par("fg"), "red")
)
par(op)

# labcurve in Hmisc to put the name of the curve on the
# curve (and not in a remote legend)
# 可以在曲线上放置名字/而不是遥远的图例上
library(Hmisc)
?labcurve

# 在图形上添加网格线
?grid

