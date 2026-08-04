# ------------------------------------------------------------------------------------------------ #
#            RST 2026 Data Coding Best Practices Exercise - Data Validation                        #
#                                                                                                  #
# Provided is the starter code to validate our example data. Continue working on the code to       #
# check for the outlined issues. Remember to make error messages descriptive so you know what      #
# issues to address with your data provider.                                                       #
#                                                                                                  #
# ------------------------------------------------------------------------------------------------ #

from datetime import datetime
from pathlib import Path

import pandas as pd

# Create output directory if it doesn't exist
output_dir = Path("output")
output_dir.mkdir(exist_ok=True)

# Start logging (print to console and write to file)
log_path = output_dir / "data_validation_log.txt"
log_file = open(log_path, "w")


def log(msg=""):
    """Print a message to the console and append it to the validation log."""
    print(msg)
    log_file.write(msg + "\n")


log("=== Data Validation Log ===")
log(f"Date: {datetime.now():%Y-%m-%d %H:%M:%S}")
log()

# Check to see that id uniquely identifies observations in all pulls and that IDs are in the same format.
for i in range(1, NUM_PULLS + 1):  # NUM_PULLS set in your config file
    data_pull = pd.read_csv(Path(RAW_DATA) / "pulls" / f"pull_{i}" / f"pull{i}.csv")

    # Format of ID variable?
    log(f"Dataset pull {i} ID format:")
    log(f"ID variable dtype: {data_pull['id'].dtype}")
    log(f"ID variable Python type (first non-null): {type(data_pull['id'].dropna().iloc[0]).__name__}")

    # Does ID uniquely identify observations in pull?
    id_counts = data_pull.groupby("id").size()
    has_duplicate_ids = (id_counts > 1).any()

    if has_duplicate_ids:
        log(f"DUPLICATE IDS EXIST IN DATASET pull {i}. THE FOLLOWING HAVE A NON-UNIQUE ID:")

        duplicate_ids = id_counts[id_counts > 1].index
        q3_cols = [c for c in data_pull.columns if c.startswith("Q3")]
        duplicate_data = data_pull.loc[
            data_pull["id"].isin(duplicate_ids),
            ["id", "Q1", "Q2", *q3_cols],
        ]
        log(duplicate_data.to_string())

        # If the ID does not uniquely identify observations in pull, check to see if a combination of ID and name do.
        id_name_counts = data_pull.groupby(["id", "Q1", "Q2"]).size()
        if (id_name_counts > 1).any():
            log(f"ID, first and last name DO NOT uniquely identify observations in pull {i}.")
        else:
            log(f"ID, first and last name uniquely identify observations in pull {i}.")
    else:
        log(f"No duplicate IDs exist in pull {i}.")
    log()

# Append the pulls together
pull_dfs = [
    pd.read_csv(Path(RAW_DATA) / "pulls" / f"pull_{i}" / f"pull{i}.csv")
    for i in range(1, NUM_PULLS + 1)
]
data_combined = (
    pd.concat(pull_dfs, ignore_index=True)
    .sort_values(["id", "Q1", "Q2", "pull"])
)

data_combined.to_csv(Path(RAW_DATA) / f"pulls1_{NUM_PULLS}.csv", index=False)

# Verify we have appropriate follow-up information on the people is consistent.

# Make sure everyone appears exactly twice, except for in the most recent pull
follow_up_check = (
    data_combined.groupby(["id", "Q1", "Q2"], as_index=False)
    .agg(multiple_pulls=("pull", "size"), pulls=("pull", list))
)

# Check for missing follow-ups
missing_followups = follow_up_check[
    (follow_up_check["multiple_pulls"] == 1)
    & (~follow_up_check["pulls"].apply(lambda p: NUM_PULLS in p))
]

if len(missing_followups) > 0:
    log("Some people did not have a follow up recorded in data. See the following:")

    missing_detail = data_combined.merge(
        missing_followups[["id", "Q1", "Q2"]],
        on=["id", "Q1", "Q2"],
        how="inner",
    )[["id", "Q1", "Q2", "pull"]]
    log(missing_detail.to_string())
else:
    log("Follow up visits recorded for all expected individuals.")

# Make sure the visits were in consecutive quarters/pulls.
def is_consecutive(pulls):
    sorted_pulls = sorted(pulls)
    return sorted_pulls[1] == sorted_pulls[0] + 1


consecutive_check = follow_up_check[follow_up_check["multiple_pulls"] == 2].copy()
consecutive_check["consecutive"] = consecutive_check["pulls"].apply(is_consecutive)
nonconsecutive = consecutive_check[~consecutive_check["consecutive"]]

if len(nonconsecutive) > 0:
    log("Some people did not have a CONSECUTIVE follow up recorded in data. See the following:")

    nonconsecutive_detail = data_combined.merge(
        nonconsecutive[["id", "Q1", "Q2"]],
        on=["id", "Q1", "Q2"],
        how="inner",
    )[["id", "Q1", "Q2", "pull"]]
    log(nonconsecutive_detail.to_string())
else:
    log("Follow up visits recorded consecutively for all expected individuals.")

# Make sure information is consistent between the two pulls for consecutive pulls.
vars_to_check = (
    ["Q5"]
    + [c for c in data_combined.columns if c.startswith("Q3")]
    + [c for c in data_combined.columns if "region" in c]
    + ["treat", "Q4"]
)

for var in vars_to_check:
    if var not in data_combined.columns:
        continue

    multi_pull = data_combined.groupby(["id", "Q1", "Q2"]).filter(lambda g: len(g) > 1)
    inconsistency_check = (
        multi_pull.groupby(["id", "Q1", "Q2"])[var]
        .nunique(dropna=False)
        .loc[lambda s: s > 1]
        .reset_index()[["id", "Q1", "Q2"]]
    )

    if len(inconsistency_check) > 0:
        log(f"The variable {var} is not consistent across pulls for the following people:")

        inconsistent_detail = data_combined.merge(
            inconsistency_check,
            on=["id", "Q1", "Q2"],
            how="inner",
        )[["id", "Q1", "Q2", var]]
        log(inconsistent_detail.to_string())
    else:
        log(f"The variable {var} is consistent across pulls.")

log("It seems like there are a few quality issues with our data.")
log("Some seem to be due to typos and others look like the provider changed how they coded key variables.")
log()

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
log_file.close()

print("Data validation complete. Check output/data_validation_log.txt for detailed results.")
