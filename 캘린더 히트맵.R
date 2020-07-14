calendarHeat <- function(dates, 
                         values, 
                         ncolors=99, 
                         color="r2g", 
                         varname="Values",
                         date.form = "%Y-%m-%d", ...) {
require(lattice)
require(grid)
require(chron)
if (class(dates) == "character" | class(dates) == "factor" ) {
  dates <- strptime(dates, date.form)
        }
caldat <- data.frame(value = values, dates = dates)

#날짜 데이터의 처음과 마지막 지정
min.date <- as.Date(paste(format(min(dates), "%Y"),
                    "-1-1",sep = ""))
max.date <- as.Date(paste(format(max(dates), "%Y"),
                     "-12-31", sep = ""))
dates.f <- data.frame(date.seq = seq(min.date, max.date, by="days"))

# 비트맵에 맞는 데이터로 변환
caldat <- data.frame(date.seq = seq(min.date, max.date, by="days"), value = NA)
dates <- as.Date(dates) 
caldat$value[match(dates, caldat$date.seq)] <- values

caldat$dotw <- as.numeric(format(caldat$date.seq, "%w")) # 일주일은 0~6까지 지정
caldat$woty <- as.numeric(format(caldat$date.seq, "%U")) + 1 
caldat$yr <- as.factor(format(caldat$date.seq, "%Y")) #연도 변환
caldat$month <- as.numeric(format(caldat$date.seq, "%m"))

yrs <- as.character(unique(caldat$yr)) #연도 중복 제외하고 뽑기
d.loc <- as.numeric()

#연도별 지정                        
for (m in min(yrs):max(yrs)) {
  d.subset <- which(caldat$yr == m)  
  sub.seq <- seq(1,length(d.subset))
  d.loc <- c(d.loc, sub.seq)
  }  
caldat <- cbind(caldat, seq=d.loc) #calender 연결

#색깔 지정
r2b <- c("#0571B0", "#92C5DE", "#F7F7F7", "#F4A582", "#CA0020") #red to blue                                                                               
r2g <- c("#D61818", "#FFAE63", "#FFFFBD", "#B5E384")   #red to green
g2r <- c("#B5E384", "#FFFFBD", "#FFAE63", "#D61818")   #green to red
w2b <- c("#045A8D", "#2B8CBE", "#74A9CF", "#BDC9E1", "#F1EEF6")   #white to blue
p2y <- c("#f2dc50", "#e3cf4f", "#f9ffc7", "#a884f5", "#5b16f0") #purple to yellow
            
assign("col.sty", get(color))
calendar.pal <- colorRampPalette((col.sty), space = "Lab")
def.theme <- lattice.getOption("default.theme")
cal.theme <-
   function() {  
  theme <- list(
    strip.background = list(col = "transparent"),
    strip.border = list(col = "transparent"),
    axis.line = list(col="transparent"),
    par.strip.text=list(cex=0.8))
    }   

lattice.options(default.theme = cal.theme)
yrs <- (unique(caldat$yr))
nyr <- length(yrs)

#캘린더 표출
print(cal.plot <- levelplot(value~woty*dotw | yr, data=caldat,
   as.table=TRUE,
   aspect=.12,
   layout = c(1, nyr%%7),
   between = list(x=0, y=c(1,1)),
   strip=TRUE,
   main = paste("Calendar Heat Map of ", varname, sep = ""), #제목
   scales = list(
     x = list(
               at= c(seq(2.9, 52, by=4.42)),
               labels = month.abb,
               alternating = c(1, rep(0, (nyr-1))),
               tck=0,
               cex = 0.7),
     y=list(
          at = c(0, 1, 2, 3, 4, 5, 6), 
          labels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                      "Friday", "Saturday"),#요일 레이블 지정
          alternating = 1,
          cex = 0.6,
          tck=0)),
   xlim =c(0.4, 54.6),
   ylim=c(6.6,-0.6),
   cuts= ncolors - 1,
   col.regions = (calendar.pal(ncolors)),
   xlab="" ,
   ylab="",
   colorkey= list(col = calendar.pal(ncolors), width = 0.6, height = 0.5),
   subscripts=TRUE
    ) )
