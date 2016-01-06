# import the necessary packages
if(!require(httr)){install.packages("httr")}
library(httr)  # Download the files from osf
if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names

# 集合原始資料url
## Part A參與者資料
A_urls <-  c(
    "https://osf.io/gyrd3/?action=download",
    "https://osf.io/9c2uq/?action=download",
    "https://osf.io/mht87/?action=download",
    "https://osf.io/sy673/?action=download",
    "https://osf.io/38vnh/?action=download",
    "https://osf.io/5tf3e/?action=download"
)

## Part B參與者資料
B_urls <-  c(
    "https://osf.io/qv7u8/?action=download",
    "https://osf.io/h5ukj/?action=download",
    "https://osf.io/bypjq/?action=download",
    "https://osf.io/h5ukj/?action=download",
    "https://osf.io/wz7tc/?action=download",
    "https://osf.io/2kpx3/?action=download"
)

# 命名下載後的檔案名稱
## Part A參與者資料
A_files <- paste0("A-", paste0(sprintf( "%02d", seq(1, length(A_urls)) ) ), ".csv") 
## Part B參與者資料
B_files <- paste0("B-", paste0(sprintf( "%02d", seq(1, length(B_urls)) ) ), ".csv") 

rawurls <- c(A_urls, B_urls)  # defalut filenames
filenames <- c(A_files, B_files)  # filenames for analysis


# 下載到本機指定資料夾

# change the working directory to 3_Data_Collection
setwd("./3_data_collection/")

dir.create("RAW", showWarnings = FALSE)
for(i in 1:length(rawurls)){
    GET(rawurls[i], write_disk(paste0("RAW/", filenames[i]), overwrite = TRUE))
    print(filenames[i])
}

rm(list=ls())  # clean all objects in the environment
