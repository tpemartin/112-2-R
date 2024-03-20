
# 國私立大學學士班學生數

有一個叫做data的data frame，它有以下欄位： 
- "學校名稱"：文字，例如"國立政治大學"，"輔仁大學"等等，其中名字有"國立"開頭的為國立大學，否則為私立大學
- "在學學生人數_學士班"： 數字

分別計算國立私大學學士班在學學生人數

```
library(tidyverse)

# 假設您的資料框為"data"

# 計算國立大學學士班在學學生人數
national_students <- data %>%
  filter(str_detect(學校名稱, "^國立")) %>%  # 使用正則表達式篩選以"國立"開頭的學校名稱
  summarise(total_students = sum(在學學生人數_學士班)) %>%
  pull(total_students)

# 計算私立大學學士班在學學生人數
private_students <- data %>%
  filter(!str_detect(學校名稱, "^國立")) %>%  # 使用正則表達式排除以"國立"開頭的學校名稱，即私立大學
  summarise(total_students = sum(在學學生人數_學士班)) %>%
  pull(total_students)

# 印出結果
cat("國立大學學士班在學學生人數:", national_students, "\n")
cat("私立大學學士班在學學生人數:", private_students, "\n")
```
