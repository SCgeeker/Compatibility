# Making of Target Shapes

library("grid")
# Set up the size of stimuli figures and range of length
W <- 480
H <- 480
R <- 480

# Setup the storage of pictures
if(!file.exists("STI")){
    dir.create("STI")
}
setwd("./STI")



setwd("../")