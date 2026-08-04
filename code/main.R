# ------------------------------------------------------------------------------------------------ #
#                  RST 2026 Data Coding Best Practices Exercise                                    #
#                                                                                                  #
# This is the main R file which will call in code to validate and clean your data. Follow the     #
# instructions in the exercise and in the comments to set this up according to the best practices #
# discussed.                   
##
# ------------------------------------------------------------------------------------------------ #

### Step 1: Pulling in globals with a config file ####
# Read in the configuration file you created as part of the exercise, and then



# run the display commands below to ensure it worked:

cat("Number of pulls: ", NUM_PULLS, "\n")
cat("Data directory: ", DATA_DIR, "\n")
cat("Raw data directory: ", RAW_DATA, "\n")
cat("De-identified data directory: ", DEID_DATA, "\n")
cat("Clean data directory: ", CLEAN_DATA, "\n")

### Step 2: Setting the working directory ####
user <- Sys.info()["user"]

if (user == "jackcavanagh") {
    setwd(JACK_DIR)
} 

### Set your R username here!
if (user == "your_username") {
    setwd(MY_DIR)
}

### Step 3: Setting the random seed ####
set.seed(?) ### Replace with the correct seed global