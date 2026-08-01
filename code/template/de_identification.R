# ------------------------------------------------------------------------------------------------ #
#            RST 2025 Data Coding Best Practices Exercise - De-identification                      #
#                                                                                                  #
# The first section is the starter code to de-identify our example data. 						   #
# The second section is a set of de-identification exercises to do after you finish				   #
# data cleaning.																				   #
#                                                                                                  #
# ------------------------------------------------------------------------------------------------ #

# Load required libraries
library(dplyr)

######### In-lecture example: Masking names ##################################
data <- read.csv(file.path(id_data, paste0("pulls1_", pull_tot, ".csv")))

##### First create the crosswalk: ###############
# Create the full name variable, drop the first and last names, and drop duplicates
crosswalk <- data %>%
  select(id, Q1, Q2) %>%
  mutate(full_name = paste(Q1, Q2)) %>%
  select(id, full_name) %>%
  distinct()

# Save the crosswalk into the identified folder as a csv
write.csv(crosswalk, file.path(id_data, "Name_crosswalk.csv"),row.names = F)

# Mask the identifying variables and save
data_masked <- data %>%
  mutate(
    Q1 = "*** REMOVED FOR RESPONDENT PRIVACY ***",
    Q2 = "*** REMOVED FOR RESPONDENT PRIVACY ***"
  )

write.csv(data_masked, file.path(raw_data, paste0("pulls1_", pull_tot, "_deid.csv")),row.names = F)

######### Post-lecture exercise: ##############################################
##### Prepare the clean data that doesn't have direct identifiers for 
# data publication -- we want to de-identify indirect identifiers now
clean_data_path <- file.path(clean_data, "cleaned_data_pulls1_3.csv")
data_clean <- read.csv(clean_data_path)

# STEP A -- Aggregate birth month to ranges and mask birth date
# Mask birth date


# STEP B -- Encode gender so that groups can still be made by gender, but 
# 		you can no longer tell which group is which gender. Save a crosswalk. 
#		HINT: encode always codes alphanumerically -- how would you create a
#		random encoding for gender?


# STEP C -- "Bottom-code" and "Top-code" birth year so that very old and very young
#			participants are grouped together


# STEP D -- Aggregate the cleaned education level variable to only two buckets


# STEP E -- Calculate the k-anonymity of the dataset along Birth year, gender, and education
#			Hint: a dataset with K-n anonymity would have observations that are equivalent to at least n-1 other observations along the concerning variables -- a good use case for "group" and "group_by"!
