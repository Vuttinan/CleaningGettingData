#Read all txt file in unzip floder, train and test folder
readme_all<-readLines("README.txt")
readme_all
feature_info<-readLines("features,info.txt")
feature_info
#Getting 6 activity for 561 data variables by 30 persons or subjects
activity_labels<-read.table("activity_labels.txt", sep=",")
dim(activity_labels)
features<-read.table("features.txt", sep=",")
dim(features)
#In test and train floder for 2947 observation testing and 7352 observation
#training, including observation data
#Change directory
y_train<-read.table("y_train.txt",sep=",")
X_train<-read.table("X_train.txt",sep=",")
subject_train<-read.table("subject_train.txt",sep=",")
dim(y_train);dim(X_train);dim(subject_train)
#test floder by Change directory
y_test<-read.table("y_test.txt",sep=",")
X_test<-read.table("X_test.txt",sep=",")
subject_test<-read.table("subject_test.txt",sep=",")
dim(y_test);dim(X_test);dim(subject_test)
#10299 obesrvation in 561 variables by 30 sujects on 6 activities.
#Setting header name
names(y_train)<-c("activity_lables")
names(y_test)<-c("activity_lables")
names(subject_train)<-c("subject_lables")
names(subject_test)<-c("subject_lables")
names(X_train)<-c(features)
names(X_test)<-c(features)
#Combine in train and test data
data_train<-cbind(1,subject_train,y_train,X_train)
data_test<-cbind(1,subject_test,y_test, X_test)
#Include to train and test data 
data_all<-rbind(data_train,data_test)
dim(data_all)
#Check all data to 10299x563
#names(data_all) for header name
#Finding variable name for mean() and std()
get_mean<-grep("mean()", names(data_all), value = TRUE)
get_std<-grep("std()", names(data_all), value = TRUE)
#Define variable wanted
subject_data<-data_all[,"subject_lables"]
activit_data<-data_all[,"activity_labels"]
mean_data<-data_all[ , get_mean]
std_data<-data_all[ , get_std]
#Combine to all data in mean and standard devation value
data_tidy<-cbind(subject_data, activity_data, mean_data, std_data)
#Write on data_tidy file in text format.
write.table(data_tidy, file = "data_tidy.txt", sep = ",", row.name=FALSE)
#Seperated to a table for mean and std of each subject group
#Seperated to a table for mean and std of each activity group
data_tidy_sub <- select(data_tidy, -activity_data)
data_tidy_act <- select(data_tidy, -subject_data)
#Split in 30 subject group and 6 activity group, including mean in each group.
aa <- sapply(split(data_tidy_sub,data_tidy_sub$subject_data), FUN = colMeans)
data_tidy_subMean <- t(aa)
bb <- sapply(split(data_tidy_act,data_tidy_act$activity_data), FUN = colMeans)
data_tidy_actMean <- t(bb)
#write dataset with the average on each variable for each activity and subject.
write.table(data_tidy_subMean, file = "data_tidy_subMean.txt", sep = ",", row.name=FALSE)
write.table(data_tidy_actMean, file = "data_tidy_actMean.txt", sep = ",", row.name=FALSE)


 


