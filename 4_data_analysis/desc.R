# Making of tidy data
# Do descriptive statistics
if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names, we always need this package

setwd("../4_data_collection") # Run this line if you break at the last session
EXPA <- read.csv("Compatibility_A.csv") # Run this line if you break at the last session
EXPB <- read.csv("Compatibility_B.csv") # Run this line if you break at the last session


EXPA_M_RT <- with(data = EXPA, tapply(RT, paste(SOA, Compatibility, sep = "_"), mean))
EXPA_M_RT.sd <- with(data = EXPA, tapply(RT, paste(SOA, Compatibility, sep = "_"), sd))
EXPA_M_ACC <- with(data = EXPA, tapply(ACC, paste(SOA, Compatibility, sep = "_"), mean))
EXPA_M_ACC.sd <- with(data = EXPA, tapply(ACC, paste(SOA, Compatibility, sep = "_"), sd))

EXPA_Table <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPA_M_RT), "_") ), ncol = 2, byrow = TRUE, dimnames = list(NULL,c("SOA","Compatibility"))),
    n = nlevels(EXPA$ID),
    RT = EXPA_M_RT,
    RT.sd = EXPA_M_RT.sd,
    ACC = EXPA_M_ACC,
    ACC.sd = EXPA_M_ACC.sd,
    row.names = NULL
)  # Summarize EXPA data by subject

EXPA_Table <- EXPA_Table[order(as.numeric(as.character(EXPA_Table$SOA))),] # sort data by SOA


EXPB_M_RT <- with(data = EXPB, tapply(RT, paste(SOA, Compatibility, sep = "_"), mean))
EXPB_M_RT.sd <- with(data = EXPB, tapply(RT, paste(SOA, Compatibility, sep = "_"), sd))
EXPB_M_ACC <- with(data = EXPB, tapply(ACC, paste(SOA, Compatibility, sep = "_"), mean))
EXPB_M_ACC.sd <- with(data = EXPB, tapply(ACC, paste(SOA, Compatibility, sep = "_"), sd))

EXPB_Table <- data.frame(
    matrix( unlist( stri_split_coll(names(EXPB_M_RT), "_") ), ncol = 2, byrow = TRUE, dimnames = list(NULL,c("SOA","Compatibility"))),
    n = nlevels(EXPB$ID),
    RT = EXPB_M_RT,
    RT.sd = EXPB_M_RT.sd,
    ACC = EXPB_M_ACC,
    ACC.sd = EXPB_M_ACC.sd,
    row.names = NULL
)  # Summarize EXPA data by subject

EXPB_Table <- EXPB_Table[order(as.numeric(as.character(EXPB_M$SOA))),] # sort data by SOA

# We are going to reproduce Figure 2 in use of EXPA_Table and EXPB_Table