# ------------------------------------------------------------------------------------------------ #
#             RST 2025 Data Coding Best Practices Exercise - Data Cleaning                         #
#                                                                                                  #
# Provided are example steps needed to clean the code. Follow the instructions to complete the     #
# exercise. Remember to follow best practices discussed in the lecture.                            #
#                                                                                                  #
# ------------------------------------------------------------------------------------------------ #

# Load required libraries
library(dplyr)
library(labelled)

# Load the de-identified data
data <- read.csv(file.path(raw_data, paste0("pulls1_", pull_tot, "_deid.csv")))

####################################################################################################
# STEP A -- Rename the variables to be more intuitive. (refer to the code book)
####################################################################################################


####################################################################################################
# STEP B -- Label the variables based on the questions in the code book.
####################################################################################################


####################################################################################################
# STEP C -- Generate a variable indicating gender to be a dummy variable (either male or female)
####################################################################################################


####################################################################################################
# STEP D -- For the missing application dates that don't need an answer, recode them as "N/A" (.n). 
#           For the missing application dates that should be there, recode them as "don't know" (.d)
####################################################################################################


####################################################################################################                
# STEP E -- Save the data without overriding the original data.
####################################################################################################

