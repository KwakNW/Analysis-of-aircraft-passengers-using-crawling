setwd("C:/Users/K.N.W/Desktop/3학년 2학기/빅데이터 정보처리/다시하는기말과제")

##########################크롤링##########################

#install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 7458L, browserName = "chrome")
remDr$open()
remDr$navigate("http://www.airport.co.kr/www/extra/dailyExpect/dailyExpectList/layOut.do?cid=2016053109481920258&menuId=4757")

#연도 및 날짜 선택
df_Air <- data.frame()

for (y in c(3:1)){
	YYYY <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="yyyy"]/option[',as.character(y),']'))
	YYYY$clickElement() #연도 선택
	YYYYout <- YYYY$getElementText()

	for (m in c(1:12)){
		MM <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="mm"]/option[',as.character(m),']'))
		MM$clickElement() #월 선택
		MMout <- MM$getElementText()
		Sys.sleep(1)

		if(sum(m == c(1,3,5,7,8,10,12)) == 1) {
			for (d in c(1:31)) {
				DD <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="dd"]/option[',as.character(d),']'))
				DD$clickElement() #일 선택
				Sys.sleep(1)
				DDout <- DD$getElementText()
				Sys.sleep(1)

	remDr$findElement(using = 'xpath',value = '//*[@id="searchForm"]/div/div[3]/button')$clickElement() #검색버튼
	Sys.sleep(1)

	webElem<-remDr$findElement(using = "class", value = "table-hover")
	Sys.sleep(1)

	results <- webElem$getElementText()
	Sys.sleep(1)

	data <- strsplit(results[[1]],'\n')
	data <- data[[1]][2:length(data[[1]])]

	txt <- strsplit(data, split=' ')
	txt <- txt[length(txt)]

	Date <- as.Date(paste(YYYYout,MMout,DDout), format="%Y%m%d")

	Internal <- as.numeric(gsub(',','',txt[[1]][2])) + as.numeric(gsub(',','',txt[[1]][4])) + as.numeric(gsub(',','',txt[[1]][6])) +
	 as.numeric(gsub(',','',txt[[1]][8])) + as.numeric(gsub(',','',txt[[1]][10]))

	Outside <- as.numeric(gsub(',','',txt[[1]][3])) + as.numeric(gsub(',','',txt[[1]][5])) + as.numeric(gsub(',','',txt[[1]][7])) +
	 as.numeric(gsub(',','',txt[[1]][9])) + as.numeric(gsub(',','',txt[[1]][11]))

	new <- data.frame(Date, Internal, Outside)
	df_Air <- rbind(df_Air, new)}}

		else if (sum(m == c(4,6,9,11)) == 1) {
			for (d in c(1:30)) {
				DD <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="dd"]/option[',as.character(d),']'))
				DD$clickElement() #일 선택
				Sys.sleep(1)
				DDout <- DD$getElementText()
				Sys.sleep(1)

	remDr$findElement(using = 'xpath',value = '//*[@id="searchForm"]/div/div[3]/button')$clickElement() #검색버튼
	Sys.sleep(1)

	webElem<-remDr$findElement(using = "class", value = "table-hover")
	Sys.sleep(1)

	results <- webElem$getElementText()
	Sys.sleep(1)

	data <- strsplit(results[[1]],'\n')
	data <- data[[1]][2:length(data[[1]])]

	txt <- strsplit(data, split=' ')
	txt <- txt[length(txt)]

	Date <- as.Date(paste(YYYYout,MMout,DDout), format="%Y%m%d")

	Internal <- as.numeric(gsub(',','',txt[[1]][2])) + as.numeric(gsub(',','',txt[[1]][4])) + as.numeric(gsub(',','',txt[[1]][6])) +
	 as.numeric(gsub(',','',txt[[1]][8])) + as.numeric(gsub(',','',txt[[1]][10]))

	Outside <- as.numeric(gsub(',','',txt[[1]][3])) + as.numeric(gsub(',','',txt[[1]][5])) + as.numeric(gsub(',','',txt[[1]][7])) +
	 as.numeric(gsub(',','',txt[[1]][9])) + as.numeric(gsub(',','',txt[[1]][11]))

	new <- data.frame(Date, Internal, Outside)
	df_Air <- rbind(df_Air, new)}}
		else {
			for (d in c(1:28)) {
				DD <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="dd"]/option[',as.character(d),']'))
				DD$clickElement() #일 선택
				Sys.sleep(1)
				DDout <- DD$getElementText()
				Sys.sleep(1)

	remDr$findElement(using = 'xpath',value = '//*[@id="searchForm"]/div/div[3]/button')$clickElement() #검색버튼
	Sys.sleep(1)

	webElem<-remDr$findElement(using = "class", value = "table-hover")
	Sys.sleep(1)

	results <- webElem$getElementText()
	Sys.sleep(1)

	data <- strsplit(results[[1]],'\n')
	data <- data[[1]][2:length(data[[1]])]

	txt <- strsplit(data, split=' ')
	txt <- txt[length(txt)]

	Date <- as.Date(paste(YYYYout,MMout,DDout), format="%Y%m%d")

	Internal <- as.numeric(gsub(',','',txt[[1]][2])) + as.numeric(gsub(',','',txt[[1]][4])) + as.numeric(gsub(',','',txt[[1]][6])) +
	 as.numeric(gsub(',','',txt[[1]][8])) + as.numeric(gsub(',','',txt[[1]][10]))

	Outside <- as.numeric(gsub(',','',txt[[1]][3])) + as.numeric(gsub(',','',txt[[1]][5])) + as.numeric(gsub(',','',txt[[1]][7])) +
	 as.numeric(gsub(',','',txt[[1]][9])) + as.numeric(gsub(',','',txt[[1]][11]))

	new <- data.frame(Date, Internal, Outside)
	df_Air <- rbind(df_Air, new)}}

	remDr$refresh()
	Sys.sleep(1)
	}
}
df_Air <- df_Air[,1:3]

