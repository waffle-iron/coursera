pollutantMean<- function(directory, poll, id= 1:332){
 #### Purpose ####
 # calculate the mean of a given pollutant from data gathered
 # from potentially many files
 
 #### inputs ####
 # directory- character vector of length 1 that contains the path from the 
 #            working directory to the place the data files are stored
 # pollutant- the name of the pollutant we want to get the mean of
 # id - the id numbers of the files we want to include in the mean
 
 #### outputs #### 
 # mean- the mean of the specified pollutant
  
  
# store current working directory, then move it to the directory
# with the data the function will use
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

 #calculate the mean
 mean(df[[poll]], na.rm = TRUE)

 }





