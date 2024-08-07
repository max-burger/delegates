*--------------------------------------------------
* Analysis Supplementary Online Material (SOM) 
*-------------------------------------------------


*********************************************************
**********               STRUCTURE             **********
*********************************************************
/*
Appendix:
  
  S2 Sample details
	o Table S1. Summary statistics
    o Table S2. Countries’ classification by income level (countries erased here for reasons of anonymity)
	o Figure S1. Origin of participants and distribution of characteristics in our sample and in the COP 24 population

	
  S3 Measurement details: Construction and validity of the mindset measure 
    o Figure S2. Loadings of technological optimism items in PCA
	o Figure S3. Book recommendation and technological optimism
	o Figure S4. Distribution of technological optimism
	o Table S3. Using the book recommendation as alternative explanatory variables 
  
  
  S4 Additional analysis and robustness checks
  
  S4.1 Determinants of the mindset
    o Table S4.	 Effects of technological optimism mindset on temperature rise deemed acceptable.
  
  S4.2 Carbon prices suggested 
    o Table S5. Effects of technological optimism mindset on global carbon price deemed necessary to reach stated temperature target
    o Table S6. Effects of technological optimism mindset on global carbon prices using different thresholds in the binary model
	o Figure S5. Detailed view on global carbon prices named for the section 0USD to 50USD
    o Table S7. Effects of technological optimism mindset on global carbon prices excluding participants naming ambitious temperature targets (≤1.5°C) and low global carbon prices at the same time
	o Table S8. Effects of technological optimism mindset on national carbon price now (2021 to 2030) deemed necessary to stay below 2°C
    o Table S9. Effects of technological optimism mindset on national carbon price in the future (2080 to 2100) deemed necessary to stay below 2°C
    o Table S10. Effects of technological optimism mindset on national carbon prices now (2021 to 2030) using different thresholds in the binary model
    o Table S11. Effects of technological optimism mindset on global carbon prices now using different thresholds in the binary model 
	o Table S12. Effects of technological optimism mindset on mean carbon price
  
  S4.3 Determinants of the mindset
    o Table S13. Determinants of the technological optimism mindset
  
  S4.4 Exogenous manipulation of mindset
    o Table S15. Balance table
    o Table S16. Effect of increased salience carbon prices suggested as necessary
*/






// Figure Settings
* Text size: A & C
global head     10 // Title
global legend    8 // Legend
global xytitle   8 // Axis title
global xylab     8 // Scale label

* Text size: B (A&C * 2/3)
global ratio_abc = 3/4
display $ratio_abc * $head
display $ratio_abc * $legend  
display $ratio_abc * $xytitle
display $ratio_abc * $xylab  

global head2    7.5  // Title
global legend2  6    // Legend
global xytitle2 6    // Axis title
global xylab2   6    // Scale label



*--------------------------
*        S2 Sample details  
*---------------------------
// Table S1. Summary statistics
global summary temp_rise carbon_price price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future carbon_price_mean tech_ms_pca book1 book2 book3 info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5 orga1 orga2 orga3 orga4 /*female age*/ edu1 edu2 edu3 edu4 edu5 cops_attended low_income lower_middle_income upper_middle_income high_income /*co2_pc science freedom_house_index*/
estpost sum $summary , d
esttab . using "$working_ANALYSIS/results/tables/Table S1.rtf", cells("count(fmt(0)) mean(fmt(%9.2fc)) p50(fmt(%9.2fc)) sd(fmt(%9.2fc)) min(fmt(0)) max(fmt(0))")  order(Policy_suggestions temp_rise carbon_price price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future carbon_price_mean Mindset tech_ms_pca Book_Recommendation book1 book2 book3 Information_sources_used info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5 Organization_working_for orga1 orga2 orga3 orga4 Socioeconomics /*female age*/ Education edu1 edu2 edu3 edu4 edu5 cops_attended Income-level low_income lower_middle_income upper_middle_income high_income /*co2_pc science freedom_house_index*/) not nostar unstack nomtitle nonumber nonote  replace


// Table S2. Countries’ classification by income level (countries erased here for reasons of anonymity)


// Figure S1. Origin of participants and distribution of characteristics in our sample and in the COP 24 population
* To protect anonymity of participants, countries have been erased. Therefore, the following command producing Figure S1 cannot be executed with the dataset uploaded. For reasons of transparency, we still report the code used to produce the map.

