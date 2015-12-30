if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names

filenames <- c("quickrun-A.csv","quickrun-B.csv")

# 定義原始資料檔名,隨下載後的檔案名稱調整
# Init_name就是subject ID 
end_name <- ".csv"

# 讀入原始資料指定欄位到data frame
DF <- data.frame()  # 空白data frame，存放Stroop原始資料

for(i in 1:length(filenames)  ){
    subj0 <- read.csv(paste0("RAW/", filenames[i]), fileEncoding = "UTF-8")
    subj0 <- subj0[subj0$practice == "no",c("response_time", "correct", "EXPA", "EXPB", "soa","Compatibility")] 
    
    subj_id <- gsub(end_name,"",filenames[i]) 

    print(subj_id)
    
    subj0 <- data.frame(ID = rep(subj_id, dim(subj0)[1]), subj0)
    DF <- rbind(DF, subj0)
    rm(subj0,subj_id)
} 

write.csv(DF, file = "Compatibility_Raw.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")

EXPA_RAW <- DF[DF$EXPA == "yes" & DF$correct == 1,]
EXPB_RAW <- DF[DF$EXPB == "yes" & DF$correct == 1,]

EXPA_RT <- with(data = EXPA_RAW, tapply(response_time, paste("ID",paste("soa","Compatibility","_"),"_"),mean))
EXPA_ACC <- with(data = EXPA_RAW, tapply(correct, paste("ID",paste("soa","Compatibility","_"),"_"),sum))/16

EXPA <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPA_RT), "_") ), ncol = 5, byrow = TRUE, dimnames = list(NULL,c("ID","SOA","Compatibility"))),
    RT = EXPA_RT,
    ACC = EXPA_ACC,
    row.names = NULL
)


EXPB_RT <- with(data = EXPB_RAW, tapply(response_time, paste("ID",paste("soa","Compatibility","_"),"_"),mean))
EXPB_ACC <- with(data = EXPB_RAW, tapply(correct, paste("ID",paste("soa","Compatibility","_"),"_"),sum))/16

EXPB <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPB_RT), "_") ), ncol = 5, byrow = TRUE, dimnames = list(NULL,c("ID","SOA","Compatibility"))),
    RT = EXPB_RT,
    ACC = EXPB_ACC,
    row.names = NULL
)
