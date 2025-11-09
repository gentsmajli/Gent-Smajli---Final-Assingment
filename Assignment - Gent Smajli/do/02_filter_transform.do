*Define analysis sample; select vars; transformations

clear
set more off

cd "C:\Users\Smajli_Gent\Desktop\Assignment - Gent Smajli"

* start from cleaned data in the main folder
use "used_cars_clean.dta", clear


* Here i will keep only cars with essential fields (filter observations)

local musthavars ""
foreach cand in price year mileage city make model transmission fuel {
    capture confirm variable `cand'
    if _rc==0 local musthavars `musthavars' `cand'
}
di as txt "Found essential variables: `musthavars'"
foreach v of local musthavars {
    drop if missing(`v')
}

* I made thi to drop extreme outliers using percentiles if price exists
capture confirm variable price
if _rc==0 {
    quietly summarize price, detail
    scalar p1  = r(p1)
    scalar p99 = r(p99)
    drop if price < p1 | price > p99
}

* Variable selection (to keep a tidy set if present)
local keepvars obs_id price year mileage city make model transmission fuel
* This is to keep only variables that exist
unab allvars: _all
local keep_existing
foreach v of local keepvars {
    capture unab tmp: `v'
    if _rc==0 local keep_existing `keep_existing' `v'
}
keep `keep_existing'

* Here are some transformations (created only if ingredients exist)
capture confirm variable year
if _rc==0 {
    gen age = 2025 - year
    label var age "Age in years (assuming current year=2025)"
    replace age = . if age<0
}

capture confirm variable price
if _rc==0 {
    gen ln_price = ln(price)
    label var ln_price "Log price"
}

capture confirm variable mileage
if _rc==0 & "`: list posof age in varlist'" != "0" {
    gen km_per_year = mileage/age
    replace km_per_year = . if age<=0
    label var km_per_year "Mileage per year (km/year)"
}