/*
* A. Origin of population
/* Only needs to be run once to create _db & _co
* Download dara for map from: https://github.com/riatelab/world
cd "$working_ANALYSIS\data\GitHub"
shp2dta using country.shp, database(world_db) coordinates(world_co) genid(id)
*/

*preserve
use "$working_ANALYSIS\data\GitHub\world_db" , clear
rename name country_home

** Unify country names
replace country_home = "Congo" if country_home == "Republic of Congo"
replace country_home = "Czechia" if country_home == "Czech Republic"
replace country_home = "Côte d’Ivoire" if country_home == "Cte d'Ivoire"
replace country_home = "Gambia" if country_home == "The Gambia"
replace country_home = "Lao People's Democratic Republic" if country_home == "Laos"
replace country_home = "Micronesia" if country_home == "Federated States of Micronesia"
replace country_home = "Republic of Korea" if country_home == "South Korea"
replace country_home = "Viet Nam" if country_home == "Vietnam"


** Merge with dataset
merge 1:m country_home using "$working_ANALYSIS\data\delegates_analysis_complete.dta"

gen observation = .
replace observation = 1 if temp_rise != .
egen obs_country = count(observation), by(country_home)
replace obs_country = . if obs_country == 0

collapse (mean) obs_country, by(country_home id) 

spmap obs_country using world_co if country_home != "Antarctica", id(id) fcolor(Blues2) ///
clmethod(custom) clbreaks(0 1 2 3 6.1 9.1 12) ///
legend(symy(*1.5) symx(*1.5) size(*1.5)) legorder(lohi)  ///
legend(label(2 "1") label(3 "2" ) label(4 "3") label(5 "4 - 6") label(6 "7 - 9") label(7 "10 - 12")) ///
osize(0.1pt ..) ndfcolor(white) ndocolor(gs5) ndsize(0.2pt) legstyle(2) legtitle("Observation") title("{bf:a}", size(11pt) pos(11) span)
graph save "$working_ANALYSIS\results\intermediate\Figure S1a", replace

// Comparision of distributions our sample vs. COP24 population
use "$working_ANALYSIS\data\delegates_analysis_complete.dta", clear
gen sample = 1
append using "$working_ANALYSIS\data\cop24_parties.dta"
replace sample = 2 if sample == .


// Figure S1b: Global North vs. Global South
tab global_south, gen(gs)
graph bar (mean) gs1 gs2, over(sample, relabel(1 "Our Sample" 2 "COP24")) blabel(bar, format(%3.2g)) ytitle("Share") title("{bf:b}", size(10pt) span pos(11))  legend(order(1 "Global North" 2 "Global South") rows(2)) nodraw
graph save "$working_ANALYSIS\results\intermediate\Figure S1b", replace


// Figure S1c: Male vs. Female
tab female, gen(fem)
graph bar (mean) fem1 fem2, over(sample, relabel(1 "Our Sample" 2 "COP24")) blabel(bar, format(%3.2g)) ytitle("Share") title("{bf:c}", size(10pt) span pos(11))  legend(order(1 "Male" 2 "Female") rows(2)) nodraw
graph save "$working_ANALYSIS\results\intermediate\Figure S1c", replace
 
// Figure S1d: Governmental vs. Other
replace non_gov = (orga1 - 1) * (-1) if sample == 1
tab non_gov, gen(non_gov)
graph bar (mean) non_gov1 non_gov2, over(sample, relabel(1 "Our Sample" 2 "COP24")) blabel(bar, format(%3.2g)) ytitle("Share") title("{bf:d}", size(10pt) span pos(11))  legend(order(1 "Governmental" 2 "Other") rows(2)) nodraw
graph save "$working_ANALYSIS\results\intermediate\Figure S1d", replace

* Combine B,C & D
graph combine "$working_ANALYSIS\results\intermediate\Figure S1b" "$working_ANALYSIS\results\intermediate\Figure S1c" "$working_ANALYSIS\results\intermediate\Figure S1d", rows(1) iscale(1.1)
gr save  "$working_ANALYSIS\results\intermediate\Figure S1bcd", replace


* Combine A with B,C&D
graph combine "$working_ANALYSIS\results\intermediate\Figure S1a"  "$working_ANALYSIS\results\intermediate\Figure S1bcd", cols(1)
gr save  "$working_ANALYSIS\results\intermediate\Figure S1", replace
gr export "$working_ANALYSIS\results\figures\Figure S1.tif", replace


