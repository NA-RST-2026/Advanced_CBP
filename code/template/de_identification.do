* ------------------------------------------------------------------------------------------------ *
*            RST 2026 Data Coding Best Practices Exercise - De-identification                      *
*                                                                                                  *
* The first section is the starter code to de-identify our example data. 						   *
* The second section is a set of de-identification exercises to do after you finish				   *
* data cleaning.																				   *
*                                                                                                  *
* ------------------------------------------------------------------------------------------------ *

version 16
set more off


********** In-lecture example: Masking names **********************************
use ${id_data}/pulls1_${pull_tot}.dta, clear

***** First create the crosswalk: ***************
** Preserve, keep only the vars needed for the crosswalk
preserve
keep id Q1 Q2

** Create the full name variable, drop the first and last names, and drop duplicates
gen full_name = Q1 + " " + Q2
drop Q1 Q2
duplicates drop

** Save the crosswalk into the identified folder as a csv
export delimited ${id_data}/Name_crosswalk.csv,replace

** Restore, mask the identifying variables, and save
restore
foreach id_var in Q1 Q2{
	replace `id_var' = "*** REMOVED FOR RESPONDENT PRIVACY ***"
}
save ${raw_data}/pulls1_${pull_tot}_deid.dta, replace

********** Post-lecture exercise: **********************************************
***** Prepare the clean data that doesn't have direct identifiers for 
* data publication -- we want to de-identify indirect identifiers now
use ${clean_data}/cleaned_data_pulls1_3.dta, clear

*STEP A -- Aggregate birth month to ranges and mask birth date

*STEP B -- Encode gender so that groups can still be made by gender, but 
* 		you can no longer tell which group is which gender. Save a crosswalk. 
*		HINT: encode always codes alphanumerically -- how would you create a
*		random encoding for gender?


*STEP C -- "Bottom-code" and "Top-code" birth year so that very old and very young
*			participants are grouped together

          
*STEP D -- Aggregate the cleaned education level variable to only two buckets

*STEP E -- Calculate the k-anonymity of the dataset along Birth year, gender, and education
*			Hint: dataset with K-n anonymity would have observations that are equivalent to at least n-1 other observations along the concerning variables -- a good use case for "group" and "bysort"!
