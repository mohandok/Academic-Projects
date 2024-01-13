###EXPLORATORY DATA ANALYSIS


#Summary and dimension of combined table1 using enrollment dataset
summary(Combined_table1)
dim(Combined_table1)

#Scatterplot for the refined dataset
plot(SubsetData[,-1],col='blue')

#Table displaying the count of each gender category
Gender_table=table(SubsetData$gender)

#Count of each gender
SubsetData %>% ggplot(aes(gender, fill = gender)) + geom_bar()

#Count of each age category based on gender category
SubsetData %>% ggplot(aes(age_range, fill =gender )) + geom_bar()

#Plot to reveals the count of male and female enrolled in the given year range
SubsetData %>% ggplot(aes(enrolled_at, fill = gender)) + geom_bar()

#Summary and dimension of combined table2 using enrollment dataset
summary(Combined_table2)
dim(Combined_table2)

#Bar graph identifying the count of each response given by the profiles
Combined_table2 %>% ggplot(aes(leaving_reason ))+geom_bar()

#Count of people left the course during a given time frame based on each reason for leaving
Combined_table2 %>% ggplot(aes(left_at, fill=leaving_reason ))+geom_bar()

#Count of people based on each leaving reason
Combined_table2 %>% ggplot(aes(leaving_reason ))+geom_bar()
