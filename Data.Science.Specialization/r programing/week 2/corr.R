library(dplyr)

corr <- function(directory, threshold=0, id= 1:332){
  
  old.dir <- getwd()
  setwd(directory)
  
  # Get a list of all the files in the directory and read them into a 
  # single dataframe
  list <- list.files(pattern="*.csv")
  list <- list[id]
  
  v <- vector(mode = "numeric", length=0)
  for(i in 1:length(list)){
    test <- read.csv(list[i])
    
    if(sum(complete.cases(test)) > threshold){
      test <- filter(test, complete.cases(test) == TRUE)
      v<- rbind(v, cor(test$nitrate, test$sulfate))}
  }
  
  # move the working directory back to where it was originally
  setwd(old.dir)

v
  
}



