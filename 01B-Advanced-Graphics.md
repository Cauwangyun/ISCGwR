
# 高级图形 {#Advanced-Graphics}

2010 年 Hadley基于图形语法开发了 ggplot 包，随后一直保持维护和开发，在2015年进行重构，推出ggplot2，经过几年的发展，现已进入软件开发的稳定阶段。

\begin{figure}

{\centering \includegraphics[width=0.45\linewidth]{images/hadley} 

}

\caption{Hadley Wickham 的帅照}(\#fig:hadley-photo)
\end{figure}

介绍 grid 绘图系统，特别是 ggplot2 包

图形语法，图层，点线，映射，统计

## ggplot2 {#grammar-of-graphics} 

图形语法


### 生态 {#eco}


```r
grep('^(gg)', .packages(T), value = TRUE)
#> [1] "ggplot2"
```


## 动态图形 {#dynamic-graphics}

一类由静态图形合成为 gif, avi, svg  等，一类面向特定输出设备的动态图形，基于JavaScript库的交互图形，基于 OpenGL/ggobi/asymptote 的真三维图形

### gganimate {#grammar-of-animated-graphics}

与此类似的还有 mapmate 

### ggobi

### OpenGL

### JavaScript
