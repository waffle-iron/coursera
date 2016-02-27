library(dplyr)

complete <- function(directory, id= 1:332){
  
  old.dir <- getwd()
  setwd(directory)
  
  # Get a list of all the files in the directory and read them into a 
  # single dataframe
  list <- list.files(pattern="*.csv")
  list <- list[id]
  
  df <- data.frame()
  for(i in 1:length(list)){
    df<- rbind(df, read.csv(list[i]))
  }
  
  # move the working directory back to where it was originally
  setwd(old.dir)
  
 df <- df[complete.cases(df),]
 df %>% group_by(ID) %>% summarise(nobs= n())

}

