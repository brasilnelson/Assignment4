---
title: "Code Book"
author: "Nelson Brasil Jr."
date: "9/29/2020"
output: html_document
---

## Pre Analysis
The script loads ``dplyr'' library and download the data to be used in this assignment

## 1. Read data and Merge

* subtest : subject IDs for test
* subtrain  : subject IDs for train
* xtest : test set
* xtrain : training set
* ytest : activity ID  in xtest
* ytrain : activity ID in xtrain
* lbs : activity labels for IDs in ytest and ytrain
* features : description(label) of each variables in xtest and xtrain
* AllData : bind of xtrain and xtest

## 2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset dataSet.

* featuresNames : a vector with mean and std labels extracted from features
* AllData : at the end of this step, AllData will only contain mean and std variables

## 3. Adding Subject and Activity to the AllData
Merge also ytrain with ytest and subtrain e subtest and create two new columns in AllData

* AllData$subject : column contain the bind of subtrain and subtest
* AllData$category : column contain the bind of ytrain and ytest

## 4. Changing Column label of AllData
Using descriptive activity names to name the activities in the data set replacing ID

* AllData$category: new column of AllData with activity labels instead ID

## 5. Rename the variables to a more intuitive names

* Change 'mean()' and 'std()' to capital
* Renaming 't' and 'f' to 'Time' and 'Frequency'
* Remove duplicate 'Body'
* 'Acc' to 'Accelerometer'
* 'Gyro' to 'Gyroscope'
* 'Mag' to 'Magnitude'
* 'MEAN()-[XYZ]' to '[XYZ]AxisMEAN'
* 'STD()-[XYZ]' to '[XYZ]AxisSTD'

## 6. Output tidy data
In this part we convert AllData in a tidy data

* AllData : converted to a 'tbl_df' table and after that group the data by category and subject
* tidy_data : summarise and take the mean by column