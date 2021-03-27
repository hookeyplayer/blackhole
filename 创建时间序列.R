library(xts)

# 数组是矩阵的拓展
array(1:24, dim = c(4, 3, 2))

# 矩阵
m <- matrix(c(1, 2, 3, 4, 5, 6), 2, 3, byrow = T)
m[2, 3]
m[2, ] # 得到的是第二行作为向量
m[2, , drop = F] # 得到的是第二行作为矩阵

colnames(m) <- c('a', 'b', 'c')

# 创建单变量时间序列
y1 <- xts(rnorm(100),
          seq(as.POSIXct('2021-01-01'), len = 100, by = 'day'))

# 创建多元时间序列
multits_vals <- matrix(round(rnorm(25), 2), 5, 5)
colnames(multits_vals) <- paste('month', 1:5, sep = '')
y2 <- xts(multits_vals,
          as.POSIXct(c('2021-01-01', '2021-02-02', '2021-03-03', '2021-04-04',
                       '2021-04-05')))
y2['2021-04', c('month1', 'month2')]

# 获取时间标签
index(y2)

# 观测值
coredata(y2)

# dataset practice -------------------------------------------------------------
library(zoo)
df <- read_csv("MSCI Emerging Markets Historical Data.csv",
               col_names = TRUE)

# 日期从chr到date转化
df$Date <- as.Date(df$Date,
                   format='%B %d, %Y')
str(df)

# 产生单变量时间序列
df.zoo <- zoo(df$Price,
              order.by = df$Date) 

# 网站抓取时间序列 -------------------------------------------------------------
# 法一
library(tseries)
y <- as.xts(get.hist.quote('EEM', start = '2021-01-01',
                           end = '2021-03-19', quote = 'AdjClose'))
head(y)

# 法二
library(quantmod)
getSymbols('EEM')
y = EEM['2021-01-01/2021-03-19']
head(y)

# 不同数据源整合在同一个时间序列
getSymbolLookup(IBM = list('IBM', src = 'yahoo'),
                USDEUR = list('USD/EUR', src = 'oanda'))

