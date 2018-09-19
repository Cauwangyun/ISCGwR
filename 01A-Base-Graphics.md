
# 基础图形 {#Base-Graphics}

数据可视化是一种重要的数据分析手段，Claus O. Wilke 目前正在写《Fundamentals of Data Visualization》，并且给出了在线网络版^[<https://serialmentor.com/dataviz/>]。 

1996年R语言横空出世 [@Ross1996] 带数学符号的注释 [@Paul2000]

结合统计意义和探索性数据分析介绍各种常见统计图形

plot 函数对象

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/plot-1} 

}

\caption{plot函数对象}(\#fig:plot)
\end{figure}

在介绍各种统计图形之前，先介绍几个绘图函数 `plot` 和 `text` 还有 `par` 参数设置， 作为最简单的开始， 尽量依次介绍其中的每个参数的含义并附上图形对比。


```r
x <- 1:4
y <- x
plot(x, y, ann = F, col = "blue", pch = 16)
text(x, y,
  labels = c("1st", "2nd", "3rd", "4th"),
  col = "red", pos = c(3, 4, 4, 1), offset = 0.6
)
```



\begin{center}\includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/pos-1} \end{center}

其中 labels， pos 都是向量化的参数

## 散点图 {#scatter-chart}

散点图（点图），抖动图（箱线图），一维的二维的

高亮某些点，按类别绘散点图^[<https://stackoverflow.com/questions/51804892/use-vectorized-plotting-arguments-when-plotting-by-factor-in-r>]


```r
data("iris")
pch <- rep(16, length(iris$Petal.Length))
pch[which(iris$Petal.Length < 1.4)] <- 17
stripchart(Petal.Length ~ Species,
  data = iris,
  vertical = TRUE, method = "jitter",
  pch = pch
)
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/wrong-scatter-1} 

}

\caption{错误的散点图画法}(\#fig:wrong-scatter)
\end{figure}


```r
methods(stripchart)
getAnywhere(stripchart.default)
getAnywhere(xy.coords)
```
	   
pch 没有向量化 实际只是取了前三个值 16 16 17 对应于 Species 的三类  

高亮某些点  关键是高亮的分界点是由区分意义的


```r
data("iris")
stripchart(Petal.Length ~ Species,
  data = iris, subset = Petal.Length > 1.4,
  vertical = TRUE, method = "jitter", ylim = c(1, 7),
  pch = 16
)
stripchart(Petal.Length ~ Species,
  data = iris, subset = Petal.Length < 1.4,
  vertical = TRUE, method = "jitter", add = TRUE,
  pch = 17
)
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/right-scatter-1} 

}

\caption{正确的散点图}(\#fig:right-scatter)
\end{figure}




## 折线图 {#line-chart}

应用：时序图

## 条形图 {#bar-chart}

条形图

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/ISLR-1} 

}

\caption{条形图}(\#fig:ISLR)
\end{figure}


应用：
自协方差、自相关、偏自相关、协相关和协方差图，



## 直方图 {#hist}


```r
with(data = faithful, {
  hist(eruptions, seq(1.6, 5.2, 0.2), prob = TRUE)
  lines(density(eruptions, bw = 0.1))
  rug(eruptions) # show the actual data points
})
```



\begin{center}\includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/eruptions-1} \end{center}


## 经验累积分布图 {#ecdf}


```r
with(data = faithful, {
  long <- eruptions[eruptions > 3]
  plot(ecdf(long), do.points = FALSE, verticals = TRUE)
  x <- seq(3, 5.4, 0.01)
  lines(x, pnorm(x, mean = mean(long), sd = sqrt(var(long))), lty = 3)
})
```



\begin{center}\includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/faithful-1} \end{center}

## QQ 正态分布图 {#qqnorm}


```r
with(data = faithful, {
  long <- eruptions[eruptions > 3]
  par(pty = "s") # arrange for a square figure region
  qqnorm(long)
  qqline(long)
})
```



\begin{center}\includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/faithful-eruptions-1} \end{center}

## 箱线图 {#boxplot}


