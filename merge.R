merge_allStudent_native112 <- function(allStudent112, native112){
  
  # allStudent112 = allStudent
  # native112 = native
  library(dplyr)
  
  # 水平合併-----
  
  ## 長式化----
  native112_long <- native112 %>%
    pivot_longer(cols = starts_with("在學學生人數"), 
                 names_to = "學制", 
                 values_to = "在學學生人數") %>%
    mutate(學制 = str_extract(學制, "(?<=_).+"))  # 提取學制名稱
  
  native112_long <- native112_long |>
    select(學年度,學校名稱, 學制, 在學學生人數)
  
  # 瀏覽前3行
  glimpse(head(native112_long, 3))
  
  # allStudent112 <- fix_allStudent_class(allStudent112)
  
  ## 短化----
  # 將資料精簡並加總相同學校名稱、等級別的數值型欄位
  allStudent112_short <- allStudent112 %>%
    group_by(學校名稱, 等級別) %>%
    summarise(across(where(is.numeric), sum))
  
  # 瀏覽前3行
  glimpse(head(allStudent112_short, 3))
  
  # 合併 -----
  library(dplyr)
  library(stringr)
  
  # Remove "班" from the "學制" column in native112_long
  native112_long <- native112_long %>%
    mutate(學制 = str_remove(學制, "班"))
  
  # Remove leading whitespace and everything before it from the "等級別" column in allStudent112_short
  allStudent112_short <- allStudent112_short %>%
    mutate(等級別 = str_trim(str_extract(等級別, "(?<=\\s).*")))
  
  # Merge allStudent112_short into native112_long based on school name and 學制/等級別
  merged_data <- native112_long %>%
    left_join(allStudent112_short |> select(-學年度), by = c("學校名稱" = "學校名稱", "學制" = "等級別"))
  
  # Display the first 3 rows and structure of the resulting merged data frame
  glimpse(head(merged_data, 3))
  
  # 更改 '在學學生人數' 欄位名為 "原住民生人數"
  merged_data <- merged_data |>
    rename("原住民生人數"='在學學生人數')
  
  # 只留下想要的欄位
  # merged_data <- merged_data |>
  #   select(學年度, 學校名稱, 學制, 原住民生人數, 總計)
  # 
  # # 計算各學制原住民生比例
  # merged_data <- merged_data |>
  #   mutate(
  #     原住民生比例 = 原住民生人數/總計
  #   )
  # 
  # # 去除有NA的rows
  # merged_data <- merged_data |> na.omit()
  
  return(merged_data)
}

create_total <- function(df){
  library(dplyr)
  
  # 计算总和并添加到数据框中
  df <- df %>%
    mutate(總計 = rowSums(select(., starts_with("一年級男生"):ends_with("延修生女生")), na.rm=T))
  
  return(df)
}

fix_allStudent_class <- function(allStudent112){
  library(dplyr)
  
  # 将字符型列转换为数值型列
  allStudent112 <- allStudent112 %>%
    mutate(across(matches("^一年級男生$|^一年級女生$|^二年級男生$|^二年級女生$|^三年級男生$|^三年級女生$|^四年級男生$|^四年級女生$|^五年級男生$|^五年級女生$|^六年級男生$|^六年級女生$|^七年級男生$|^七年級女生$|^延修生男生$|^延修生女生$"), 
                  ~as.numeric(gsub(",", "", .))))
  
  return(allStudent112)
  
}