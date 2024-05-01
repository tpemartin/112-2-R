# Recap 水平合併


## 資料引入

[![](../img/2024-04-27-06-15-11.png)](https://www.figma.com/file/JF501BeiuwS0C1Hz0tfCyh/Untitled?type=whiteboard&node-id=2%3A3686&t=BARRjc7ixXajW9ay-1)


## 資料合併

### 水平合併

一個identity （身份）在data frame只會出現一次

它的經濟意義是由特定欄位值決定。例如：

  - 經濟意義：一個人，由名字、性別、生日等等決定，要同名同姓同性別同生日的人才算是同一個人。
  - 經濟意義：一個公司，由公司名稱、公司地址等等決定，要同名同地址的公司才算是同一個公司。

兩個資料框要能水平合併必需有"同樣義意"的identity。

#### `native112`

![](../img/2024-04-27-09-06-05.png)

一個identity代表一間大學，由學校名稱決定，要同名的學校才算是同一間學校。

#### `allStudent112`

![](../img/2024-04-27-09-07-03.png)

一個identity代表一個學制，它由學校名稱、日間/進修別、等級別決定，要同名、同日間/進修別、同等級別的學制才算是同一個學制。

#### identity轉換

##### 大定義轉小定義

針對identity定義大的進行轉換，"一間大學"包含"好幾個學制"，所以針對"一間大學"的identity進行轉換。

> identity轉換會將大定義的identy轉換為小定義的identity，所以原先的一筆資料會變成很多筆資料，資料框會變"長"，是"長式"轉換，會用到`pivot_longer`函數。

[AI>>](./week10-prompt.md#大定義轉小定義)

![](../img/2024-04-27-09-38-13.png)

一個identity代表一個學制，它由學校名稱、等級別決定，要同名、同等級別的學制才算是同一個學制 -- 注意這裡沒有日間/進修別之分。

##### 小定義轉大定義

一個identity代表一個學制，它由學校名稱、日間/進修別、等級別決定，要轉成一個identity為不分日間/進修別的學制，就是小定義轉大定義。

> identity轉換會將小定義的identy轉換為大定義的identity，所以原先的好幾筆資料（不同日間/進修別，但相同學校名稱，等級別 會變成一筆資料，資料框會變"短" -- 但沒有`pivot_shorter`函數，要小心XDDD。

[AI>>](./week10-prompt.md#小定義轉大定義)

![](../img/2024-04-27-09-56-47.png)

一個identity代表一個學制，它由學校名稱、等級別決定，要同名、同等級別的學制才算是同一個學制 -- 這裡已經沒有日間/進修別之分。

#### 水平合併



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