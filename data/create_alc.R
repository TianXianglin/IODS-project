####################################################################
### Author: Anni Norring                                         ###
### Date: 16.11.2017 						                                 ###
### Content: This script contains the R code for RStudio         ###
###         Excercise 3 in IODS 2017. 						               ###
####################################################################

####################################################################
###                     DATA WRANGLING                           ###
####################################################################

### Part 2

# The data was downloaded from https://archive.ics.uci.edu/ml/datasets/Student+Performance. At this point it consists 
#   of two data sets: students-mat.csv and students-por.csv, which are the results of two questionnaires answered 
#   by students on a math class and on a portuguese class respectively.The aim is to combine these two data sets for 
#   further analysis.

####################################################################

### Part 3 

## Read both sets of data into R from the IODS-project/data -folder:

# Start by checking the current working directory:
getwd()
# ... which is not the right one. Thus we need to:

# Set the working directory to be the IODS project folder:
setwd("\\\\ATKK/home/a/awsalo/Documents/GitHub/IODS-project/data")

# Next read both tables into R. From the file preview we can easily see that the data is separated by ;.
math <- read.table("student-mat.csv", header = TRUE, sep = ";")
por <- read.table("student-por.csv", header = TRUE, sep = ";")

# Now we can explore the data frames a bit by using the familiar functions for looking at dimensions, structure, 
#   column names and first six rows of observations of the data.

dim(math)
str(math)
head(math)
# The mat data frame has 395 observations on 33 variables. The data frame and the first six rows appear OK.

dim(por)
str(por)
head(por)
# The por data frame is somewhat larger, as it has 649 observations on 33 variables.  The data frame and the first 
#   six rows appear OK.

# Next let's compare the column names of the two data frames:
colnames(math)
colnames(por)
# From here it easy two see that the column names and thus variables are the same in both data frames. 

####################################################################

### Part 4

## Join the two data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", 
##  "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers. Keep only the students present in both 
##   data sets. Explore the structure and dimensions of the joined data.

# We will join the data sets using inner.join() function as in the DataCamp exercises. With this function we will end
#   up with a data set that contains only the students who answered the questionnaires on both classes. 

# Access the dplyr library:
library(dplyr)

# Choose common columns to use as identifiers to identify the students that answered both surveys:
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# Join the two datasets by the selected identifiers. Now we have a data set that includes only the students that 
#   answered both surveys:
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# See the new column names:
colnames(math_por)
# Note that some of the columns don't have and some do have a suffix that refers to the original data sets. The ones
#   that don't have a suffix are those 13 common variables that we used to identify the students that answered both 
#   surveys. 

# See the dimensions, structure and first six rows of the new data set:
dim(math_por)
str(math_por)
head(math_por)
# The new data set has 382 observations on 53 variables.

# Glimpse at the data. Note that this function also gives us the dimensions of the data set.
glimpse(math_por)
# From here one could note that there appears to be more common columns, such as "guardian", "schoolsup" and "famsup".
#   Perhaps these could have also been included in the identifiers?

####################################################################

### Part 5

##  Copy the solution from the DataCamp exercise The if-else structure to combine the 'duplicated' answers in 
##    the joined data.

# We'll start by creating a new data frame with only the joined columns. We'll name it alc, as we are aiming to study
#   the alcohol consumption of these students. 
alc <- select(math_por, one_of(join_by))

# Choose the columns in the datasets which were not used for joining the data and name them notjoined_columns. Recall
#   that the logical operator ! means NOT and thus our function assigns all the variables that are NOT in the join_by
#   object into an object called notjoined_columns. Note that we are using the original colnames in math, and not the
#   colnames in the new data set math_por. 
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# Print out the columns not used for joining to check that they are the correct ones:
notjoined_columns

# Next use a combination of the foor-loop and the if-else structure to combine the duplicated answers (possibly 
#   different answers to the same questions for each student) present in the new data set.  We combine these answers
#   by either taking a rounded average of numeric variables or choosing the first answer for non-numeric variables:

# For every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # and select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Glimpse at the new combined data:
glimpse(alc)
# There are no more variables with a suffix in the name. 

####################################################################

### Part 6

## Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 
##    'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for 
##    students for which 'alc_use' is greater than 2 (and FALSE otherwise).

# First we define a new column alc_use by combining weekday and weekend alcohol use and taking their average:
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Then we define a new logical column 'high_use' which takes value TRUE if the the value of alc_use is greater than
#   two, and value FALSE otherwise.
alc <- mutate(alc, high_use = alc_use > 2)

####################################################################

### Part 7

# Glimpse at the new combined data:
glimpse(alc)
# Everything appears to be OK. There are 382 observations of 35 variables, i.e. just as we should have.

# Lastly, we'll save the joined and modified data set to the data folder. In order not to run into working directory
#   problems while working with analysis part, we will save the data set to the same working directory as the 
#   RMarkdown file we will use for the analysis.

# Set the working directory to be the IODS project folder:
setwd("\\\\ATKK/home/a/awsalo/Documents/GitHub/IODS-project")

# Save the data set:
write.table(alc, file = "alc.csv", sep = ";", col.names = TRUE)



####################################################################




