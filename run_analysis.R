#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measuresetments on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set the working directory
setwd("~/Desktop//Coursera/CleanProject/")
# Install the packagers
library(dplyr)
T1<-0
Tr1<-0
Merged<-0
MergedMeanStd<-0
indexmeanstd<-0
# Extract test data
TestActivityLabels<-read.table("y_test.txt") # Activity labels
TestSubjectCodes<-read.table("subject_test.txt") # Subject numbers
TestFeatures<-read.table("X_test.txt")  # Features data

# Put them in one large data fram

TestMergedData<-cbind(TestSubjectCodes,TestActivityLabels,TestFeatures)

# Get the feature names

names(TestMergedData)<-c("subject","activity",1:561)


# Extract training data

TrainActivityLabels<-read.table("y_train.txt") # Activity labels
TrainSubjectCodes<-read.table("subject_train.txt") # subject numbers
TrainFeatures<-read.table("X_train.txt") # Training feature sets

# Put them in one large data frame

TrainMergedData<-cbind(TrainSubjectCodes,TrainActivityLabels,TrainFeatures) 
names(TrainMergedData)<-c("subject","activity",1:561)

Merged<-rbind(TestMergedData,TrainMergedData) # Creates one large data set

# Exctract only mean and standard deviation
# First read the feature file
FeatureNames<-read.table("features.txt")
names(FeatureNames)<-c("code","labels")
# Then extract only the lines corresponding to means and standard deviations

#grep("mean()|std()",FeatureNames$labels)

IndexMeanStdOnly<-grep("mean()|std()",FeatureNames$labels)

IndexMeanStdOnly1<-IndexMeanStdOnly+2 # Shift by two

MergedMeanStdOnly<-Merged[,c(1:2,IndexMeanStdOnly1)] 


# Remains last step of renaming the activity descriptions like walking,running, etc
# Descriptive variable names

MapActivityLabel<-cbind(c(1:6),c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
names(MapActivityLabel)<-c("index","name")
# Create a mapping table where the numbers and their corresponding description are displayed 

LengthOfMergedData<-dim(MergedMeanStdOnly)
for (i in 1:LengthOfMergedData[1])
        
        { MergedMeanStdOnly$activity[i]<-as.character(MergedMeanStdOnly$activity[i])
          MergedMeanStdOnly$activity[i]<-MapActivityLabel[as.numeric(MergedMeanStdOnly$activity[i]),2]
}
   
# Then change the names of feature variables

Temp1<-select(MergedMeanStdOnly,-(subject:activity))
Temp2<-select(MergedMeanStdOnly,(subject:activity))

# Now change the column names for .

colnames(Temp1)<-FeatureNames[IndexMeanStd,2]

FinalMergedData<-cbind(Temp2,Temp1)




# Now calculate the mean for each column by each activity and subject combination
# New Data set
TidySummaryMeanStd<-ddply(FinalMergedData, .(subject,activity), colwise(mean))
write.table(TidySummaryMeanStd,row.name=FALSE) 


