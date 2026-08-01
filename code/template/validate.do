* ------------------------------------------------------------------------------------------------ *
*            RST 2025 Data Coding Best Practices Exercise - Data Validation                        *
*                                                                                                  *
* Provided is the starter code to validate our example data. Continue working on the code to       *
* check for the outlined issues. Remember to make error messages descriptive so you know what      *
* issues to address with your data provider.                                                       *
*                                                                                                  *
* ------------------------------------------------------------------------------------------------ *

version 16
set more off
set linesize 255
cap log close
log using output/data_validation_log.smcl, replace


*Check to see that id uniquely identifies observations in all pulls and that IDs are in the same format.
forvalues i = 1(1)$pull_tot { //global pull_tot set in main do-file to indicate the total pull files
  use ${id_data}/pull`i'.dta, clear
  *Format of ID variable?
  display as text "Dataset pull`i' ID format:"
  describe id //tells you the format of the variable
  *Does ID uniquely identify observations in pull?
  capture isid id
  if _rc != 0 {
    display in red "DUPLICATE IDS EXIST IN DATASET pull`i'. THE FOLLOWING HAVE A NON-UNIQUE ID:"
    bysort id: gen duplicate_id = _N
    list id Q1 Q2 Q3* if duplicate_id > 1
    *If the ID does not uniquely identify observations in pull, check to see if a combination of ID and name do.
    capture isid id Q1 Q2
    if _rc != 0 {
      display in red "ID, first and last name DO NOT uniquely identify observations in pull`i'."
    }
    else {
      display as text "ID, first and last name uniquely identify observations in pull`i'."
    }
  }
  else {
    display as text "No duplicate IDs exist in pull`i'."
  }   
}

*Append the pulls together. 
append using ${id_data}/pull1.dta
append using ${id_data}/pull2.dta


sort id Q1 Q2 pull
save ${id_data}/pulls1_${pull_tot}.dta, replace


*Verify we have appropriate follow-up information on the people is consistent. (example code for reference, no adjustment required)

*Make sure everyone appear exactly twice, except for in the most recent pull
bys id Q1 Q2: gen multiple_pulls = _N
cap assert multiple_pulls == 2 if pull != $pull_tot
if _rc != 0 {
  display in red "Some people did not have a follow up recorded in data. See the following:"
  list id Q1 Q2 pull if multiple_pulls == 1 & pull != $pull_tot
}
else {
  display as text "Follow up visits recorded for all expected individuals."
}

*Make sure the visits were in consecutive quarters/pulls.
quietly by id Q1 Q2: gen nonconsecutive_pulls = pull[2] != (pull[1] + 1) if multiple_pulls == 2
cap assert nonconsecutive_pulls == 0 if multiple_pulls == 2
if _rc != 0 {
  display in red "Some people did not have a CONSECUTIVE follow up recorded in data. See the following:"
  list id Q1 Q2 pull if nonconsecutive_pulls == 1
}
else {
  display as text "Follow up visits recorded consecutively for all expected individuals."
}

*Make sure information is consistent between the two pulls for consecutive pulls.
foreach var of varlist Q5 Q3* region* treat Q4 {
  quietly by id Q1 Q2: gen `var'_inconsistency = `var'[1] != `var'[2] if multiple_pulls != 1
  cap assert `var'_inconsistency == 0 | missing(`var'_inconsistency)
  if _rc != 0 {
    display in red "The variable `var' is not consistent across pulls for the following people:"
    list id Q1 Q2 `var' if  `var'_inconsistency == 1
  }
  else {
    display as text "The variable `var' is consistent across pulls."
  }
  drop `var'_inconsistency
}
*It seems like there are a few quality issues with our data. 
  **Some seem to be due to typos and others look like the provider changed how they coded key variables.
  
  
****************************************************************************************************
**************Work in your group to write code/pseudocode for one of the steps below****************
****************************************************************************************************

****************************************************************************************************
*STEP A -- Verify education is coded as documented in data documentation.
****************************************************************************************************


****************************************************************************************************
*STEP B -- Confirm that birth dates are inputted correctly.
****************************************************************************************************


****************************************************************************************************
*STEP C -- Confirm that treatment is assigned correctly. 
****************************************************************************************************

****************************************************************************************************
*STEP D -- Confirm that sex is coded as expected.
****************************************************************************************************

****************************************************************************************************
*STEP E -- Confirm that application dates are inputted correctly.
****************************************************************************************************


****************************************************************************************************
log close
