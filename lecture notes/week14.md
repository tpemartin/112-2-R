# Recap

## 水平合併112學年

主程式：  
```r
# 引入根目錄的 merge.R
source("merge.R") 

library(tidyverse)
# 112 ----
# 下載並引入原住民生資料----
native112 <- read.csv("https://stats.moe.gov.tw/files/ebook/native/112/112native_A1-1.csv")

# 下載並引入全校學生資料----
allStudent112 <- read.csv("https://stats.moe.gov.tw/files/detail/112/112_student.csv")

# 引入 merge_allStudent_native112 函數
source("r/merge.R")

# 使用 merge_allStudent_native112 函數合併資料集
merged_data112 <- merge_allStudent_native112(allStudent112, native112)


## 計算原住民學生比例 ----
merged_data112 %>%
  mutate(
    原住民比例 = 原住民生人數 / 總計
  ) -> merged_data112

```

  - [merge.R](../merge.R) 要存放在project根目錄下。
  


# 資料說明

## 整體描述

有多少欄位？有多少筆資料？

## 欄位說明

有多少缺失值？ 佔多少比例？  

### 連續型

全距，平均數，極大值，極小值。
四分位數，中位數。

### 間斷資料

#### 類別型

當類別少於 10 個時，列出：
各類別的數量。  
各類別的比例。  
當類別大於與等於 10 個時，只列出各類別的數量。

#### 純文字


## AI prompt設計

針對data frame進行資料描述遵守以下規則：  
  1. 先整體描述資料有多少欄位，多少筆資料。再進行逐欄描述。  
  2. 針對每一個欄位，先描述有多少缺失值，佔多少比例。  
  3. 若欄位為連續型，則需描述全距，平均數，極大值，極小值，四分位數，中位數。  
  4. 若欄位為間斷資料，先判斷是否低於10類，若低於10類，則需描述各類別的數量，各類別的比例。當類別大於與等於 10 個時，只列出各類別的數量。 
資料描述的各別結果請存在一個list裡並各別給予適當的元素名稱。  

