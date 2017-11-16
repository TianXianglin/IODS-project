####################################################################
### Author: Anni Norring                                         ###
### Date: 16.11.2017 						                                 ###
### Content: This script contains the R code for RStudio         ###
###         Excercise 3 in IODS 2017. 						               ###
####################################################################

####################################################################
###                     DATA WRANGLING                           ###
####################################################################

### Part 2.

# The data was downloaded from https://archive.ics.uci.edu/ml/datasets/Student+Performance. At this point it consists of
#   data sets: students-mat.csv and students-por.csv, which are the results of two questionnaires answered by students
#   on a math class and on a portuguese class respectively.The aim is to combine these two data sets for further 
#   analysis.

####################################################################

### Part 3. 

## Read both sets of data into R from the IODS-project/data -folder:

# Start by checking the current working directory:
getwd()
# ... which is not the rignt one. Thus we need to:

# Set the working directory to be the IODS project folder:
setwd("\\\\ATKK/home/a/awsalo/Documents/GitHub/IODS-project/data")

# Next read both tables into R. From the file preview we can easily see that the data is separated by ;.
mat <- read.table("student-mat.csv", header = TRUE, sep = ";")
por <- read.table("student-por.csv", header = TRUE, sep = ";")

# Now we can explore the data frames a bit by using the familiar functions for looking at dimensions, structure, 
#   column names and first six rows of observations of the data.

dim(mat)
str(mat)
head(mat)
# The mat data frame has 395 observations on 33 variables. 

dim(por)
str(por)
head(por)
# The por data frameis somewhat larger, as it has 649 observations on 33 variables. 

# Next let's compare the column names of the two data frames:
colnames(mat)
colnames(por)
# From here it easy two see that the column names and thus variables are the same in both data frames. 










