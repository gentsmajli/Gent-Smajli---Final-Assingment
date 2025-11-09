* Load raw data and fix basic data-quality issues
* 
set more off

cd "C:\Users\Smajli_Gent\Desktop\Assignment - Gent Smajli"

* Here i load data directly from the main folder
use "C:\Users\Smajli_Gent\Desktop\Assignment - Gent Smajli\used-cars_2cities_prep.dta", clear
browse

* Here I inspect structure
describe
compress

* Here I rename some variables
capture confirm variable price
if _rc==0 label var price "Advertised price (currency units)"

capture confirm variable year
if _rc==0 label var year "Model year"


* Here I created a unique observation id
gen long obs_id = _n
label var obs_id "Row identifier (post-load)"

* Here I ask stata to loop through every variable in the dataset, count how many missing observations it has, and print only those that have any
quietly foreach v of varlist _all {
    count if missing(`v')
    if r(N) > 0 {
        di as txt "Missing values in `v': " as res r(N)
    }
}

* ---- Save cleaned data
save "C:\Users\Smajli_Gent\Desktop\Assignment - Gent Smajli/used_cars_clean.dta", replace

