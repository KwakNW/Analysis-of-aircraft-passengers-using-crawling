df_Air #일별 데이터
df_Month #월간 데이터
Total_Month # 전체 월간데이터
df_time #10월 시간별 데이터
df_htime #24시간으로 분할한 데이터
df_Day #요일별 데이터
new_Months #달별 승객 INOUT분류
Pie_Month #DonutPie 그래프를 위해 변환한 데이터


df_Month <- df_Month[1:35,]
plot(df_Month)

Total_Month <- data.frame()
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

library(ggplot2)

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


# 데이터 변환

Total_Month

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
new_Months

# new_Months <- new_Months[c(order(new_Months$INOUT)),] #정렬하고싶을 때

# 막대그래프
str(new_Months)

#INOUT 한번에 비교
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity')+coord_flip()+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))

#INOUT 따로 비교
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity', position='dodge')+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))


