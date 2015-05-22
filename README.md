
## I- How the code works
### First we need some useful packages dplyr for data frame functions such as select/filter and plyr for ddply to do operations such as ## mean

### The first few steps is to load the data from the flat files both training and test sets 
### Then we combine the columns activity, subject codes, and feature using rbind
### Then we merge the two data frames for in one big frame using cbind and rbind
### That frame is processed to select the variables mean and std
### Finally a frame is created for output which will contain the mean for each of the variables for each subject/activity combination

### CODEBOOK ##### 

setwd("~/Desktop//Coursera/CleanProject/")

### 1. TestActivityLabels/TrainActivityLabels 
####Type: data frame
####Content: Contains the labels for the test activity from the activity file

#### 2. TestSubjectCodes/TrainSubjectCodes
#### Type: data frame
#### Content: The labels for subject codes

#### 3. Testfeatures/TrainFeatures
#### Type: Data frame
####  Content: The features file variables for Test/Train sets


#### 4. TestMergedData/TrainMergeData
#### Type: Data frame 
##### Content: Merging of TestSubjectCodes/TrainSubjectCodes,TestActivityLabels/TrainActivityLabels, TestFeatures/TrainFeatures






### Merged
#### Type: Data frame
#### Content: Containsthe merging of TestMergedData and TrainMergedData

### FeatureNames
### Type: Data frame
### Content: Contains the codes and label for each feature name

### IndexMeanStdOnly
#### Type: Vector
#### Content: Only the index of the FeatureNames where there is mean and std mentionned

### MergedMeanStdOnly
#### Type: Data frame
#### Content: Contains only the data for rows in the MergedData corresponding to index IndexMeanStdOnly

#### FinalMergedData
#### Type: Data frame
#### Content: MergedDataStdOnly but with activity labels described and feature columns named

#### TidySummaryMeanStd
#### Type: Data frame
#### Content: Contains the data frame for MergedDataStdOnly but summarized mean for each feauture