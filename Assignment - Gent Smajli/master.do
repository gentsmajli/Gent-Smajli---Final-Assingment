* Master script — Used Cars (2 Cities) — Reproducible pipeline
* Purpose: orchestrate the full Stata workflow for the coding assignment
* Author: Gent Smajli
* Date: 11/09/2025

* In this part I run all steps in order.
clear all
set more off

* This is to automatically set the project directory to wherever this file is located
cd "`c(pwd)'"
global ROOT "`c(pwd)'"

* create folders 
cap mkdir "$ROOT/do"
cap mkdir "$ROOT/graphs"

* run the other do files (relative paths, portable)
do "$ROOT/01_load_clean.do"
do "$ROOT/02_filter_transform.do"
do "$ROOT/03_summary_graphs.do"
