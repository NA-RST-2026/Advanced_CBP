# ------------------------------------------------------------------------------------------------ #
#            RST 2025 Data Coding Best Practices Exercise - Data Validation                        #
#                                                                                                  #
# Provided is the starter code to validate our example data. Continue working on the code to       #
# check for the outlined issues. Remember to make error messages descriptive so you know what      #
# issues to address with your data provider.                                                       #
#                                                                                                  #
# ------------------------------------------------------------------------------------------------ #

# Load required libraries
library(dplyr)

# Create output directory if it doesn't exist
if (!dir.exists("output")) {
  dir.create("output")
}

# Start logging
sink("output/data_validation_log.txt", split = TRUE)

cat("=== Data Validation Log ===\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Check to see that id uniquely identifies observations in all pulls and that IDs are in the same format.
for (i in 1:pull_tot) { # pull_tot set in main R file to indicate the total pull files
  data_pull <- read.csv(file.path(id_data, paste0("pull", i, ".csv")))
  
  # Format of ID variable?
  cat("Dataset pull", i, "ID format:\n")
  cat("ID variable class:", class(data_pull$id), "\n")
  cat("ID variable type:", typeof(data_pull$id), "\n")
  
  # Does ID uniquely identify observations in pull?
  id_duplicates <- data_pull %>%
    group_by(id) %>%
    summarise(count = n(), .groups = 'drop') %>%
    filter(count > 1)
  
  if (nrow(id_duplicates) > 0) {
    cat("DUPLICATE IDS EXIST IN DATASET pull", i, ". THE FOLLOWING HAVE A NON-UNIQUE ID:\n")
    
    duplicate_data <- data_pull %>%
      group_by(id) %>%
      filter(n() > 1) %>%
      select(id, Q1, Q2, starts_with("Q3"))
    
    print(duplicate_data)
    
    # If the ID does not uniquely identify observations in pull, check to see if a combination of ID and name do.
    id_name_duplicates <- data_pull %>%
      group_by(id, Q1, Q2) %>%
      summarise(count = n(), .groups = 'drop') %>%
      filter(count > 1)
    
    if (nrow(id_name_duplicates) > 0) {
      cat("ID, first and last name DO NOT uniquely identify observations in pull", i, ".\n")
    } else {
      cat("ID, first and last name uniquely identify observations in pull", i, ".\n")
    }
  } else {
    cat("No duplicate IDs exist in pull", i, ".\n")
  }
  cat("\n")
}

# Append the pulls together
data_combined <- read.csv(file.path(id_data, "pull3.csv"))
data_pull1 <- read.csv(file.path(id_data, "pull1.csv"))
data_pull2 <- read.csv(file.path(id_data, "pull2.csv"))

data_combined <- bind_rows(data_combined, data_pull1, data_pull2) %>%
  arrange(id, Q1, Q2, pull)

write.csv(data_combined, file.path(id_data, paste0("pulls1_", pull_tot, ".csv")),row.names = F)

# Verify we have appropriate follow-up information on the people is consistent.

# Make sure everyone appears exactly twice, except for in the most recent pull
follow_up_check <- data_combined %>%
  group_by(id, Q1, Q2) %>%
  summarise(
    multiple_pulls = n(),
    pulls = list(pull),
    .groups = 'drop'
  )

# Check for missing follow-ups
missing_followups <- follow_up_check %>%
  filter(multiple_pulls == 1 & !sapply(pulls, function(x) pull_tot %in% x))

if (nrow(missing_followups) > 0) {
  cat("Some people did not have a follow up recorded in data. See the following:\n")
  
  missing_detail <- data_combined %>%
    semi_join(missing_followups, by = c("id", "Q1", "Q2")) %>%
    select(id, Q1, Q2, pull)
  
  print(missing_detail)
} else {
  cat("Follow up visits recorded for all expected individuals.\n")
}

# Make sure the visits were in consecutive quarters/pulls.
consecutive_check <- follow_up_check %>%
  filter(multiple_pulls == 2) %>%
  mutate(
    consecutive = sapply(pulls, function(x) {
      sorted_pulls <- sort(x)
      sorted_pulls[2] == (sorted_pulls[1] + 1)
    })
  ) %>%
  filter(!consecutive)

if (nrow(consecutive_check) > 0) {
  cat("Some people did not have a CONSECUTIVE follow up recorded in data. See the following:\n")
  
  nonconsecutive_detail <- data_combined %>%
    semi_join(consecutive_check, by = c("id", "Q1", "Q2")) %>%
    select(id, Q1, Q2, pull)
  
  print(nonconsecutive_detail)
} else {
  cat("Follow up visits recorded consecutively for all expected individuals.\n")
}

# Make sure information is consistent between the two pulls for consecutive pulls.
vars_to_check <- c("Q5", grep("Q3", names(data_combined), value = TRUE), 
                   grep("region", names(data_combined), value = TRUE), 
                   "treat", "Q4")

for (var in vars_to_check) {
  if (var %in% names(data_combined)) {
    inconsistency_check <- data_combined %>%
      group_by(id, Q1, Q2) %>%
      filter(n() > 1) %>%
      summarise(
        inconsistent = length(unique(!!sym(var))) > 1,
        .groups = 'drop'
      ) %>%
      filter(inconsistent)
    
    if (nrow(inconsistency_check) > 0) {
      cat("The variable", var, "is not consistent across pulls for the following people:\n")
      
      inconsistent_detail <- data_combined %>%
        semi_join(inconsistency_check, by = c("id", "Q1", "Q2")) %>%
        select(id, Q1, Q2, !!sym(var))
      
      print(inconsistent_detail)
    } else {
      cat("The variable", var, "is consistent across pulls.\n")
    }
  }
}

cat("It seems like there are a few quality issues with our data.\n")
cat("Some seem to be due to typos and others look like the provider changed how they coded key variables.\n\n")

####################################################################################################
############ Work in your group to write code/pseudocode for one of the steps below ################
####################################################################################################

####################################################################################################
# STEP A -- Verify education is coded as documented in data documentation.
####################################################################################################


####################################################################################################
# STEP B -- Confirm that birth dates are inputted correctly.
####################################################################################################


####################################################################################################
# STEP C -- Confirm that treatment is assigned correctly.
####################################################################################################


####################################################################################################
# STEP D -- Confirm that sex is coded as expected.
####################################################################################################


####################################################################################################
# STEP E -- Confirm that application dates are inputted correctly.
####################################################################################################


# End logging
sink()

cat("Data validation complete. Check output/data_validation_log.txt for detailed results.\n")