panel.locs <- trellis.currentLayout()
for (row in 1:nrow(panel.locs)) {
    for (column in 1:ncol(panel.locs))  {
    if (panel.locs[row, column] > 0)
{
    trellis.focus("panel", row = row, column = column,
                  highlight = FALSE)
xyetc <- trellis.panelArgs()
subs <- caldat[xyetc$subscripts,]
dates.fsubs <- caldat[caldat$yr == unique(subs$yr),]
y.start <- dates.fsubs$dotw[1]
y.end   <- dates.fsubs$dotw[nrow(dates.fsubs)]
dates.len <- nrow(dates.fsubs)
adj.start <- dates.fsubs$woty[1]

for (k in 0:6) {
 if (k < y.start) {
    x.start <- adj.start + 0.5
    } else {
    x.start <- adj.start - 0.5
      }
  if (k > y.end) {
     x.finis <- dates.fsubs$woty[nrow(dates.fsubs)] - 0.5
    } else {
     x.finis <- dates.fsubs$woty[nrow(dates.fsubs)] + 0.5
      }
    grid.lines(x = c(x.start, x.finis), y = c(k -0.5, k - 0.5), 
     default.units = "native", gp=gpar(col = "grey", lwd = 1))
     }
if (adj.start <  2) {
 grid.lines(x = c( 0.5,  0.5), y = c(6.5, y.start-0.5), 
      default.units = "native", gp=gpar(col = "grey", lwd = 1))
 grid.lines(x = c(1.5, 1.5), y = c(6.5, -0.5), default.units = "native",
      gp=gpar(col = "grey", lwd = 1))
 grid.lines(x = c(x.finis, x.finis), 
      y = c(dates.fsubs$dotw[dates.len] -0.5, -0.5), default.units = "native",
      gp=gpar(col = "grey", lwd = 1))
 if (dates.fsubs$dotw[dates.len] != 6) {
 grid.lines(x = c(x.finis + 1, x.finis + 1), 
      y = c(dates.fsubs$dotw[dates.len] -0.5, -0.5), default.units = "native",
      gp=gpar(col = "grey", lwd = 1))
      }
 grid.lines(x = c(x.finis, x.finis), 
      y = c(dates.fsubs$dotw[dates.len] -0.5, -0.5), default.units = "native",
      gp=gpar(col = "grey", lwd = 1))
      }
for (n in 1:51) {
  grid.lines(x = c(n + 1.5, n + 1.5), 
    y = c(-0.5, 6.5), default.units = "native", gp=gpar(col = "grey", lwd = 1))
        }
x.start <- adj.start - 0.5

if (y.start > 0) {
  grid.lines(x = c(x.start, x.start + 1),
    y = c(y.start - 0.5, y.start -  0.5), default.units = "native",
    gp=gpar(col = "black", lwd = 1.75))
  grid.lines(x = c(x.start + 1, x.start + 1),
    y = c(y.start - 0.5 , -0.5), default.units = "native",
    gp=gpar(col = "black", lwd = 1.75))
  grid.lines(x = c(x.start, x.start),
    y = c(y.start - 0.5, 6.5), default.units = "native",
    gp=gpar(col = "black", lwd = 1.75))
 if (y.end < 6  ) {
  grid.lines(x = c(x.start + 1, x.finis + 1),
   y = c(-0.5, -0.5), default.units = "native",
   gp=gpar(col = "black", lwd = 1.75))
  grid.lines(x = c(x.start, x.finis),
   y = c(6.5, 6.5), default.units = "native",
   gp=gpar(col = "black", lwd = 1.75))
   } else {
      grid.lines(x = c(x.start + 1, x.finis),
       y = c(-0.5, -0.5), default.units = "native",
       gp=gpar(col = "black", lwd = 1.75))
      grid.lines(x = c(x.start, x.finis),
       y = c(6.5, 6.5), default.units = "native",
       gp=gpar(col = "black", lwd = 1.75))
       }
       } else {
           grid.lines(x = c(x.start, x.start),
            y = c( - 0.5, 6.5), default.units = "native",
            gp=gpar(col = "black", lwd = 1.75))
           }

 if (y.start == 0 ) {
  if (y.end < 6  ) {
  grid.lines(x = c(x.start, x.finis + 1),
   y = c(-0.5, -0.5), default.units = "native",
   gp=gpar(col = "black", lwd = 1.75))
  grid.lines(x = c(x.start, x.finis),
   y = c(6.5, 6.5), default.units = "native",
   gp=gpar(col = "black", lwd = 1.75))
   } else {
      grid.lines(x = c(x.start + 1, x.finis),
       y = c(-0.5, -0.5), default.units = "native",
       gp=gpar(col = "black", lwd = 1.75))
      grid.lines(x = c(x.start, x.finis),
       y = c(6.5, 6.5), default.units = "native",
       gp=gpar(col = "black", lwd = 1.75))
       }
       }

#달별로 그리드 지정
for (j in 1:12)  {
   last.month <- max(dates.fsubs$seq[dates.fsubs$month == j])
   x.last.m <- dates.fsubs$woty[last.month] + 0.5
   y.last.m <- dates.fsubs$dotw[last.month] + 0.5
   grid.lines(x = c(x.last.m, x.last.m), y = c(-0.5, y.last.m),
     default.units = "native", gp=gpar(col = "black", lwd = 1.75))
   if ((y.last.m) < 6) {
      grid.lines(x = c(x.last.m, x.last.m - 1), y = c(y.last.m, y.last.m),
       default.units = "native", gp=gpar(col = "black", lwd = 1.75))
     grid.lines(x = c(x.last.m - 1, x.last.m - 1), y = c(y.last.m, 6.5),
       default.units = "native", gp=gpar(col = "black", lwd = 1.75))
   } else {
      grid.lines(x = c(x.last.m, x.last.m), y = c(- 0.5, 6.5),
       default.units = "native", gp=gpar(col = "black", lwd = 1.75))
    }
 }
 }
 }
trellis.unfocus()
} 
lattice.options(default.theme = def.theme)
}


# calendar heatmap for Airplane

windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Total, color="p2y", varname="AIRPORT_Passenger")
# savePlot("calender heatmap fig_1.png",type="png")

windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Internal, color="p2y", varname="AIRPORT_Passenger_Internal")
# savePlot("calender heatmap fig_1.png",type="png")

windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Outside, color="p2y", varname="AIRPORT_Passenger_Outside")
# savePlot("calender heatmap fig_1.png",type="png")


