library(googlesheets4)
sheet <- list()
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1DSo3OMe_UpHmkU3Dn6S1m5VCqZNWT6OFGd_gHXp342Y/edit#gid=407625616",
                          sheet = "final-project-grade") -> sheet$final_project_grade

library(tidyverse)
glimpse(sheet)

# pivot longer
sheet$final_project_grade %>%
  rename('評分來源'='作品') %>%
  pivot_longer(cols = -c(1), names_to = "作品", values_to = "分數") -> sheet$final_project_grade_long

sheet$final_project_grade_long %>%
  glimpse()

# pivot wider 
sheet$final_project_grade_long %>%
  pivot_wider(names_from = "評分來源", values_from = "分數") -> sheet$final_project_grade_wide

googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1DSo3OMe_UpHmkU3Dn6S1m5VCqZNWT6OFGd_gHXp342Y/edit#gid=407625616",
                          sheet = "修課名單") -> sheet$student_list

sheet$student_list %>% glimpse()

# merge final project to student list
sheet$student_list %>%
  select(學號, 姓名, 作品) %>%
  mutate(作品 = as.character(作品)) %>%
  left_join(sheet$final_project_grade_wide, by = c("作品")) -> sheet$student_list_final_project

sheet$student_list_final_project %>%
  glimpse()

# read only the first 19 rows
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1DSo3OMe_UpHmkU3Dn6S1m5VCqZNWT6OFGd_gHXp342Y/edit#gid=407625616",
                          sheet = "attendance", n_max=18) -> sheet$attendance

sheet$attendance %>%
  glimpse()

# 進修部
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1LOdVCNJ6CVWlNvNiBwiVb0PI2r_5wCv8wlvMFoesnNU/edit#gid=31304972",
                          sheet = "出席")  %>%
  rename("累積出席成績"="累積出席分數") -> sheet$attendance_continuing_education

# bind rows with the previous attendance
sheet$attendance %>%
  select(學號, 累積出席成績) %>% 
  bind_rows(
    sheet$attendance_continuing_education |>
      select(學號, 累積出席成績)) -> sheet$attendance_all

sheet$attendance_all %>%
  glimpse()


# merge attendance to student list final project
sheet$attendance_all %>%
  select(學號, 累積出席成績) %>%
  right_join(sheet$student_list_final_project, by = c("學號")) -> sheet$student_list_final_project_attendance

sheet$student_list_final_project_attendance  


# bonus
googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1DSo3OMe_UpHmkU3Dn6S1m5VCqZNWT6OFGd_gHXp342Y/edit#gid=407625616",
                          sheet = "bonus") -> sheet$bonus

sheet$bonus %>%
  select(學號, 加分) |>
  right_join(sheet$student_list_final_project_attendance, by = c("學號")) -> sheet$student_list_final_project_attendance_bonus

sheet$student_list_final_project_attendance_bonus %>%
  glimpse()


# compute the final grade 
sheet$student_list_final_project_attendance_bonus %>%
  mutate(加分 = pmin(ifelse(is.na(加分), 0, 加分),5)) %>%
  mutate(專題成績 = (學生評分*0.5+教師評分*0.5)*8) %>%
  mutate(累積出席成績 = ifelse(is.na(累積出席成績), 0, 累積出席成績)) %>%
  mutate(學期原始成績 = ifelse(is.na(專題成績),0, 專題成績) + 累積出席成績) -> 
  sheet$semester_grade

googlesheets4::write_sheet(
  sheet$semester_grade,
  "https://docs.google.com/spreadsheets/d/1DSo3OMe_UpHmkU3Dn6S1m5VCqZNWT6OFGd_gHXp342Y/edit#gid=407625616",
  sheet="semester-grade")
