
--- 
title: "统计计算与图形"
author: "黄湘云"
date: "2018-09-19 11:53:55 CST"
site: bookdown::bookdown_site
documentclass: book
papersize: a4
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
table: yes
graphics: yes
mathspec: yes
classoption: "oneside,UTF8"
description: "An Introduction to Statistical Computing and Graphics with R. 统计计算和统计绘图入门"
github-repo: "XiangyunHuang/ISCGwR"
#cover-image: "images/mindmap4r.png"
---



# 欢迎 {#welcome}

R 软件主要用于统计计算和统计绘图， 因其提供了完整的绘图系统， 实现了大量的统计方法， 而且相比于其他统计软件，具有免费和更新快的特点，在当今数据时代浪潮下，占有一席之地。 Markdown \index{markdown} 是一个文本标记语言。 欢迎来到 R 语言的世界， 写点关于发展历史等容易吸引人的东西， 让读者有继续看下去的欲望。

## 结构 {#structure .unnumbered}

介绍书籍写作工具，写作风格设定，结构说明，R语言介绍^[<https://www.r-project.org/about.html>]

\begin{figure}

{\centering \subfloat[历史(\#fig:r-logo1)]{\href{https://www.r-project.org/}{\includegraphics[width=0.35\linewidth]{images/Rlogo_old} }}\subfloat[现在(\#fig:r-logo2)]{\href{https://www.r-project.org/}{\includegraphics[width=0.35\linewidth]{images/Rlogo} }}

}

\caption{R语言}(\#fig:r-logo)
\end{figure}

## 历史 {#history .unnumbered}

历史数据分析


```r
# 获取数据
pdb <- tools::CRAN_package_db()
pdb <- pdb[,c("Package","Published")]
# pdb <- readRDS(file = "data/pdb.RDS")
library(ggplot2)
ggplot(pdb[,c("Package","Published")], aes( as.Date(Published) ) ) +
  geom_bar(color = 'springgreen4') + 
  geom_line(data = data.frame( date = as.Date( c("2011-01-01","2012-10-20") ),
                               count = c(130,148)), aes(x = date , y = count),
            arrow = arrow(angle = 15, length = unit(0.15, "inches"))) +
  annotate("text", x = as.Date("2010-11-01"), y = 128, label = "(2012-10-29,148)") +
  scale_x_date(date_breaks = "1 year",date_labels = "%Y") +
  labs(x = "Published Date" ,y = "Count" ) +
  theme_minimal()
```

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{index_files/figure-latex/publish-count-1} 

}

\caption{有趣的是在2012年10月29日更新的R包多达148个}(\#fig:publish-count)
\end{figure}
\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{images/publish-packages} 

}

\caption{R包发布量变化趋势}(\#fig:publish-packages)
\end{figure}

R语言进入到各方各面

如何重复本书，写作工具，如何提交 PR，参与写作

益辉维护的 R Markdown 生态及其它 R 包，如图 \@ref(fig:yihui-packages)

<div align="center">
![(\#fig:yihui-packages) 益辉在 Github 上维护的 R 包^[2018年8月9日]](figures/packages.png){ width=75% }
</div>


## 后记 {#colophon .unnumbered}

这本书是在 [RStudio](https://www.rstudio.com/products/rstudio/download/) 内用 [R Markdown](https://rmarkdown.rstudio.com/) [@xie2018] 写的， [Git](https://git-scm.com/) 控制版本， [bookdown](https://bookdown.org/yihui/bookdown/) \index{bookdown} [@xie2016] 组织章节， [knitr](https://yihui.name/knitr/) \index{knitr} [@xie2015] 调用各类编程语言或解释或编译代码块，将执行结果返回到 R Markdown 文件， [Pandoc](http://pandoc.org) \index{Pandoc} 再将其转化为 Markdown 和 HTML 文档，进一步转化为 PDF 格式文档则需要 TinyTeX \index{TinyTeX} 发行版^[<https://yihui.name/tinytex/>]。

<div align="center">
![(\#fig:workflow) 工作流程图^[Inkscape 绘制]](images/workflow.png){ width=75% }
</div>

这个网站是通过 [Travis-CI](https://travis-ci.com/) 把编译结果（即 `_book` 目录）推送到 [Netlify](https://www.netlify.com/) 实现部署。在 Travis-CI 和 Netlify 都与 Github 绑定的情况下，源代码一发生改变就会触发编译，编译成功就会自动部署，这个过程即持续集成和连续部署，你正在阅读的版本是 2018-09-19 在 [Travis](https://travis-ci.com/XiangyunHuang/ISCGwR) 上构建的。



## 说明 {#conventions .unnumbered}

Alegreya 罗马体显示正文，AlegreyaSans 等线体显示数字，sourcecodepro 等宽体显示代码，Alegreya 字体源文件见 <https://github.com/huertatipografica/> 和样式见 <https://huertatipografica.com/en>，我们可以通过安装 LaTeX 包 alegreya 获得。R 包名称在文中以粗体显示，代码块输出用 `#>` 表示，以区分普通的代码注释 `#`

绘图使用的中文字体是思源宋体和思源黑体， 由 **showtext** 包安装和调用，**tikzDevice** 和 **fontcm** 处理其中的数学公式，**xkcd** 设置漫画手写体风格。

我的写作环境是 VBox + Ubuntu 16.04.4 Server + PuTTY + Xming，如图 \@ref(fig:swordsmans) 所示。

\begin{figure}

{\centering \subfloat[VBox 虚拟机(\#fig:swordsmans1)]{\includegraphics[width=0.35\linewidth]{figures/VBox} }\subfloat[Ubuntu Server系统(\#fig:swordsmans2)]{\includegraphics[width=0.35\linewidth]{figures/Ubuntu} }\\\subfloat[PuTTY SSH登陆客户端(\#fig:swordsmans3)]{\includegraphics[width=0.35\linewidth]{figures/PuTTY} }\subfloat[显示服务器 X Windows System(\#fig:swordsmans4)]{\includegraphics[width=0.35\linewidth]{figures/Xming} }

}

\caption{远程办公四剑客}(\#fig:swordsmans)
\end{figure}

书籍生成过程中，R 进程和 Pandoc 版本信息如下：


```r
xfun::session_info()
#> R version 3.5.0 (2017-01-27)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 14.04.5 LTS
#> 
#> Locale:
#>   LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>   LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>   LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>   LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>   LC_ADDRESS=C               LC_TELEPHONE=C            
#>   LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> Package version:
#>   assertthat_0.2.0   backports_1.1.2    base64enc_0.1.3   
#>   bookdown_0.7       cli_1.0.0          codetools_0.2-15  
#>   colorspace_1.3-2   compiler_3.5.0     crayon_1.3.4      
#>   curl_3.2           digest_0.6.17      evaluate_0.11     
#>   fansi_0.3.0        ggplot2_3.0.0      glue_1.3.0        
#>   graphics_3.5.0     grDevices_3.5.0    grid_3.5.0        
#>   gtable_0.2.0       highr_0.7          htmltools_0.3.6   
#>   jsonlite_1.5       knitr_1.20         labeling_0.3      
#>   lattice_0.20.35    lazyeval_0.2.1     magrittr_1.5      
#>   markdown_0.8       MASS_7.3.49        Matrix_1.2.14     
#>   methods_3.5.0      mgcv_1.8.23        mime_0.5          
#>   munsell_0.5.0      nlme_3.1.137       pillar_1.3.0      
#>   plyr_1.8.4         R6_2.2.2           RColorBrewer_1.1.2
#>   Rcpp_0.12.18       reshape2_1.4.3     rlang_0.2.2       
#>   rmarkdown_1.10     rprojroot_1.3-2    scales_1.0.0      
#>   stats_3.5.0        stringi_1.2.4      stringr_1.3.1     
#>   tibble_1.4.2       tinytex_0.8        tools_3.5.0       
#>   utf8_1.1.4         utils_3.5.0        viridisLite_0.3.0 
#>   withr_2.1.2        xfun_0.3           yaml_2.2.0
rmarkdown::pandoc_version()
#> [1] '2.3'
```


## 授权 {#licenses .unnumbered}

本书采用 [知识共享署名-非商业性使用-禁止演绎 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/) 许可，请君自重，别没事儿拿去传个什么新浪爱问、百度文库以及 XX 经济论坛，项目中代码使用 [MIT 协议](https://github.com/XiangyunHuang/ISCGwR/blob/master/LICENSE) 开源


\begin{flushleft}\includegraphics[width=0.15\linewidth]{images/by-nc-nd} \end{flushleft}


