# ------------------------------------------------------------------------------------------------ #
#            RST 2025 Data Coding Best Practices Exercise - De-identification                      #
#                                                                                                  #
# The first section is the starter code to de-identify our example data.                           #
# The second section is a set of de-identification exercises to do after you finish                #
# data cleaning.                                                                                   #
#                                                                                                  #
# ------------------------------------------------------------------------------------------------ #

from pathlib import Path

import pandas as pd

######### In-lecture example: Masking names ##################################
data = pd.read_csv(Path(id_data) / f"pulls1_{pull_tot}.csv")

##### First create the crosswalk: ###############
# Create the full name variable, drop the first and last names, and drop duplicates
crosswalk = data[["id", "Q1", "Q2"]].copy()
crosswalk["full_name"] = crosswalk["Q1"] + " " + crosswalk["Q2"]
crosswalk = crosswalk[["id", "full_name"]].drop_duplicates()

# Save the crosswalk into the identified folder as a csv
crosswalk.to_csv(Path(id_data) / "Name_crosswalk.csv", index=False)

# Mask the identifying variables and save
data_masked = data.copy()
for col in ["Q1", "Q2"]:
    data_masked[col] = "*** REMOVED FOR RESPONDENT PRIVACY ***"

data_masked.to_csv(Path(raw_data) / f"pulls1_{pull_tot}_deid.csv", index=False)

######### Post-lecture exercise: ##############################################
##### Prepare the clean data that doesn't have direct identifiers for
# data publication -- we want to de-identify indirect identifiers now
data_clean = pd.read_csv(Path(clean_data) / "cleaned_data_pulls1_3.csv")

# STEP A -- Aggregate birth month to ranges and mask birth date
# Mask birth date


# STEP B -- Encode gender so that groups can still be made by gender, but
# 		you can no longer tell which group is which gender. Save a crosswalk.
#		HINT: a simple map from labels to integers is alphabetical by default --
#		how would you create a random encoding for gender?


# STEP C -- "Bottom-code" and "Top-code" birth year so that very old and very young
#			participants are grouped together


# STEP D -- Aggregate the cleaned education level variable to only two buckets


# STEP E -- Calculate the k-anonymity of the dataset along Birth year, gender, and education
#			Hint: a dataset with K-n anonymity would have observations that are equivalent to
#			at least n-1 other observations along the concerning variables -- a good use case
#			for groupby and transform/size!
