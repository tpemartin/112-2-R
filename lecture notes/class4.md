# 前情提要

上課要點的4個連結
![上課要點的4個連結](../img/2024-03-27-14-55-45.png)

- AI preset
- 引入csv檔案
- 資料探索

## AI preset

AI>
```
所有回答使用到程式時一律使用R, 並盡量使用tidyverse語法, 答案以R script呈現  
``` 

## Key concept: （AI）清楚交待探索資料的物件資訊

  - 使用到R環境裡什麼物件（名稱）？物件類型（class）是什麼？
  - 要回答這個問題，需要使用這物件裡什麼元素？元素類型是什麼？

先執行Three Bonus Questions程式，再執行：
```r
glimpse(dataNative)
```

## Three Bonus Questions

入載[112學年大專校院原住民學生及畢業生人數](https://data.gov.tw/dataset/33514)的CSV檔，並引入到R

```r
# 前情提要----

## 引入csv ------
library(tidyverse)

# 讀取CSV檔案
dataNative <- read_csv("104native_A1-1.csv")

## data exploration ----

### 計算國/私立大學的（原住民）學士班在學學生人數 ----
# 假設您的資料框為"data"

# 計算國立大學學士班在學學生人數
national_students <- dataNative %>%
  filter(str_detect(學校名稱, "^國立")) %>%  # 使用正則表達式篩選以"國立"開頭的學校名稱
  summarise(total_students = sum(在學學生人數_學士班)) %>%
  pull(total_students)

# 計算私立大學學士班在學學生人數
private_students <- dataNative %>%
  filter(!str_detect(學校名稱, "^國立")) %>%  # 使用正則表達式排除以"國立"開頭的學校名稱，即私立大學
  summarise(total_students = sum(在學學生人數_學士班)) %>%
  pull(total_students)

# 印出結果
cat("國立大學學士班在學學生人數:", national_students, "\n")
cat("私立大學學士班在學學生人數:", private_students, "\n")

### 由dataNative自由發揮兩個問題 ----
#### (bonus 1pt)----

#### (bonus 1pt)----

# (bonus 3pt) 非原住民學生的研究所人數/學士班人數比例----


```

 - <https://data.gov.tw/dataset/33508>