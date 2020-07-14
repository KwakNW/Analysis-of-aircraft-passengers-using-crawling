# 10월 한달간 출국시간 분포
library(ggplot2)

gg <- ggplot(df_htime, aes(Hour,Internal_hnum, group=2)) + geom_line(colour="red", size=1,linetype="solid") + theme_bw()+
ggtitle("Time Series Graph, Time I/O")+theme(plot.title = element_text(hjust = 0.5))

gg+geom_line(aes(Hour, Outside_hnum, group=1), colour='blue', size=1, linetype="longdash")+
 scale_color_manual(name = "INOUT", values = c("Internal_hnum", "Outside_hnum"))
