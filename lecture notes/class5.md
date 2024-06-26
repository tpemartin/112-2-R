## AI preset

AI》
> ```交待的任務先以流暢文字重新描述一遍，再請我確認是否正確。等我回覆"正確"後，再去完成任務。任務完成使用到程式時一律使用R, 並盡量使用tidyverse語法, 答案以R script呈現  ```
 


- 請AI重新描述一次有助於確定任務沒被誤解

- 若不確定AI的描述是否正確，可以請它給個範例。

AI》（任務描述確認）
> 請給我一個範例說明你所理解的資料結構

## 有誤解的任務

AI》
> 將data欄位中的"博士班","碩士班","學士班"加總，data欄位中"學校類別"變成' 大專院校'，使得呈現'大專院校'對應"博士班","碩士班","學士班"

## 重新描述任務

AI》
> `df`是個dataframe裡頭有
> - `博士班`欄位代表博士班學生人數
> - `碩士班`欄位代表碩士班學生人數
> - `學士班`欄位代表學士班學生人數
> - `學校類別`欄位  
> 請計算學校類別為"大專院校"的學生總人數

# 貸款餘額年成長率

下載並引入
[央行消費貸款及建築貸款餘額](https://www.cbc.gov.tw/tw/cp-526-1078-7BD41-1.html)資料

計算裡面所有貸款餘額的年成長率。年成長率計算如下： 

- 本月貸款餘額年成長率 = (本月貸款餘額 - 去年同月貸款餘額) / 去年同月貸款餘額

例如: 110年2月的貸款餘額年成長率 = (110年2月貸款餘額 - 109年2月貸款餘額) / 109年2月貸款餘額

## Date/Time class

與日期有關的任務，時間相關欄位必須先轉換成R的Date/Time class

原始資料日期必需以西元年份來計錄

## AI prompt

AI》
> data frame `consumer` 有"年月底"欄位，它代表資料來自的年月，若其值有5個字則前3碼為年份，後兩碼為月份，若值有4個字則前2碼為年份後兩碼為月份; 這裡頭的年份值是正確西元年減1911的結果。請依"年月底"創造一個date time class的"日期"欄位

## 範例程式

```r

library(tidyverse)

# glimpse ---- 
glimpse(consumer)

consumer |>
  mutate(
    信用卡循環信用餘額 = as.double(信用卡循環信用餘額)
  ) -> 
  consumer

glimpse(consumer)

# date time -----
# 载入必要的库
library(lubridate)

# 根据"年月底"创建日期时间列
consumer$年份 <- as.integer(substr(consumer$年月底, 1, ifelse(nchar(consumer$年月底) == 5, 3, 2))) + 1911
consumer$月份 <- as.integer(substr(consumer$年月底, nchar(consumer$年月底) - 1, nchar(consumer$年月底)))

# 创建日期时间列
consumer$日期 <- ymd(paste(consumer$年份, consumer$月份, "01", sep = "-"))

# 移除临时创建的列
consumer <- subset(consumer, select = -c(年份, 月份))

# 查看结果
glimpse(consumer)

```
