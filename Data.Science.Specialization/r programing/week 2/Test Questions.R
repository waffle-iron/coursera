source("pollutantmean.R")
source("corr.R")
source("complete.R")


# Q1
pollutantMean("specdata", "sulfate", 1:10)

# Q2
pollutantMean("specdata", "nitrate", 70:72)

# Q3
pollutantMean("specdata", "sulfate", 34)

# Q4
pollutantMean("specdata", "nitrate")

# Q5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

# Q6
cc <- complete("specdata", 54)
print(cc$nobs)

# Q7
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

# Q8
cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

# Q9
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

# Q10
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))