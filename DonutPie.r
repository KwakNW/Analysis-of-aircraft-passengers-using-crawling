if(!require(devtools)) install.packages("devtools")
devtools::install_github("cardiomoon/moonBook")
devtools::install_github("cardiomoon/webr")

require(ggplot2)
require(moonBook)
require(webr)

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
Pie_Month

#write.csv(Pie_Month , file="Pie_Month.csv", row.names=FALSE)

PieDonut(Pie_Month,aes(pies=Month,donuts=INandOUT), title='DonutPie Chart')
PieDonut(Pie_Month[1:877,],aes(pies=Month,donuts=INandOUT), title='DonutPie Chart')


