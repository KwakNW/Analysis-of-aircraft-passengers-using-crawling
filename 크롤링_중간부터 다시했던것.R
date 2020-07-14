setwd("C:/Users/K.N.W/Desktop/3학년 2학기/빅데이터 정보처리/다시하는기말과제")

#install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 7458L, browserName = "chrome")

remDr$open()

remDr$navigate("http://www.airport.co.kr/www/extra/dailyExpect/dailyExpectList/layOut.do?cid=2016053109481920258&menuId=4757")

#연도 및 날짜 선택
df_Air2 <- data.frame()


YYYY <- remDr$findElement(using = 'xpath', value = '//*[@id="yyyy"]/option[1]')
YYYY$clickElement() #연도 선택
YYYYout <- YYYY$getElementText()

	for (m in c(10:11)){
		MM <- remDr$findElement(using = 'xpath', value = paste0('//*[@id="mm"]/option[',as.character(m),']'))
		MM$clickElement() #월 선택
		MMout <- MM$getElementText()
		Sys.sleep(1)


		if(sum(m == c(1,3,5,7,8,10,12)) == 1) {
			for (d in c(21:31)) {
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
	df_Air2 <- rbind(df_Air2, new)}}

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
	df_Air2 <- rbind(df_Air2, new)}}
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
	df_Air2 <- rbind(df_Air2, new)}}

	remDr$refresh()
	Sys.sleep(1)
	}
df_Air2
# rownames(df_Air) = df_new$Date 열을 행이름으로 변환하는 것
df_Air <-  read.csv(file = 'C:/Users/K.N.W/Desktop/3학년 2학기/빅데이터 정보처리/다시하는기말과제/Airplane.csv')
df_Air$Date <- as.Date(df_Air$Date, format="%Y-%m-%d")
df_Air <- rbind(df_Air, df_Air2)

#write.csv(df_Air , file="Airplane.csv", row.names=FALSE) 


