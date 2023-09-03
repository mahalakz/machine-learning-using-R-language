#install.packages('forecast')

path<-"D:/desktop/Content DS/datasetShampoo.csv"

shampoo<-read.csv(path)

#Augmented Dickey-Fuller Test
require(tseries)
adf.test(shampoo$Sales)

#using Differencing and transformation
#adf.test(diff(diff(log(shampoo$Sales))))


kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)

kings


#store data in timeseries object
kingstimeseries <- ts(kings)
                      
                      
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")

birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
birthstimeseries


souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")

souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries

plot.ts(kingstimeseries)   #can use additive model

plot.ts(birthstimeseries) #can use additive model

plot.ts(souvenirtimeseries) # this plot shows there is a change in seasonal so additive model unable to use

#For additive will find log
logsouvenirtimeseries <- log(souvenirtimeseries)
plot.ts(logsouvenirtimeseries)


#Decomposing non seasonal time series 
library("TTR")

#trend  component of time series using SMA
kingstimeseriesSMA3 <- SMA(kingstimeseries,n=3)
plot.ts(kingstimeseriesSMA3)

#with higher order of smoothing
kingstimeseriesSMA8 <- SMA(kingstimeseries,n=8)
plot.ts(kingstimeseriesSMA8)

#Decomposing seasonal time series
birthstimeseriescomponents <- decompose(birthstimeseries)

birthstimeseriescomponents$seasonal
plot(birthstimeseriescomponents)

#Seasonal adjusting
birthstimeseriescomponents <- decompose(birthstimeseries)
birthstimeseriesseasonallyadjusted <- birthstimeseries - birthstimeseriescomponents$seasonal

plot(birthstimeseriesseasonallyadjusted)


#Forecasts using Exponential Smoothing
rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)

rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries) #appropriate to describe additive model

#simple exponent smoothing using Holt winter when trend increasing decreasing and seasonality is also there
rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
rainseriesforecasts

#forecast in holt winter
rainseriesforecasts$fitted

plot(rainseriesforecasts)

#measure of accuracy using sum of squared error
rainseriesforecasts$SSE

#simple exponent smooting with first value
HoltWinters(rainseries, beta=FALSE, gamma=FALSE, l.start=23.56)


library("forecast")
rainseriesforecasts2 <- forecast:::forecast.HoltWinters(rainseriesforecasts, h=8)
rainseriesforecasts2   #low alpha shows forecast on recent or less recent


forecast:::plot.forecast(rainseriesforecasts2)


#autocorellation
acf(rainseriesforecasts2$residuals, lag.max=20,na.action = na.pass)
pacf(rainseriesforecasts2$residuals, lag.max=20,na.action = na.pass)


#test whether there is significant evidence for non-zero correlations at lags 1-20, we can carry out a Ljung-Box test
Box.test(rainseriesforecasts2$residuals, lag=20, type="Ljung-Box")  # little evidence of non-zero autocorrelations

plot.ts(rainseriesforecasts2$residuals)


#Holt when increasing decreasing trend and no seasonal
skirts <- scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)

skirtsseries <- ts(skirts,start=c(1866))
plot.ts(skirtsseries)

skirtsseriesforecasts <- HoltWinters(skirtsseries, gamma=FALSE) #high alpha shows forecast on recent

plot(skirtsseriesforecasts)  #original vs forecast

skirtsseriesforecasts2 <- forecast:::forecast.HoltWinters(skirtsseriesforecasts, h=19) #forecast for 10 points
forecast:::plot.forecast(skirtsseriesforecasts2)



#Arima for specially stationary time series
#When non stationary then need to use difference method till we dnt receive stationary time series

plot.ts(skirtsseries)

skirtsseriesdiff1 <- diff(skirtsseries, differences=1)
plot.ts(skirtsseriesdiff1) #Not stationary in Mean

skirtsseriesdiff2 <- diff(skirtsseries, differences=2)
plot.ts(skirtsseriesdiff2)


kingtimeseriesdiff1 <- diff(kingstimeseries, differences=1)
plot.ts(kingtimeseriesdiff1)

acf(kingtimeseriesdiff1, lag.max=20)             # plot a correlogram
acf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the autocorrelation values

pacf(kingtimeseriesdiff1, lag.max=20)             # plot a partial correlogram
pacf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the partial autocorrelation values


volcanodust <- scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip=1)

volcanodustseries <- ts(volcanodust,start=c(1500))
plot.ts(volcanodustseries)

acf(volcanodustseries, lag.max=20)             # plot a correlogram
acf(volcanodustseries, lag.max=20, plot=FALSE) # get the values of the autocorrelations

pacf(volcanodustseries, lag.max=20)
pacf(volcanodustseries, lag.max=20, plot=FALSE)


#forecasting using ARIMA
kingstimeseriesarima <- arima(kingstimeseries, order=c(0,1,1)) # fit an ARIMA(0,1,1) model
kingstimeseriesarima

library("forecast") # load the "forecast" R library
kingstimeseriesforecasts <- forecast:::forecast.Arima(kingstimeseriesarima, h=5)
kingstimeseriesforecasts

forecast:::plot.forecast(kingstimeseriesforecasts)