```r
A <- c(79.98, 80.04, 80.02, 80.04, 80.03, 80.03, 80.04, 79.97,
       80.05, 80.03, 80.02, 80, 80.02)
B <- c(80.02, 79.94, 79.98, 79.97, 79.97, 80.03, 79.95, 79.97)
boxplot(A, B)
```



\begin{center}\includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/boxplot-1} \end{center}


```r
with(data = iris, {
  op <- par(mfrow = c(2, 2), mar = c(4, 4, 2, .5))
  plot(Sepal.Length ~ Species)
  plot(Sepal.Width ~ Species)
  plot(Petal.Length ~ Species)
  plot(Petal.Width ~ Species)
  par(op)
  mtext("Edgar Anderson's Iris Data", side = 3, line = 4)
})
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/iris-1} 

}

\caption{安德森的鸢尾花数据}(\#fig:iris)
\end{figure}

## 等高线图 {#contour-lines}

contour

## 透视图 {#perspective-plots}

persp
多元分布函数图像

## 热图 {#images}

image

应用：heatmap, raster 图像

## 树图 {#dendrogram}

dendrogram

层次聚类/分类/回归树

## 图形参数 {#graphical-parameters}

`par()` 图形版面设置

## 数学注释 {#math-annotation}

数学符号注释，图\@ref(fig:math-annotation) 自定义坐标轴 [@Paul2000]。


```r
# 自定义坐标轴
plot(c(1, 1e6), c(-pi, pi), type = "n", 
     axes = FALSE, ann = FALSE, log = "x")
axis(1, at = c(1, 1e2, 1e4, 1e6), 
     labels = expression(1, 10^2, 10^4, 10^6))
axis(2, at = c(-pi, -pi / 2, 0, pi / 2, pi), 
     labels = expression(-pi, -pi / 2, 0, pi / 2, pi))
text(1e3, 0, expression(italic("Customized Axes")))
box()
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/math-annotation-1} 

}

\caption{Creating Customized Axes With Suitable Annotation}(\#fig:math-annotation)
\end{figure}


## 旋转坐标抽标签 {#rotated-axis-labels}

旋转坐标抽标签的例子来自手册《R FAQ》的第7章第27个问题 [@R-FAQ]，在基础图形中，旋转坐标轴标签需要 `text()` 而不是 `mtext()`，因为后者不支持`par("srt")` 


```r
## Increase bottom margin to make room for rotated labels
par(mar = c(5, 4, .5, 2) + 0.1)
## Create plot with no x axis and no x axis label
plot(1 : 8, xaxt = "n",  xlab = "")
## Set up x axis with tick marks alone
axis(1, labels = FALSE)
## Create some text labels
labels <- paste("Label", 1:8, sep = " ")
## Plot x axis labels at default tick marks
text(1:8, par("usr")[3] - 0.5, srt = 45, adj = 1,
     labels = labels, xpd = TRUE)
## Plot x axis label at line 6 (of 7)
mtext(side = 1, text = "X Axis Label", line = 4)
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/rotate-axis-labels-1} 

}

\caption{旋转坐标轴标签}(\#fig:rotate-axis-labels)
\end{figure}

`srt = 45` 表示文本旋转角度， `xpd = TRUE` 允许文本越出绘图区域，`adj = 1` to place the right end of text at the tick marks；You can adjust the value of the 0.5 offset as required to move the axis labels up or down relative to the x axis.

## 双纵轴 {#double-y-axis}

How to plot multiple time series plots in a grid, where each plot has two y axes? <https://stackoverflow.com/questions/52082801>


```r
library(ggplot2)
dd <- data.frame(
  x = 1:11, y = c(rnorm(22),rpois(22,5)),
  id = gl(2, 11, labels = paste0("ser", 1:2)),
  panel = gl(2, 22, labels = c("norm","pois"))
)
# 设置左手刻度为 norm 右手刻度为 pois
ggplot(dd, aes(x, y, col = panel)) +
  geom_line() +
  facet_wrap(~id) +
  scale_y_continuous(sec.axis = sec_axis(~.))
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{01A-Base-Graphics_files/figure-latex/two-axis-1} 

}

\caption{双纵轴时间序列}(\#fig:two-axis)
\end{figure}