df_Air$Total <- df_Air$Internal + df_Air$Outside # 총합 변수 추가
df_Air$Weekdays <- weekdays(as.Date(df_Air$Date)) # 요일 변수 추가
#write.csv(df_Air , file="Airplane.csv", row.names=FALSE) 


#2019년 10월 한달의 데이터만 크롤링하여 시간별로 수집
df_time <- data.frame()
YYYY <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="yyyy"]/option[',as.character(1),']'))
YYYY$clickElement() #연도 선택
YYYYout <- YYYY$getElementText()

MM <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="mm"]/option[',as.character(10),']'))
MM$clickElement() #월 선택
MMout <- MM$getElementText()
Sys.sleep(1)

for (d in c(1:31)) {
	DD <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="dd"]/option[',as.character(d),']'))
	DD$clickElement() #일 선택
	Sys.sleep(1)
	DDout <- DD$getElementText()
	Sys.sleep(1)

	remDr$findElement(using = 'xpath',value = '//*[@id="searchForm"]/div/div[3]/button')$clickElement() #검색버튼
	Sys.sleep(1)

	webElem<-remDr$findElement(using = "class", value = "table-hover")
	Sys.sleep(1)

	results <- webElem$getElementText()
	Sys.sleep(1)

	data <- strsplit(results[[1]],'\n')
	data <- data[[1]][2:length(data[[1]])]

	txt <- strsplit(data, split=' ')
	for(t in c(4:length(txt)-1)){
		Time <- strsplit(txt[[t]][1],  split='~')[[1]][2]

		Internal_num <- as.numeric(gsub(',','',txt[[t]][2])) + as.numeric(gsub(',','',txt[[t]][4])) + as.numeric(gsub(',','',txt[[t]][6])) +
		as.numeric(gsub(',','',txt[[t]][8])) + as.numeric(gsub(',','',txt[[t]][10]))

		Outside_num <- as.numeric(gsub(',','',txt[[t]][3])) + as.numeric(gsub(',','',txt[[t]][5])) + as.numeric(gsub(',','',txt[[t]][7])) +
		as.numeric(gsub(',','',txt[[t]][9])) + as.numeric(gsub(',','',txt[[t]][11]))

		Total <- Internal_num + Outside_num

		new <- data.frame(Time, Internal_num, Outside_num, Total)
		df_time <- rbind(df_time, new)}}	
#write.csv(df_time , file="Time.csv", row.names=FALSE) 

##########################데이터 변환##########################

df_Air <- read.csv("Airplane.csv")
df_time <- read.csv("Time.csv")

#24시간 기준으로 시간별로 분류
df_htime <- data.frame()
for (hour in c(1:24)){
	Hour <- paste0(as.character(sprintf("%02d",hour)),"시")
	Internal_hnum <- sum(df_time[df_time['Time'] == paste0(as.character(sprintf("%02d",hour)),"시"),]['Internal_num'])
	Outside_hnum <- sum(df_time[df_time['Time'] == paste0(as.character(sprintf("%02d",hour)),"시"),]['Outside_num'])
	HTotal <- Internal_hnum + Outside_hnum

	new <- data.frame(Hour, Internal_hnum, Outside_hnum, HTotal)
	df_htime <- rbind(df_htime, new)}


