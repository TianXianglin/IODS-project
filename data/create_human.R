####################################################################
### Author: Anni Norring                                         ###
### Date: 24.11.2017 						                                 ###
### Content: This script contains the R code for RStudio         ###
###         Excercise 4 in IODS 2017. 						               ###
####################################################################

####################################################################
###                     DATA WRANGLING                           ###
####################################################################

### Part 2: Read the data into R

## Read both sets of data into R:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# The data sets contain data in the human development index (hd) and the gender inequality index (gii).

####################################################################

### Part 3: Explore the data

# Now we can explore the dataframes a bit by using the familiar functions for looking at dimensions, structure, 
#   column names and first six rows of observations of the data.

dim(hd)
str(hd)
head(hd)
summary(hd)
colnames(hd)

# The hd dataframe has 195 observations on 8 variables. The dataframe and the first six rows appear OK and are
#   consistent with the tables on page http://hdr.undp.org/en/composite/HDI. From the summary we can see the crucial 
#   moments of the variables. The column names are quite long, and we will change them in the next part.

dim(gii)
str(gii)
head(gii)
summary(gii)
colnames(gii)

# The gii dataframe has 195 observations on 10 variables. The dataframe and the first six rows appear OK. However, they
#   are not exactly the same as on http://hdr.undp.org/en/composite/GII. Perhaps the data or the table has been updated?
#   From the summary we can see the crucial moments of the variables. The column names are quite long, and we will 
#   change them in the next part.

####################################################################

### Part 4: Rename the variables

# Let's start with the names of variables in the hd dataset: 

colnames(hd)[1] <- "HDIrank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "explife"
colnames(hd)[5] <- "expschool"
colnames(hd)[6] <- "meanschool"
colnames(hd)[7] <- "GNIpercap"
colnames(hd)[8] <- "diffGNIrankHDIrank"

# Check the new names:

colnames(hd)

# Then change the names of variables in the gii dataset:

colnames(gii)[1] <- "GIIrank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "matmor"
colnames(gii)[5] <- "teenbirth"
colnames(gii)[6] <- "mpF"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labF"
colnames(gii)[10] <- "labM"

# Check the new names:

colnames(gii)

####################################################################

### Part 5: Create new variables

# Next we will create two new variables from the gii dataset. First one is the ratio of female and male populations
#   with secondary education in each country. The second is a similar ratio for labor force participation. We will 
#   call these new variables edu and lab respectively.

edu <- gii$edu2F/gii$edu2M
lab <- gii$labF/gii$labM

# Include the new variables in the dataset:

gii$edu <- edu
gii$lab <- lab

# Check that everything is ok:
colnames(gii)
head(gii)

####################################################################

### Part 6: Join the two datasets

# In this last part we join two datasets using the variable country as the identifier.

# We will join the data sets using inner.join() function as in the DataCamp exercises. With this function we will end
#   up with a data set that contains only the students who answered the questionnaires on both classes. 

# Access the dplyr library:
library(dplyr)

# Choose country as the identifier to identify the countries present in both rankings:
join_by <- c("country")

# Join the two datasets by the selected identifier:
human <- inner_join(hd, gii, by = join_by)

# Glimpse at the data:
glimpse(human)

# Lastly, we'll save the joined and modified data set to the data folder. In order not to run into working directory
#   problems while working with analysis part, we will save the data set to the same working directory as the 
#   RMarkdown file we will use for the analysis.

# Set the working directory to be the IODS project folder:
setwd("\\\\ATKK/home/a/awsalo/Documents/GitHub/IODS-project")

# Save the data set:
write.table(human, file = "human.csv", sep = ",", col.names = TRUE)

####################################################################

