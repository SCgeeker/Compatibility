if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names

setwd("../3_data_collection") # Run this line if you do not continue the work after downloaded files

filenames <- dir("RAW")

# 定義原始資料檔名,隨下載後的檔案名稱調整
# Init_name就是subject ID 
end_name <- ".csv"

# 讀入原始資料指定欄位到data frame
DF <- data.frame()  # 空白data frame，存放Stroop原始資料

for(i in 1:length(filenames)  ){
    subj0 <- read.csv(paste0("RAW/", filenames[i]), fileEncoding = "UTF-8")
    subj0 <- subj0[subj0$practice == "no" ,c("response_time", "correct", "EXPA", "EXPB", "soa","Compatibility")]  # Opensesame script has to have the accurate setting for cycles.
    
    subj_id <- gsub(end_name,"",filenames[i]) 

    print(subj_id)
    
    subj0 <- data.frame(ID = rep(subj_id, dim(subj0)[1]), trial = seq(dim(subj0)[1]), subj0)
    DF <- rbind(DF, subj0)
    rm(subj0,subj_id)
} 

# Write the code book
codebook_Raw <- data.frame(
    Variable = names(DF),
    Values = c("char","integer","numeric", "1,0", "yes,no", "yes,no","integer","y,n"),
    Description = c(
        "Filename is the subject ID",
        "sequence of trial",
        "raw response time at this trial",
        "1: this is a correct response; 0: this is a incorrect response",
        "yes: This is from EXPA, no: This is from EXPB",
        "yes: This is from EXPB, no: This is from EXPA",
        "soa of this trial",
        "y: this is a compatible target; n: this is an incompatible target"
    )
)

# Merge all raw data to a single file
write.csv(DF, file = "Compatibility_Raw.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")
write.csv(codebook_Raw, file = "Codebook_Raw.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")

rm(list = ls())  # clean all objects in the environment
