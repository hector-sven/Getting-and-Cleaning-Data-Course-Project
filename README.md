# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

## About the source 

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone with embedded inertial sensors collected from the Samsung Galaxy S smartphone. 

Source. http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## About the files 

CodeBook.md - Describes the variables, the data, and any transformations or work that you performed to clean up the data 

run_analysis.R - Script will generate a file called *tidy.txt* which contains the final dataset containing the average of all the features 
grouped by subject and activity.

tidy.txt - Output file generated using run_analysis.R 

## Execute the script 

The script can be run from *RStudio* after setting the working directory to the local path 
    
> source("run_analysis.R")

