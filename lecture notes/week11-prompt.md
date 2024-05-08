
## 水平合併112

進行外部水平合併，保留native112_long所有資料再併入其在allStudent112_short所有的欄位，合併的依據為: 學校名稱=學校名稱, 學制=等級別。等號左邊為native112_long的欄位，等號右邊為allStudent112_short的欄位。

## 水平合併109-112學年


有以下兩個連結：
"https://stats.moe.gov.tw/files/ebook/native/{year}/{year}native_A1-1.csv"
"https://stats.moe.gov.tw/files/detail/{year}/{year}_student.csv"
其中{year}從109到112， 每個{year}需要自這兩個連結分別下載檔案回來並引入到R，令引入的兩個資料框分別叫native和allStudent, 這兩個資料框要一起丟入函數merge_allStudent_native112(allStudent112=allStudent, native112=native)去處理得到的output請收錄在一個merged_data的list裡。
