# 迴圈

AI》
> 什麼是迴圈？

## AI assistant preset

AI》
> ```You are a teaching assistant of introductory R. You use R in tidyverse style for assistance. If you are asked for scripts, your answer is only in R scripts and in tidyverse format with concise comments -- no other non-script explanation is required. The first line of your code chunk must be a comment line that can form script outline in RStudio. Its format is `# {{summary_title}} -----` where `{{summary_title}}` is your short summary of the assisting task. Other R script rules are: whenever there is a need to show result, if the result is a data frame, slice its first 3 rows and use `glimpse`; otherwise, use `head` instead of `print`. ```
>
> ```When dealing with date/time data, always use `lubridate` package. When dealing with string, always use `stringr` package. When merging data frames, always use `dplyr` package. When looping, always use `for` or `while` loop -- avoid `map`. ```  
> 
> ```If you understand your role, say it -- no need to show any code at this time.```


## 歷年原住民學生人數

[大專校院原住民學生及畢業生人數—按等級別與校別分](https://data.gov.tw/dataset/33514)

104至112年原住民學生人數資料  

- <https://stats.moe.gov.tw/files/ebook/native/104/104native_A1-1.csv>
- ...
- <https://stats.moe.gov.tw/files/ebook/native/112/112native_A1-1.csv>

### 任務

AI》
> ```由`https://stats.moe.gov.tw/files/ebook/native/{{學年}}/{{學年}}native_A1-1.csv`下載資料，並引入到R，其中`{{學年}}`為104至112年，引入的資料收錄到一個名為`native`的`list` ```

AI》
> ```由`https://stats.moe.gov.tw/files/ebook/native/{{學年}}/{{學年}}native_A1-1.csv`下載資料，並引入到R，其中`{{學年}}`為104至112年，引入的資料收錄到一個名為`native`的`list`而引入產生的資料框必需新增`學年`欄位記錄資料所屬學年 ```

### 垂直合併

> ```將native list中的每個資料框選出"學校名稱", "在學學生人數_博士班", "在學學生人數_碩士班", "在學學生人數_學士班","學年"欄位後，再垂直堆疊成一個資料框，並命名為`native_df` ```

## 練習

[大專院校校別學生數](https://data.gov.tw/dataset/6231)