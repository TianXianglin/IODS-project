####################################################################
### Author: Anni Norring                                         ###
### Date: 9.11.2017 						                                 ###
### Content: This script contains the R code for RStudio         ###
###         Excercise 2 in IODS 2017. 						               ###
####################################################################

####################################################################
###                     DATA WRANGLING                           ###
####################################################################

### 2nd PART

## Read the data:

# Start the excercise by reading the learning2014 data from the given web page:

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

## Look at the dimensions and the structure of the data:

# The first function tells the dimensions of the data set, i.e. how many rows and columns the data frame has. 
# The second function lets one look at the structure of the data.

dim(lrn14)
str(lrn14)

# The data frame has 183 rows and 60 columns, or, the data contains 183 observations of 60 variables. From the output of 
# str one should note that here the columns are printed as rows in the conventional sense.

####################################################################

### 3rd PART

## Create an analysis dataset with variables gender, age, attitude, deep, stra, surf and points by combining questions:

# Start by downloading the needed dplyr package:

install.packages("dplyr")

# Then continue following datacamp excercises:

# Access the dplyr library
library(dplyr)

# Combine questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

##Scale all combination variables to the original scales (take the mean):

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# see the stucture of the new dataset
str(lrn14)


# From the structure we can see that we could tidy the dataset a bit further (following the datacamp excercises). 
#  In addition to scaling the combination variables back to the original scales, we will also scale "Attitude" back to 
#  the Likert scale and change the names of "Age" and "Points:

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# change the name of the second column
colnames(lrn14)[2] <- "age"

# change the name of "Points" to "points"
colnames(lrn14)[7] <- "points"

# Next select the columns we want to keep:
keep_columns <- c("gender","age","attitude", "deep", "stra", "surf", "points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)


##Exclude observations where the exam points variable is zero:

# This can be done by selecting only rows where points is greater than zero:
learning2014 <- filter(learning2014, points > 0)

# Check the dimensions and structure of the new dataset:
dim(learning2014)

str(learning2014)

# The dataset has 183 observations and 7 variables, which is similar to what was obtained in the datacamp excercise,
# but not the 166 observations mentioned in the RStudio excercise 2. ¯\_(???)_/¯


####################################################################

### 4th PART

## Set the working directory of you R session the iods project folder (study how to do this with RStudio).

# Support for this could be found at 
# https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces

# Check the current working directory:
getwd()

# Set the working directoru to be the IODS project folder:
setwd("\\\\ATKK/home/a/awsalo/Documents/GitHub/IODS-project")

## Save the analysis dataset to the 'data' folder, using for example write.csv() or write.table() functions. 
#   You can name the data set for example as learning2014(.txt or .csv). 
#   See ?write.csv for help or search the web for pointers and examples. 

write.table(learning2014, file = "learning2014.csv", sep = "\t", col.names = TRUE)

## Demonstrate that you can also read the data again by using read.table() or read.csv().  
#   (Use `str()` and `head()` to make sure that the structure of the data is correct).

read.table("learning2014.csv", header = TRUE, sep = "\t")

str(learning2014)
head(learning2014)

# Everything seems to be OK.

####################################################################
