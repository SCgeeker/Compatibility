# Making of ANOVA and post hoc tests
if(!require(stringi)){install.packages("stringi")}
library(stringi) # Procoss the variable names, we always need this package

setwd("../4_data_collection") # Run this line if you break at the last session
EXPA <- read.csv("Compatibility_A.csv") # Run this line if you break at the last session
EXPB <- read.csv("Compatibility_B.csv") # Run this line if you break at the last session

EXPA.aov <- summary(aov(RT <- SOA*Compatibility, data = EXPA)) # original ANOVA in the paper
EXPB.aov <- summary(aov(RT <- SOA*Compatibility, data = EXPB)) # original ANOVA in the paper