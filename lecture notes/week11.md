# 函數

由於程式多是一條直線式的執行（也叫single thread）到底，在每一段直線我們可以看到input（待解決任務的訊息）和output （任務解決後的產出）的影子，例如： 

https://github.com/tpemartin/112-2-R-EE/blob/476752febabf2d5125035169c7ad71dd8781eb04/Lecture%20notes/week10.md?plain=1#L75-L134

## 作法

[![](../img/2024-04-28-06-22-46.png)](https://www.figma.com/file/JF501BeiuwS0C1Hz0tfCyh/teaching-R?type=whiteboard&node-id=26-155&t=qoKsCm8otfQtDuNQ-4)

## 水平合併多學年


- [大專校院原住民學生及畢業生人數—按等級別與校別分](https://data.gov.tw/dataset/33514)  
- [大專院校校別學生數](https://data.gov.tw/dataset/6231)

[AI>>](./week11-prompt.md#水平合併多學年)



## 範例程式

```r
# recap week 10-----
# Downloading and importing data from the specified URL for the years 104 to 112
library(tidyverse)

# Create an empty list to store the data frames
allStudents <- list()

# Loop through years 104 to 112
for (year in 104:112) {
  # Construct the URL
  url <- glue::glue("https://stats.moe.gov.tw/files/detail/{year}/{year}_student.csv")
  
  # Read the CSV file from the URL and store it in the list
  student_data <- read_csv(url)
  
  # Add the data frame to the list
  allStudents[[as.character(year)]] <- student_data
}

# pivot longer -----
library(tidyr)

# 將資料框轉換成長格式
native112_long <- native112 %>%
  pivot_longer(
    cols = starts_with("在學學生人數_"),  # 選擇需要轉換的欄位
    names_to = "學制",  # 新的欄位名稱
    values_to = "在學學生人數"  # 新的值欄位名稱
  )  %>%
  mutate(學制 = gsub("在學學生人數_", "", 學制))  # 去除欄位名稱中的前綴

# 顯示前3行資料
glimpse(head(native112_long))


# pivot shorter ----
library(dplyr)

# 將資料框根據學校名稱和等級別進行分組，對除了學年度以外的數值型欄位進行加總
allStudent112_short <- allStudent112 %>%
  group_by(學年度, 學校名稱, 等級別) %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
  ungroup()

# 顯示前3行資料
glimpse(head(allStudent112_short))
```