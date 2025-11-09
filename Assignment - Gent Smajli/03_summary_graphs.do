* In this part I created a summary statistics and a histogram. Then I saved the Graph as png.
clear
set more off

* Automatically set the working directory to the folder where this file is run
cd "`c(pwd)'"
global ROOT "`c(pwd)'"

* Load the cleaned dataset from the main folder
use "$ROOT/used_cars_clean.dta", clear

* Produce summary statistics and histogram
summarize, detail
hist price

* Save the graph outputs in the graphs folder (portable paths)
graph save "$ROOT/graphs/Graph_Histo.gph", replace
graph export "$ROOT/graphs/Graph_Histo.png", as(png) replace
