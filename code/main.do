* ------------------------------------------------------------------------------------------------ *
*                  RST 2026 Data Coding Best Practices Exercise                                    *
*                                                                                                  *
* This is the main do file which will call in code to validate and clean your data. Follow the     *
* instructions in the readme to set this up according to the best practices  
* discussed.                                                                                       *
* ------------------------------------------------------------------------------------------------ *

***** Step 1: Pulling in globals with a config file *******
** Read in the configuration file you created as part of the exercise, and then



** run the display commands below to ensure it worked:

di "$num_pulls"
di "$data_dir"
di "$raw_data"
di "$deid_data"
di "$clean_data"

**** Setting the working directory ****
global user = c(username)

if "$user" == "jackcavanagh"{
    cd $jack_dir
}

**** Set your Stata username here!
if "$user" == ""{
    cd $my_dir
}

**** Setting the seed
set seed ? *** Replace ? with the correct seed global!