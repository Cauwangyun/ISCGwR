# 如何画条形图：数值差距很大 类别很多

pdb_RForge <- available.packages(repos = "http://R-Forge.R-project.org")
pdb <- sort(table(pdb_RForge[, "License"]), decreasing = TRUE)

pdf(file = "data/r-forge-license.pdf")
# png(filename = "data/r-forge-license.png",type = "cairo",res = 96)
op <- par(mar = c(2, 9, 0.5, 0))
plot(c(1, 1e1, 1e2, 1e3), c(1, 20, 40, 60),
  type = "n",panel.first = grid(),
  ann = FALSE, log = "x", axes = FALSE
)
axis(1,
  at = c(1, 1e1, 1e2, 1e3),
  labels = expression(1, 10^1, 10^2, 10^3)
)

text(
  y = seq(length(pdb)), x = 1, cex = 0.5, offset = 1,
  pos = 2, labels = names(pdb), xpd = TRUE
)
text(1e2, 40, "R-Forge")
segments(x0 = 1, y0 = seq(length(pdb)), x1 = pdb, y1 = seq(length(pdb)))
par(op)
dev.off()

# convert -density 300 -quality 85 data/r-forge-license.pdf data/r-forge-license.png

# 在上述情况下，对比型的条形图 R-Forge vs CRAN

pdb_CRAN <- available.packages(repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")

pdb <- sort(table(pdb_CRAN[, "License"]), decreasing = TRUE)
pdb <- head(pdb,120)

pdf(file = "data/r-cran-license.pdf",width = 7,height = 14)
op <- par(mar = c(2, 9, 0.5, 0))
plot(c(1, 1e1, 1e2, 1e3, 1e4), c(1, 30, 60, 90, 120),
     type = "n",panel.first = grid(),
     ann = FALSE, log = "x", axes = FALSE
)
axis(1,
     at = c(1, 1e1, 1e2, 1e3, 1e4),
     labels = expression(1, 10^1, 10^2, 10^3, 10^4)
)

text(
  y = seq(length(pdb)), x = 1, cex = 0.5, offset = 1,
  pos = 2, labels = names(pdb), xpd = TRUE
)
text(1e2, 40, "CRAN")
segments(x0 = 1, y0 = seq(length(pdb)), x1 = pdb, y1 = seq(length(pdb)))
par(op)
dev.off()


## 非常好的例子，两类类别不一样多

# 1. 合并一些类
# 2. 取共同的类别进行比较


