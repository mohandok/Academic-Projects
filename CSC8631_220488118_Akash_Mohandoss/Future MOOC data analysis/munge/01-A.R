#Preprocessing Libraries
library("ggplot2")                  
library("GGally") 
library("dplyr")
library("ggpubr")
library("cowplot")
library("tidyverse")
library("lubridate")

# preprocessing script.

#Combining enrollment data of all 7 runs
Combined_table1 <-rbind(cyber.security.1_enrolments,cyber.security.2_enrolments,cyber.security.3_enrolments,cyber.security.4_enrolments,cyber.security.5_enrolments,cyber.security.6_enrolments,cyber.security.7_enrolments)

#Filtering the unknown, NA, and NULL values
Combined_table1<-Combined_table1[!(Combined_table1$gender=="Unknown"),]
Combined_table1<-Combined_table1[!(Combined_table1$country=="Unknown"),]
Combined_table1<-Combined_table1[!(Combined_table1$age_range=="Unknown"),]
Combined_table1<-Combined_table1[!(Combined_table1$age_range=="NA"),]
Combined_table1<-Combined_table1[!(Combined_table1$enrolled_at=="Unknown"),]
Combined_table1<- Combined_table1[!is.na(Combined_table1$unenrolled_at), ]
Combined_table1<-Combined_table1[!(Combined_table1$enrolled_at=="NA"),]
Combined_table1<-Combined_table1[!(Combined_table1$detected_country=="--"),]
Combined_table1<-Combined_table1[!(Combined_table1$unenrolled_at==" "),]

#Converting the enrolled datatimestamp column to year format
Combined_table1$enrolled_at=year(Combined_table1$enrolled_at)

#Filtering only the required columns
SubsetData= Combined_table1 [c(1:3,7,9,10,11,13)]

#Omitting NA values
SubsetData=na.omit(SubsetData)

#Display the characteristics of each column
str(SubsetData)

#Combining Leaving response data of all 7 runs
Combined_table2 <-rbind(cyber.security.1_leaving.survey.responses,cyber.security.2_leaving.survey.responses,cyber.security.3_leaving.survey.responses,cyber.security.4_leaving.survey.responses,cyber.security.5_leaving.survey.responses,cyber.security.6_leaving.survey.responses,cyber.security.7_leaving.survey.responses)

#Converting the left_at datatimestamp column to year format
Combined_table2$left_at=year(Combined_table2$left_at)

#Omitting NA values
Combined_table2<-na.omit(Combined_table2)

#Filtering only the required columns
SubsetData1<-Combined_table2[c(3,4)]




