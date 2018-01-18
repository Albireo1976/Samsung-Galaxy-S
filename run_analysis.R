library(dplyr) #Load dplyr package

#Read original training and test data

datatest <- read.table("X_test.txt")
dataytest <- read.table("y_test.txt")
datatrain <- read.table("X_train.txt")
dataytrain <- read.table("y_train.txt")
datafeatures <- read.table("features.txt")

#Merge both datasets

datacomplete <- rbind(datatrain,datatest)
datay <- rbind(dataytrain,dataytest)

#look for mean and std values

vectorfeatures <- grep("mean()|std()",datafeatures[,2],perl = TRUE)

#Select mean and std variables from datacomplete

datacomplete <- datacomplete[,vectorfeatures]

#Provide datacomplete with variable labels

varnames <- datafeatures[vectorfeatures,2]
colnames(datacomplete) <- varnames
colnames(datay) <- "activity"
activity <- factor(datay[,1],levels=c(1,2,3,4,5,6),
           labels=c("walking","upstairs","downstairs","sitting","standing","laying"))
datafinal <- cbind(datacomplete,activity)

#Create tidy dataset

tdyds <- tapply(datafinal[,1],datafinal$activity,mean)

for (i in 2:length(varnames))
  {tdyds <- rbind(tdyds,tapply(datafinal[,i],datafinal$activity,mean))}
rownames(tdyds) <- varnames
write.table(tdyds,"tdyds.txt",row.name = FALSE)

#Delete unnecesary datasets

rm(datatest)
rm(datatrain)
rm(datacomplete)
rm(datay)
rm(dataytest)
rm(dataytrain)
rm(activity)
rm(varnames)
rm(vectorfeatures)
rm(datafeatures)
rm(i)