#연도별 달 데이터 만들기
df_Month <- data.frame()
for (year in c('2017','2018','2019')){
	for (month in c(1:12)){
		YYMM <- paste0(year,'-',sprintf("%02d",month))
		df <- df_Air[substr(df_Air$Date, 1,7) == YYMM,]

		Date <- YYMM
		Internal <- sum(df$Internal)
		Outside <- sum(df$Outside)
		Total <- sum(df$Total)

		new <- data.frame(Date, Internal, Outside, Total)

		df_Month <- rbind(df_Month, new)
		}
}


#날짜별 데이터 만들기
df_Day <- data.frame()
for (Day in c('월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일')){
	Internal_day <- sum(df_Air[df_Air$Weekday == Day,]['Internal'])
	Outside_day <- sum(df_Air[df_Air$Weekday == Day,]['Outside'])
	Total_day <- Internal_day + Outside_day 

	new <- data.frame(Day, Internal_day, Outside_day, Total_day)
	df_Day <- rbind(df_Day, new)}


#전체 데이터를 달별로 분류
Total_Month <- data.frame()
df_Month <- df_Month[1:35,]
for (month in c(1:12)){
	MM <- sprintf("%02d",month)
	df <- df_Month[substr(df_Month$Date, 6,7) == MM,]

	Date <- paste0(MM,'월')
	Internal <- sum(df$Internal)
	Outside <- sum(df$Outside)
	Total <- sum(df$Total)

	new <- data.frame(Date, Internal, Outside, Total)
	Total_Month <- rbind(Total_Month, new)}
Total_Month <- Total_Month[1:11,] #2019년 12월이 없어서 해당 행을 삭제

#전체 데이터를 달별로 In Out으로 분류
new_Months <- data.frame()
for (i in c(1:22)){
	Months <- as.character(Total_Month$Date[ceiling(i/2)])

	if (i%%2 == 1){
	Passenger <- as.numeric(Total_Month$Internal[ceiling(i/2)])
	INOUT <- "Internal"
	new <- data.frame(Months, Passenger, INOUT) 
	new_Months <- rbind(new_Months, new)}
	
	else{
	Passenger <- as.numeric(Total_Month$Outside[ceiling(i/2)])
	INOUT <- "Outside"
	new <- data.frame(Months, Passenger, INOUT) 
	new_Months <- rbind(new_Months, new)}
}

# Donut Pie Chart에 넣기 위한 데이터 변환
Pie_Month <- data.frame()
#수가 너무 많아서 비율만 볼것이기 때문에 10000으로 나눔
for(i in c(1:22)){
	Month <- as.character(new_Months$Months[i])
	INandOUT <- as.character(new_Months$INOUT[i])

	for (p in c(1:round(new_Months$Passenger[i]/100000))){
		new <- data.frame(Month, INandOUT)
		Pie_Month <- rbind(Pie_Month, new)
	}
}

##########################꺾은선&막대##########################

library(ggplot2)
plot(df_Month)

# Total 달별 인원 꺾은선 그래프
ggplot(Total_Month, aes(Date,Total, group=1))+
geom_line(color="purple") + theme_bw()+
ggtitle("Time Series Graph, Total Months")+theme(plot.title = element_text(hjust = 0.5))

# 국내->국내 달별 인원 꺾은선 그래프
ggplot(Total_Month, aes(Date,Internal, group=1))+
geom_line(color="blue") + theme_bw()+
ggtitle("Time Series Graph, Internal Months")+theme(plot.title = element_text(hjust = 0.5))

# 국내->국외 달별 인원 꺾은선 그래프
ggplot(Total_Month, aes(Date,Outside, group=1))+
geom_line(color="red") + theme_bw()+
ggtitle("Time Series Graph, Outside Months")+theme(plot.title = element_text(hjust = 0.5))

# 막대그래프
#INOUT 한번에 비교
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity')+coord_flip()+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))

#INOUT 따로 비교
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity', position='dodge')+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))