// Test for stat. diffs
ttest global_south, by(sample)
ttest female, by(sample)
ttest non_gov, by(sample)
*/













	  
	  
*--------------------------
*        S3 MEASUREMENT DETAILS 
*---------------------------

// Figure S2. Loadings of technological optimism items in PCA
preserve
pca tech_ms_1 tech_ms_2 tech_ms_3 tech_ms_4 tech_ms_5, blanks(0.2) comp(1)
matrix list e(L)
matrix define loadings = e(L)
xsvmat double loadings, names(col) rownames(var) saving("$working_ANALYSIS/results/intermediate/tech_opt_pca", replace)
use "$working_ANALYSIS/results/intermediate/tech_opt_pca", clear
encode var, gen(var_nr)
save "$working_ANALYSIS/results/intermediate/tech_opt_pca", replace
keep var var_nr
merge 1:1 var using "$working_ANALYSIS/results/intermediate/tech_opt_pca"

twoway (dropline Comp1 var_nr , horizontal mlabel(Comp1) mlabformat(%12.2f) mlabposition(top)) , ylabel(1(1)5, valuelabel) xlabel(0(0.2)0.6) xtitle(loadings) ytitle("") ysize(2) scale(*1.4)
gr_edit yaxis1.edit_tick 1 1 `""Future generations will be richer and better equipped" "to deal with adverse impacts of climate change.""', tickset(major)
gr_edit yaxis1.edit_tick 1 2 `""Technological innovation e.g., solar geoengineering offers" "a suitable solution to respond in case of a future climate emergency.""', tickset(major)
gr_edit yaxis1.edit_tick 1 3 `""The present costs and future benefits to society must be weighed" "against each other, while deciding about emission reduction policies.""', tickset(major)
gr_edit yaxis1.edit_tick 1 4 `""Technological innovations for climate change emerge more likely" "in a free-market economy without much interference from the Government.""', tickset(major)
gr_edit yaxis1.edit_tick 1 5 `""The transformation towards a sustainable society is possible by making productions" "more resourcesaving and without harming the economy (e.g. constant growth).""', tickset(major)
graph export "$working_ANALYSIS/results/figures/Figure S2.tif", replace  width(4000)
restore


// Figure S3. Book recommendation and technological optimism
gen book_2 = .
replace book_2 = 1 if book == 2
replace book_2 = 2 if book == 1
replace book_2 = 3 if book == 3

stripplot tech_ms_pca, over(book_2) separate(book_2) mcolor(gs8*.35 gs8*.35 gs8*.35) msymbol(o o o) yla(-5(1)3 , nogrid) xtitle("") ytitle("Technological optimism") vertical center cumul cumprob bar boffset(.4) refline(lw(medium) lc(gs10) lp(solid)) reflinestretch(0.1) xla(, noticks) yla(, ang(h)) title("") xlab(1 "More from less (n=82)" 2 `""Good Economics for" "hard times (n=114)""' 3 "Dougnut Economics (n=84)") legend(order(4 "Observation" 3 "Mean" 2 "95% Confidence Interval" )) yline(0, lpattern(dash) lcolor(gs3*.4)) ysize(3) scale(*1.2)
graph export "$working_ANALYSIS/results/figures/Figure S3.tif", replace width(3650)

ttest tech_ms_pca if book != 1, by(book) // (2) More from less vs. (3) Doughnut Economics 
ttest tech_ms_pca if book != 3, by(book) // (1) Good economics for hard times vs. (2) More from less 
ttest tech_ms_pca if book != 2, by(book) // (1) Good economics for hard times vs. (3) Doughnut Economics


// Figure S4. Distribution of technological optimism
hist tech_ms_pca, start(-5.5) percent scale(*2) ysize(2) xtitle("Technological optimism")
graph export "$working_ANALYSIS/results/figures/Figure S4.tif", replace width(3650)


// Table S3.	Using the book recommendation as alternative explanatory variables 
* Set globals
global info_source info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5
global socioeconomics /*female age*/ edu1 edu3 edu4 edu5 // Education ref. cat.: edu2 (Social Sciences)
global orga orga2 orga3 orga4 // Governmental organization ref. cat.
global countryspecifics lower_middle_income upper_middle_income high_income /*co2_pc ln_science freedom_house_index*/

