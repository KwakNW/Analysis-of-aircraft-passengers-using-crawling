setwd("C:/Users/K.N.W/Desktop/3학년 2학기/빅데이터 정보처리/다시하는기말과제")

#install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 7458L, browserName = "chrome")

remDr$open()

remDr$navigate("http://www.airport.co.kr/www/extra/dailyExpect/dailyExpectList/layOut.do?cid=2016053109481920258&menuId=4757")

df_time <- data.frame()

#10월 한달의 데이터만을 활용
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


df_time 

#write.csv(df_time, file="Time.csv", row.names=FALSE) 

df_htime <- data.frame()
for (hour in c(1:24)){
	Hour <- paste0(as.character(sprintf("%02d",hour)),"시")
	Internal_hnum <- sum(df_time[df_time['Time'] == paste0(as.character(sprintf("%02d",hour)),"시"),]['Internal_num'])
	Outside_hnum <- sum(df_time[df_time['Time'] == paste0(as.character(sprintf("%02d",hour)),"시"),]['Outside_num'])
	HTotal <- Internal_hnum + Outside_hnum

	new <- data.frame(Hour, Internal_hnum, Outside_hnum, HTotal)
	df_htime <- rbind(df_htime, new)}

df_htime
#write.csv(df_htime, file="Time_hour.csv", row.names=FALSE) 
