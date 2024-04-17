# AI assistant

AI》
> ```You are an assistant of data analysis. You use R in tidyverse style for assistance. If you are asked for scripts, your answer is only in R scripts with concise comments -- no other non-script explanation is required. The first line of your code chunk must be a comment line. Its format is `# {{summary_title}} -----` where `{{summary_title}}` is your short summary of the assisting task. Other R script rules are: whenever there is a need to show result, if the result is a data frame, slice its first 3 rows and use `glimpse`; otherwise, use `head` instead of `print`. ```
>
> 
> ```If you understand your role, say it -- no need to show any code at this time.```

# 貸款餘額年成長率

下載並引入
[央行消費貸款及建築貸款餘額](https://www.cbc.gov.tw/tw/cp-526-1078-7BD41-1.html)資料

計算裡面所有貸款餘額的年成長率。年成長率計算如下： 

- 本月貸款餘額年成長率 = (本月貸款餘額 - 去年同月貸款餘額) / 去年同月貸款餘額

例如: 110年2月的貸款餘額年成長率 = (110年2月貸款餘額 - 109年2月貸款餘額) / 109年2月貸款餘額

## Recap

AI》
```
 `consumer` data frame has the following stucture:
$ 年月底               <dbl> 7710
$ `消費者貸款小  計`   <dbl> 789392
$ `購置住宅   貸款`    <dbl> 383881
$ `房屋修繕   貸款`    <dbl> 223095
$ 汽車貸款             <dbl> 8030
$ 機關團體職工福利貸款 <dbl> 60785
$ 其他個人消費性貸款   <dbl> 113601
$ 信用卡循環信用餘額   <chr> "-"
$ 建築貸款             <dbl> 49413

For 信用卡循環信用餘額, change it to numeric class. For 年月底, separate it into 民國年 and 月 columns, where 月 column is the last 2 characters from 年月底, and the remaining characters are 民國年.
```

```  
Create a 日期 date class column, where its year is from 民國年 turned numeric then add 1911 and its month is from 月. There is no date.
```

## 計算所有貸款餘額的年成長率

# 水平合併

想像有兩個資料框（data frame）, 分別放在左手（left）和右手（right）, 水平合併就是把這兩個資料框合併在一起。

![水平合併](../img/data-join.png)

## 合併方式

  - left_join: 保留左邊的資料框所有資料，右邊的資料框有對應的資料則合併，沒有則填入NA
  - right_join: 保留右邊的資料框所有資料，左邊的資料框有對應的資料則合併，沒有則填入NA
  - inner_join: 保留兩個資料框"共"有的資料
  - full_join: 保留兩個資料框"所有"資料，有對應的資料則合併，沒有則填入NA

### 合併結果

![合併結果](../img/joined-data.png)

## id欄位

id欄位是用來合併的依據。

> 相同名稱、性別的人當是同一人合併在一起，則id欄位是兩個資料框各自的名稱、性別欄位。

## AI prompt

AI》

> 將df_left與df_right進行水平合併：
>  - id欄位依據: "名稱", "性別"欄位，
>  - 合併方式: {{join method}}

`{{join_method}}`: 
    - 保留df_left的所有資料,
    - 保留df_right的所有資料,
    - 保留兩個資料框「共有」的資料,
    - 保留兩個資料框「所有」資料
  
## 練習範例

```r
# 水平合併
df_left <- data.frame(
  name = c("小明", "小王", "小美"),
  gender = c("男", "女", "女"),
  birthday = c("1990-01-01", "1991-02-02", "1992-03-03")
)

df_right <- data.frame(
  name = c("小明", "小華", "小王"),
  gender = c("男", "男", "男"),
  blood_type = c("A", "B", "O")
)
```

## 注意事項

- id欄位的計錄方式要一致，不能有一邊男性寫成"男"，另一邊寫成"男性"。

```r
df_right2 <- data.frame(
  name = c("小明", "小華", "小王"),
  gender = c("男性", "男性", "男性"),
  blood_type = c("A", "B", "O")
)
```

## 練習題

[中央銀行利率](https://cpx.cbc.gov.tw/Range/RangeSelect?pxfilename=EG2AM01.px)  
[央行消費貸款及建築貸款餘額](https://www.cbc.gov.tw/tw/cp-526-1078-7BD41-1.html)

