* In this part I created a summary statistics and a histogram. Then I saved the Graph as png.
clear
set more off

cd "C:\Users\Smajli_Gent\Desktop\Assignment - Gent Smajli"

use "used_cars_clean.dta", clear

summarize, detail
hist price

graph save "graphs\Graph_Histo.gph", replace
graph export "graphs\Graph_Histo.png", as(png) replace