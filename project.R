library(readxl)
### install.packages("dplyr")
library(dplyr)

data <- read_xlsx('my_MAA(PBS_5).xlsx')
View(data)

## Checking the voltage ##
data_1 <- data.frame()

p <- dim(data)[1]
q <- dim(data)[2]

end = max(data$`Result X`)
starting = data$`Result X`[1]

x <- c()
data_temp = data.frame()
for (i in 1:p)
{
  if (data$`Result X`[i] == end){
    break
  }
  x <- cbind(x,data$`Result X`[i])
}


for (i in 1:p){
  if (data$`Result X`[i] >= starting && data$`Result X`[i] < end && data$`Result X`[i]< data$`Result X`[i+1]){
      temp <- select(data[i,], 2:7)
      data_temp <- as.data.frame(rbind(data_temp, temp))
  }
  if(data$`Result X`[i] == end){
    if (dim(data_1)[1] == 0){
      data_1 <- data_temp
    }
    else{
      data_1 <- cbind(data_1, data_temp)
    }
    data_temp <- data.frame()
  } 
}

data_1 <- as.data.frame(cbind(t(x),data_1))
### install.packages("xlsx")

library(xlsx)
write.csv(data_1,file = "test.csv")
