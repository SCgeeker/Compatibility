# Clean the raw data
if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names, we always need this package

setwd("../3_data_collection") # Run this line if you break at the last session
DF <- read.csv("Compatibility_Raw.csv")  # Run this line if you do not continue the work after managed files
Codebook_Raw <- read.csv("Codebook_Raw.csv")  # Run this line if you do not continue the work after managed files

EXPA_RAW <- DF[DF$EXPA == "yes" & DF$correct == 1,]
EXPB_RAW <- DF[DF$EXPB == "yes" & DF$correct == 1,]

EXPA_RT <- with(data = EXPA_RAW, tapply(response_time, paste(ID,paste(soa,Compatibility,sep = "_"),sep = "_"),mean))
EXPA_ACC <- with(data = EXPA_RAW, tapply(correct, paste(ID,paste(soa,Compatibility,sep = "_"),sep = "_"),sum))/16

EXPA <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPA_RT), "_") ), ncol = 3, byrow = TRUE, dimnames = list(NULL,c("ID","SOA","Compatibility"))),
    RT = EXPA_RT,
    ACC = EXPA_ACC,
    row.names = NULL
)  # Summarize EXPA data by subject

EXPB_RT <- with(data = EXPB_RAW, tapply(response_time, paste(ID,paste(soa,Compatibility,sep = "_"),sep = "_"),mean))
EXPB_ACC <- with(data = EXPB_RAW, tapply(correct, paste(ID,paste(soa,Compatibility,sep = "_"),sep = "_"),sum))/16

EXPB <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPB_RT), "_") ), ncol = 3, byrow = TRUE, dimnames = list(NULL,c("ID","SOA","Compatibility"))),
    RT = EXPB_RT,
    ACC = EXPB_ACC,
    row.names = NULL
) # Summarize EXPB data by subject


# Write the code book for cleaned data
Codebook_Clean <- data.frame(
    Variable = names(EXPA),
    Values = c("char","integer","y or n", "numeric", "numeric"),
    Description = c(
        "Filename is the subject ID",
        "SOA for this condition",
        "y: this is a compatible condition; n: this is an incompatible condition",
        "Average correct response time for this subject at this condition",
        "Average accruacy for this subject at this condition"
    )
)

# Save the cleaned data
write.csv(EXPA, file = "../4_data_analysis/Compatibility_A.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")
write.csv(EXPB, file = "../4_data_analysis/Compatibility_B.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")
write.csv(Codebook_Clean, file = "../4_data_analysis/Codebook_Clean.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")

rm(list = ls()) # remove all objects in the environment
