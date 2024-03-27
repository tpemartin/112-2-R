# 前情提要

## AI preset

AI>
```
所有回答使用到程式時一律使用R, 並盡量使用tidyverse語法, 答案以R script呈現  
``` 

## Three Bonus Questions

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