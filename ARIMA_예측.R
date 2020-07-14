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

#데이터 더 적게 분할
new <- new_df_Air[731:1053,] #2019년 데이터 

Date <- new[,1]
Passenger <- new[,2]
Passenger <- ts(Passenger, frequency=30)

plot(Passenger)

par(mfrow = c(2,1))

acf(Passenger)
pacf(Passenger)

adf.test(diff(Passenger))


plot(stl(diff(Passenger), s.window="periodic"))
Arima <- auto.arima(diff(Passenger))

summary(Arima)
tsdiag(Arima)

forecast(Arima, h=30)
plot(forecast(Arima, h=30))






