source("D:/core/LAB/EXPsoftware/slack/boot_slack/slack_boot.R")


# This figure depends on the codes I collected from these web messages:
# Dual y axis in ggplot2 for multiple panel figure --- http://stackoverflow.com/questions/21981416/dual-y-axis-in-ggplot2-for-multiple-panel-figure
# Dual axis in ggplot2 --- https://rpubs.com/kohske/dual_axis_in_ggplot2
# 10 30 2014 Dual Y Axis Graph (ggplot2) % Brooding vs Temperature Oyster Bay --- http://heareresearch.blogspot.tw/2014/10/10-30-2014-dual-y-axis-graph-ggplot2_30.html

if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(gtable)){install.packages("gtable")}
if(!require(grid)){install.packages("grid")}
library(ggplot2)
library(gtable)
library(grid)

O_DF <- data.frame(
    EXP <- rep(c("A","B"),c(8,6)),
    SOA <- c(rep(c(0,500,1000,1500),each=2), rep(c(0,250,500),each=2)),
    Compartibility <- rep(c("Compatible","Incompatible"),7),
    RT <- c(980,1000,850,900,840,900,825,900,970,990,880,880,850,885),
    RT.se <- c(rep(25,8),rep(25,6)),
    PE <- c(0,2,0,3,0,3,0,3,2,2,2,3,3,4)
)

limits <-  aes(ymax = RT + RT.se, ymin = RT - RT.se)

Fig2_RT <- ggplot(O_DF, aes(SOA, RT, group = paste(EXP, Compartibility)) ) + geom_line(aes(colour = EXP, linetype = Compartibility) ) + geom_errorbar(limits) + geom_point(aes(colour = EXP, shape = EXP, size = 1.5)) + scale_y_continuous(limits=c(700,1050)) + labs(x="SOA",y="Reaction Time(ms)",title = "Recover Hommel's Figure 2") + guides(size = FALSE, shape = FALSE) + theme_bw() + theme(legend.justification = c(1, 1), legend.position = c(1, 1))

Fig2_PE <- ggplot(O_DF, aes(SOA, PE, group = paste(EXP, Compartibility)) ) + geom_line(aes(colour = EXP, linetype = Compartibility) ) + geom_point(aes(colour = EXP, shape = EXP, size = 1.5)) + scale_y_continuous(limits=c(0,100))+ labs(y="Error(%)") + theme_bw() %+replace% theme(panel.background = element_rect(fill = NA))


#extract gtable
g1<-ggplot_gtable(ggplot_build(Fig2_RT))
g2<-ggplot_gtable(ggplot_build(Fig2_PE))

#overlap the panel of the 2nd plot on that of the 1st plot

pp<-c(subset(g1$layout, name=="panel", se=t:r))
g<-gtable_add_grob(g1, g2$grobs[[which(g2$layout$name=="panel")]], pp$t, pp$l, pp$b, pp$l)

ia <- which(g2$layout$name == "axis-l")
ga <- g2$grobs[[ia]]
ax <- ga$children[[2]]
ax$widths <- rev(ax$widths)
ax$grobs <- rev(ax$grobs)
ax$grobs[[1]]$x <- ax$grobs[[1]]$x - unit(1, "npc") + unit(0.15, "cm")
g <- gtable_add_cols(g, g2$widths[g2$layout[ia, ]$l], length(g$widths) - 1)
g <- gtable_add_grob(g, ax, pp$t, length(g$widths) - 1, pp$b)

# draw it
grid.draw(g)

#