# 10월 한달간 출국시간 분포
gg <- ggplot(df_htime, aes(Hour,Internal_hnum, group=2)) + geom_line(colour="red", size=1,linetype="solid") + theme_bw()+
ggtitle("Time Series Graph, Time I/O")+theme(plot.title = element_text(hjust = 0.5))

gg+geom_line(aes(Hour, Outside_hnum, group=1), colour='blue', size=1, linetype="longdash")+
 scale_color_manual(name = "INOUT", values = c("Internal_hnum", "Outside_hnum"))

##########################Donut Pie Chart##########################

#if(!require(devtools)) install.packages("devtools")
#devtools::install_github("cardiomoon/moonBook")
#devtools::install_github("cardiomoon/webr")

require(ggplot2)
require(moonBook)
require(webr)

PieDonut(Pie_Month,aes(pies=Month,donuts=INandOUT), title='DonutPie Chart') #11월 포함
PieDonut(Pie_Month[1:877,],aes(pies=Month,donuts=INandOUT), title='DonutPie Chart') #11월 미포함

##########################Calendar Heat Map##########################

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
  dates <- strptime(dates, date.form) }
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
  d.loc <- c(d.loc, sub.seq)}  
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
    par.strip.text=list(cex=0.8))}   

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
    x.start <- adj.start + 0.5} 
 else {
    x.start <- adj.start - 0.5}
  if (k > y.end) {
     x.finis <- dates.fsubs$woty[nrow(dates.fsubs)] - 0.5} 
  else {
     x.finis <- dates.fsubs$woty[nrow(dates.fsubs)] + 0.5}
    grid.lines(x = c(x.start, x.finis), y = c(k -0.5, k - 0.5), 
     default.units = "native", gp=gpar(col = "grey", lwd = 1))}
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
      gp=gpar(col = "grey", lwd = 1))}
 grid.lines(x = c(x.finis, x.finis), 
      y = c(dates.fsubs$dotw[dates.len] -0.5, -0.5), default.units = "native",
      gp=gpar(col = "grey", lwd = 1))}
for (n in 1:51) {
  grid.lines(x = c(n + 1.5, n + 1.5), 
    y = c(-0.5, 6.5), default.units = "native", gp=gpar(col = "grey", lwd = 1))}
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
       gp=gpar(col = "black", lwd = 1.75))}
       } else {
           grid.lines(x = c(x.start, x.start),
            y = c( - 0.5, 6.5), default.units = "native",
            gp=gpar(col = "black", lwd = 1.75))}

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
       gp=gpar(col = "black", lwd = 1.75))}}

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
       default.units = "native", gp=gpar(col = "black", lwd = 1.75))} }}}
trellis.unfocus()} 
lattice.options(default.theme = def.theme)}


# calendar heatmap for Airplane
windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Total, color="p2y", varname="AIRPORT_Passenger")

windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Internal, color="p2y", varname="AIRPORT_Passenger_Internal")

windows(height=7, width=14)
calendarHeat(dates=df_Air$Date, values=df_Air$Outside, color="p2y", varname="AIRPORT_Passenger_Outside")


##########################ARIMA를 이용한 예측##########################

library(tseries)
library(forecast)

new_df_Air <- df_Air
rownames(new_df_Air) = df_Air$Date
new_df_Air <- new_df_Air[,2:5]

Date <- new_df_Air[,1]
Passenger <- new_df_Air[,2]
Passenger <- ts(Passenger, frequency=30)

class(Passenger)
str(Passenger)
plot(Passenger)

par(mfrow = c(2,1))
acf(Passenger)
pacf(Passenger)

acf(diff(Passenger))
pacf(diff(Passenger))

plot(stl(Passenger, s.window="periodic"))

adf.test(diff(Passenger))
plot(stl(diff(Passenger), s.window="periodic"))

Arima <- auto.arima(diff(Passenger))

summary(Arima)
tsdiag(Arima)

forecast(Arima, h=30)
plot(forecast(Arima, h=30))

#2019년 데이터만 사용
new <- new_df_Air[731:1053,]

Date <- new[,1]
Passenger <- new[,2]
Passenger <- ts(Passenger, frequency=30)

plot(Passenger)

par(mfrow = c(2,1))
acf(Passenger)
pacf(Passenger)

adf.test(diff(Passenger))
acf(diff(Passenger))
pacf(diff(Passenger))

plot(stl(diff(Passenger), s.window="periodic"))
Arima <- auto.arima(diff(Passenger))

summary(Arima)
tsdiag(Arima)

forecast(Arima, h=30)
plot(forecast(Arima, h=30))