** DV: Global carbon price suggested below USD60
probit price_below temp_rise book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust) 
margins, dydx(*)
local r2_p = e(r2_p)
eststo table_3_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

** DV: Log global carbon price
eststo table_3_2: reg ln_carbon_price temp_rise book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust) 

** DV: National carbon price now suggested below USD60
probit price_below_home_now book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
margins, dydx(*)
local r2_p = e(r2_p)
eststo table_3_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

** DV: Log global carbon price
eststo table_3_4: reg ln_price_home_now book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)

** DV: National carbon price now suggested below USD60
probit price_below_home_future book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
margins, dydx(*)
local r2_p = e(r2_p)
eststo table_3_5: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

** DV: Log global carbon price
eststo table_3_6: reg ln_price_home_future book1 book3 $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)

esttab table_3_1 table_3_2 table_3_3 table_3_4 table_3_5 table_3_6 using "$working_ANALYSIS/results/tables/Table S3.rtf", p mtitles("Price<60USD" "(ln) Price" "Price<60USD" "(ln) Price" "Price<60USD" "(ln) Price") b(%4.2f) order(temp_rise book1 book3 Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income) label stats(r2_p r2_a df_r N, labels("Pseudo R2" "Adjusted R2" "Degrees of freedom" "Observation") fmt(%4.2f %4.2f %4.0f %4.0f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace









	  
************************************************************
*        S4 Additional Analysis and Robustness Tests       *
************************************************************
* Set globals
global info_source info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5
global socioeconomics /*female age*/ edu1 edu3 edu4 edu5 // Education ref. cat.: edu2 (Social Sciences)
global orga orga2 orga3 orga4 // Governmental organization ref. cat.
global countryspecifics lower_middle_income upper_middle_income high_income /*co2_pc ln_science freedom_house_index*/

// S4.1	Temperature rise deemed acceptable
* Table S4. Effects of technological optimism mindset on temperature rise deemed acceptable.
* Col 1: Binary model [Temp-rise >= 2°C]
probit temp_above tech_ms_pca  $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("Temp. rise > 1.5°C") stats(coef pval) dec(3) bdec(2)  replace

* Col 2: Quasi-continious model 
reg temp_rise tech_ms_pca  $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
addstat("Adjusted R2", `aR2', "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) stats(coef pval) dec(3) bdec(2) word ctitle("Temp. rise: 0 to 5°C") append

* Col 3: Binary model (winsorized mindset)
probit temp_above tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("Temp. rise > 1.5°C") stats(coef pval) dec(3) bdec(2)  append

* Col 4: Quasi-continious model (winsorized mindset)
reg temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
addstat("Adjusted R2", `aR2',  "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) stats(coef pval) dec(3) bdec(2)  word ctitle("Temp. rise: 0 to 5°C") append


* Col 5 & 6: Alternative thresholds (>2°C & >2.5°C)
gen temp_above2 = 0
replace temp_above2 = 1 if temp_rise > 2
gen temp_above3 = 0
replace temp_above3 = 1 if temp_rise > 2.5

global socioeconomics2 /*female age*/ edu1 edu3 edu4 

probit temp_above2 tech_ms_pca $info_source $orga cops_attended $socioeconomics2 $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics2
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("Temp. rise > 2°C") stats(coef pval) dec(3) bdec(2) append

probit temp_above3 tech_ms_pca $info_source $orga cops_attended $socioeconomics2 $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics2
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S4.doc", ///
 addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("Temp. rise > 2.5°C") stats(coef pval) dec(3) bdec(2) append





// S4.2	Carbon prices suggested 

// S4.2.1 Global carbon prices suggested to reach stated temperature target

* Table S5. Effects of technological optimism mindset on global carbon price deemed necessary to reach stated temperature target
* Col 1: Binary Model [Price deemed appropriate to reach temperature target < 60 USD]
probit price_below temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S5.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("Global carbon price < 60USD") stats(coef pval) dec(3) bdec(2) replace

* Col 2: Continious model [LN Price]
reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S5.doc", ///
addstat("Adjusted R2", `aR2',  "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("Global carbon price ln, USD") stats(coef pval) dec(3) bdec(2) append

* Col 3: Binary Model Winsorized [Price deemed appropriate to reach temperature target < 60 USD]
probit price_below temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S5.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("Global carbon price < 60USD") stats(coef pval) dec(3) bdec(2) append

* Col 4: Continious model Winsorized [Log price]
reg ln_carbon_price temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S5.doc", ///
addstat("Adjusted R2", `aR2',  "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("Global carbon price ln, USD") stats(coef pval) dec(3) bdec(2) append



** Table S6. Effects of technological optimism mindset on global carbon prices using different thresholds in the binary model
* Col 1: Price < USD37
probit price_below_37 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_6_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 2: Price < USD82
probit price_below_82 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_6_2: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 3: Price < USD185
probit price_below_185 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_6_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 4: Price < USD281
probit price_below_281 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_6_4: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

esttab table_6_1 table_6_2 table_6_3 table_6_4 using  "$working_ANALYSIS/results/tables/Table S5.rtf", p mtitles("Price below 37USD" "Price below 82USD" "Price below 185USD" "Price below 281USD") b(%4.2f) order(temp_rise tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Country-level)  label stats(N r2_p, labels("N" "Pseudo R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace



** Figure S5: Detailed view on global carbon prices named for the section 0USD to 50USD

* Global carbon price and temperature rise 
* Global Generate variable defining position of observations on x-axis
egen carbon_price_rank2 = rank(carbon_price_cap), by(temp_rise_cropped) unique
egen temp_rise_cropped_freq2 = count(carbon_price_cap), by(temp_rise_cropped)
gen  temp_rise_cropped_jitter3 = temp_rise_cropped + (carbon_price_rank2 *.006) - (temp_rise_cropped_freq2 / 2 * 0.006)

forvalues i = 1/6 {
sum ln_carbon_price if tr`i' == 1
local n_`i' = r(N)
}
twoway ///
(scatter carbon_price_cap temp_rise_cropped_jitter3 , mcolor(%30) msize(medium) msymbol(o)) ///
(scatter mean_carbon_price temp_rise_cropped , mcolor("119 94 239") mlcolor("94 64 201")  mlwidth(medium) msymbol(triangle))                           ///
(scatter median_carbon_price temp_rise_cropped , mcolor("220 38 127") mlcolor("208 17 111")  mlwidth(medium) msymbol(square))                           ///
, title(" ")                                             ///
ytitle("Global carbon price to stay below" "stated temperat. target (USD/tCO2)", size($xytitle pt))                               ///
ylabel(, labsize($xylab pt))                                                                ///
xtitle("Temperature rise deemed acceptable (°C)", size($xytitle pt)  margin(0 0 0 4))       ///
xlabel(1 `" "0°C" "(n=`n_1')" "' 2 `" "0.5°C" "(n=`n_2')" "'  3 `" "1°C" "(n=`n_3')" "' 4 `" "1.5°C" "(n=`n_4')" "' 5 `" "2°C" "(n=`n_5')" "' 6 `" "{&ge}2.5°C" "(n=`n_6')" "' , labsize(2.1 pt))                                         ///
xscale(range(0.85 6.2 )) ///
legend(order(1 "Observation" 2 "Mean" 3 "Median") size($legend pt) rows(1) pos(6) ring(1) region(fcolor(%40))) scale(*1.3) 
graph export "$working_ANALYSIS\results\intermediate\Figure S5a.tif", replace


preserve 
keep if carbon_price <= 50
forvalues i = 1/6 {
sum ln_carbon_price if tr`i' == 1
local n_`i' = r(N)
}

twoway ///
(scatter carbon_price temp_rise_cropped if carbon_price <= 50 , jitter(.5) mcolor(%50) msize(medium) msymbol(o)) ///
, ytitle("Global carbon price to stay below" "stated temperat. target (USD/tCO2)")                                                                         ///
ylabel(0(10)50) ymtick(0(10)55)                                                                                    ///
xtitle("Temperature rise deemed acceptable (°C)", margin(0 0 0 4))                                                 ///
xlabel(1 `" "0°C" "(n=`n_1')" "' 2 `" "0.5°C" "(n=`n_2')" "'  3 `" "1°C" "(n=`n_3')" "' 4 `" "1.5°C" "(n=`n_4')" "' 5 `" "2°C" "(n=`n_5')" "' 6 `" "{&ge}2.5°C" "(n=`n_6')" "' ) scale(*1.3) 
graph export "$working_ANALYSIS/results/intermediate/Figure S5b.tif", replace
restore



** Table S7. Effects of technological optimism mindset on global carbon prices excluding participants naming ambitious temperature targets (≤1.5°C) and low global carbon prices at the same time
foreach x in 1 5 10 20 30 40 50 {
	gen price_below_`x' = 0
	replace price_below_`x' = 1 if carbon_price < `x' & temp_rise <= 2
}

eststo table_6_1:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_1  == 0, vce(robust)
eststo table_6_2:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_5  == 0, vce(robust)
eststo table_6_3:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_10 == 0, vce(robust)
eststo table_6_4:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_20 == 0, vce(robust)
eststo table_6_5:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_30 == 0, vce(robust)
eststo table_6_6:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_40 == 0, vce(robust)
eststo table_6_7:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech if price_below_50 == 0, vce(robust)

esttab table_6_1 table_6_2 table_6_3 table_6_4 table_6_5 table_6_6 table_6_7 using "$working_ANALYSIS/results/tables/Table S6.rtf", p mtitles("price<1USD" "price<5USD" "price<10USD" "price<20USD" "price<30USD" "price<40USD" "price<50USD" "price<60USD") b(%4.2f) order(temp_rise tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level) label stats(N r2_a df_r, labels("N" "Adjusted R-squared" "Degrees of freedom") fmt(%4.0f %4.2f %4.0f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace






// S4.2.2 National carbon price in home country suggested to stay below 2°C temperature target

** Table S8. Effects of technological optimism mindset on national carbon price now (2021 to 2030) deemed necessary to stay below 2°C.
* Col 1: Binary Model [National Price Now deemed appropriate < 60 USD]
probit price_below_home_now tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S8.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price (now) < 60USD") stats(coef pval) dec(3) bdec(2) replace

* Col 2: Continious model [Log price]
reg ln_price_home_now tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S8.doc", ///
addstat("Adjusted R2", `aR2', "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("National carbon price (now) ln USD") stats(coef pval) dec(3) bdec(2) append

* Col 3: Binary Model Winsorized [National Price Now deemed appropriate < 60 USD]
probit price_below_home_now tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S8.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price now < 60USD") stats(coef pval) dec(3) bdec(2) append

* Col 4: Continious model Winsorized [Log price]
reg ln_price_home_now tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S8.doc", ///
addstat("Adjusted R2", `aR2', "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("National carbon price now ln USD") stats(coef pval) dec(3) bdec(2) append




** Table S9. Effects of technological optimism mindset on national carbon price in the  future (2080 to 2100) deemed necessary to stay below 2°C.
* Col 1: Binary Model [National Price Future deemed appropriate < 60 USD]
probit price_below_home_future tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S9.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price (future) < 60USD") stats(coef pval) dec(3) bdec(2) replace

* Col 2: Continious model [Log price]
reg ln_price_home_future tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/Table S9.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price future < 60USD") stats(coef pval) dec(3) bdec(2) append

* Col 3: Binary Model Winsorized [National Price Now deemed appropriate < 60 USD]
probit price_below_home_now tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/Table S9.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price (future) < 60USD") stats(coef pval) dec(3) bdec(2) append

* Col 4: Continious model Winsorized [Log price]
reg ln_price_home_now tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/Table S9.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4')  adec(3) word ctitle("National carbon price future < 60USD") stats(coef pval) dec(3) bdec(2) append




** Table S10. Effects of technological optimism mindset on national carbon prices now (2021 to 2030) using different thresholds in the binary model
* Col 1: Price < USD37
probit price_now_below_37 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_10_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 2: Price < USD82
probit price_now_below_82 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_10_2: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 3: Price < USD185
probit price_now_below_185 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_10_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 4: Price < USD281
probit price_now_below_281 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_10_4: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

esttab table_10_1 table_10_2 table_10_3 table_10_4 using  "$working_ANALYSIS/results/tables/Table S10.rtf", p mtitles("Price below 37USD" "Price below 82USD" "Price below 185USD" "Price below 281USD") b(%4.2f) order(tech_ms_pca Info_source $info_source Orga_working $orga cops_attended SocioEcon $socioeconomics Country-level)  label stats(N r2_p, labels("N" "Pseudo R-squared") fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace


** Table S11. Effects of technological optimism mindset on global carbon prices now using different thresholds in the binary model
* Col 1: Price < USD37
probit price_future_below_37 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_11_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 2: Price < USD82
probit price_future_below_82 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_11_2: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 3: Price < USD185
probit price_future_below_185 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_11_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Col 4: Price < USD281
probit price_future_below_281 tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local r2_p = e(r2_p)
eststo table_11_4: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

esttab table_11_1 table_11_2 table_11_3 table_11_4 using  "$working_ANALYSIS/results/tables/Table S11.rtf", p mtitles("Price below 37USD" "Price below 82USD" "Price below 185USD" "Price below 281USD") b(%4.2f) order(tech_ms_pca $info_source $orga cops_attended $socioeconomics )  label stats(N r2_p, labels("N" "Pseudo R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace








// S4.2.3 Combined carbon price measure 
** Table S12. Effects of technological optimism mindset on mean carbon price
reg ln_carbon_price_mean tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S12.doc", ///
addstat("Adjusted R2", `aR2', "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(3) word ctitle("Carbon price (mean)") stats(coef pval) dec(3) bdec(2) replace

reg ln_carbon_price_mean tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
local aR2 = e(r2_a)
local df = e(df_r)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
testparm $countryspecifics
local F4 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/Table S12.doc", ///
addstat("Adjusted R2", `aR2', "Degrees of freedom", `df', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3', "Country-level", `F4') adec(2) word ctitle("Carbon price (mean)") stats(coef pval) dec(3) bdec(2) append













// S4.3 Determinants of the mindset
* Table S13. Determinants of the technological optimism mindset
eststo tableS13_1:reg tech_ms_pca $info_source treat_tech, vce(robust)
eststo tableS13_2:reg tech_ms_pca $orga cops_attended treat_tech, vce(robust)
eststo tableS13_3:reg tech_ms_pca $socioeconomics treat_tech, vce(robust)
eststo tableS13_4:reg tech_ms_pca $countryspecifics treat_tech, vce(robust)
eststo tableS13_5:reg tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
eststo tableS13_6:reg tech_ms_pca_win $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)

esttab tableS13_1 tableS13_2 tableS13_3 tableS13_4 tableS13_5 tableS13_6 using "$working_ANALYSIS/results/tables/Table S13.rtf", label nomtitles p(%4.3f) b(%4.3f) stats(N r2 r2_a df_r, labels("N" "R-squared" "Adjusted R-squared" "Degrees of freedom") fmt(%4.0f %4.2f %4.2f %4.0f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) replace drop(treat_tech)









// S4.4 Exogenous manipulation of mindset
* Table S15: Balance table
gen treat_tech_rev = (treat_tech -1) * (-1)
iebaltab tech_ms_pca /*female age*/ edu1 edu2 edu3 edu4 edu5 low_income lower_middle_income upper_middle_income high_income, grpvar(treat_tech_rev) stats(desc(se) pair(p) f(f)) savexlsx("$working_ANALYSIS/results/tables/Table S15") replace




* Table S16. Effect of increased salience carbon prices suggested as necessary
* Col 1: Global carbon price <60 USD
probit price_below treat_tech tech_ms_pca temp_rise $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 
margins, dydx(*)
local r2_p = e(r2_p)
eststo tableS16_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

* Col 2: Log global carbon price 
eststo tableS16_2: reg ln_carbon_price treat_tech##c.tech_ms_pca temp_rise  $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 


* Col 3: National carbon price (now) <60 USD
probit price_below_home_now treat_tech c.tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 
margins, dydx(*)
local r2_p = e(r2_p)
eststo tableS16_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

* Col 4: Log national carbon price (now)
eststo tableS16_4: reg ln_price_home_now treat_tech##c.tech_ms_pca   $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 


* Col 5: National carbon price (future) <60 USD
probit price_below_home_future treat_tech tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 
margins, dydx(*)
local r2_p = e(r2_p)
eststo tableS16_5: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

* Col 6: Log national carbon price (future)
eststo tableS16_6: reg ln_price_home_future treat_tech##c.tech_ms_pca   $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust) 

esttab tableS16_1 tableS16_2 tableS16_3 tableS16_4 tableS16_5 tableS16_6 using  "$working_ANALYSIS/results/tables/Table S16.rtf", p mtitles("Global Price < 60" "Log Global Price" "National Price (now) < 60" "Log National (now) Price" "National Price (future) < 60" "Log National (future) Price") b(%4.2f) label stats(N r2_p r2 df_r, labels("N" "Pseudo R-squared" "Adjusted R-squared" "Degrees of freedom") fmt(%4.0f %4.2f %4.2f %4.0f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace











