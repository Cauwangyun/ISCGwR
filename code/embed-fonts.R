# use web font from https://fonts.google.com/
library(showtext,quietly = TRUE)
font_add_google("Alegreya Sans", "aleg")

pdf("data/google-fonts-ex.pdf")
showtext.begin()

par(family = "aleg")
plot(0:5,0:5, type="n")
text(1:4, 1:4, "Alegreya Sans", font=1:4, cex = 2)

showtext.end()
dev.off()

# 推荐 cairo_pdf 它可以嵌入字体
# 而无须手动嵌入
embedFonts(file = "data/google-fonts-ex.pdf",outfile = "data/google-fonts-ex-embed.pdf")
