* ------------------------------------------------------------------------------------------------ *
*             RST 2026 Data Coding Best Practices Exercise - Data Cleaning                         *
*                                                                                                  *
* Provided are example steps needed to clean the code. Follow the instructions to complete the     *
* exercise. Remember to follow best practices discussed in the lecture.                            *
*                                                                                                  *
* ------------------------------------------------------------------------------------------------ *

version 16
set more off

use "${deid_data}/pulls1_${num_pulls}_deid.dta", clear

****************************************************************************************************
*STEP A -- Rename the variables to be more intuitive. (refer to the code book)
****************************************************************************************************

****************************************************************************************************
*STEP B -- Label the variables based on the questions in the code book.
****************************************************************************************************

****************************************************************************************************
*STEP C -- Generate a variable indicating gender to be a dummy variable (either male or female)
****************************************************************************************************

****************************************************************************************************
*STEP D -- For the missing application dates that don't need an answer, recode them as "N/A" (".n"). 
          *For the missing application dates that should be there, recode them as "don't know" (".d")
****************************************************************************************************

****************************************************************************************************                
*STEP E -- Save the data without overriding the original data.
****************************************************************************************************

save "${clean_data}/cleaned_data_pulls1_${num_pulls}.dta", replace
