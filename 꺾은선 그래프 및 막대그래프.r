df_Air #�Ϻ� ������
df_Month #���� ������
Total_Month # ��ü ����������
df_time #10�� �ð��� ������
df_htime #24�ð����� ������ ������
df_Day #���Ϻ� ������
new_Months #�޺� �°� INOUT�з�
Pie_Month #DonutPie �׷����� ���� ��ȯ�� ������


df_Month <- df_Month[1:35,]
plot(df_Month)

Total_Month <- data.frame()
for (month in c(1:12)){
	MM <- sprintf("%02d",month)
	df <- df_Month[substr(df_Month$Date, 6,7) == MM,]

	Date <- paste0(MM,'��')
	Internal <- sum(df$Internal)
	Outside <- sum(df$Outside)
	Total <- sum(df$Total)

	new <- data.frame(Date, Internal, Outside, Total)

	Total_Month <- rbind(Total_Month, new)}

Total_Month <- Total_Month[1:11,] #2019�� 12���� ��� �ش� ���� ����

library(ggplot2)

# Total �޺� �ο� ������ �׷���
ggplot(Total_Month, aes(Date,Total, group=1))+
geom_line(color="purple") + theme_bw()+
ggtitle("Time Series Graph, Total Months")+theme(plot.title = element_text(hjust = 0.5))


# ����->���� �޺� �ο� ������ �׷���
ggplot(Total_Month, aes(Date,Internal, group=1))+
geom_line(color="blue") + theme_bw()+
ggtitle("Time Series Graph, Internal Months")+theme(plot.title = element_text(hjust = 0.5))


# ����->���� �޺� �ο� ������ �׷���
ggplot(Total_Month, aes(Date,Outside, group=1))+
geom_line(color="red") + theme_bw()+
ggtitle("Time Series Graph, Outside Months")+theme(plot.title = element_text(hjust = 0.5))


# ������ ��ȯ

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

# new_Months <- new_Months[c(order(new_Months$INOUT)),] #�����ϰ���� ��

# ����׷���
str(new_Months)

#INOUT �ѹ��� ��
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity')+coord_flip()+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))

#INOUT ���� ��
bar <- ggplot(new_Months, aes(Months, Passenger, fill=INOUT))
bar+geom_bar(stat='identity', position='dodge')+ggtitle("IN&OUT")+theme(plot.title = element_text(hjust = 0.5,color = "#6e37fa"))


