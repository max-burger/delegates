*--------------------------------------------------
* Analysis Supplementary Online Material (SOM) 
*-------------------------------------------------


*********************************************************
**********               STRUCTURE             **********
*********************************************************
/*
Appendix:
  S2 Sample details
	o 2.1 Summary statistics (Table S1)
   
  S3 Measurement details
	o 3.1 PCA Generation Mindset (Fig S2) & Distribution answers
	o 3.1 Validation Mindset measures: Books recommendations (Fig S3)
	o 3.2 PCA Generation Negotiation Style (Fig S4)

  S4 Additional analysis and robustness checks
    o 4.1 Determinants of the mindset (Table S2)
	o 4.2 Temperature rise deemed acceptable
		o Main regression outcomes (Table S3)
		o Robustness-test using (quasi-)continious variables (Table S4)
    o 4.3 Carbon price suggested
		o Main regression outcomes (Table S5)
		o Robustness-test using (quasi-)continious variables (Table S6)
	o 4.4 Shift of burden
		o Main regression outcomes (Table S7)
		o Robustness-test using (quasi-)continious variables (Table S8)
	o 4.5 Negotiations
		o Main regression outcomes (Table S9)
		o Robustness-test using (quasi-)continious variables (Table S10)
*/





use "$working_ANALYSIS\data\delegates_analysis.dta", clear




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
// Table S1: Summary statistics
global summary temp_rise carbon_price price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future tech_ms_pca book1 book2 book3 info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5 orga1 orga2 orga3 orga4 edu1 edu2 edu3 edu4 edu5 negotiate_pca negotiate_pca_own negotiate_pca_other cops_attended influence low_income lower_middle_income upper_middle_income high_income 
sum $summary
esttab . using "$working_ANALYSIS/results/tables/table1.rtf", cells("count(fmt(0)) mean(fmt(%9.2fc)) p50(fmt(%9.2fc)) sd(fmt(%9.2fc)) min(fmt(0)) max(fmt(0))")  order(Policy_suggestions temp_rise carbon_price price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future Mindset tech_ms_pca Book_Recommendation book1 book2 book3 Information_sources_used info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5 Organization_working_for orga1 orga2 orga3 orga4 Socioeconomics female age Education edu1 edu2 edu3 edu4 edu5 Others negotiate_pca negotiate_pca_own negotiate_pca_other cops_attended influence Income-level low_income lower_middle_income upper_middle_income high_income) not nostar unstack nomtitle nonumber nonote  replace


// Table S2: Participants per income-level category (countries erased here for reasons of anonymity)
tab income_level



// Fig. S1: Sample population: Origin of population [MAP] 
* Since countries have been erased for reasons of anonymity, this command is not executable

	  
	  
*--------------------------
*        S3 MEASUREMENT DETAILS 
*---------------------------

// S3.1	Construction and validity of the mindset measure

** Fig S2: PCA: Technological Optimism Mindset
preserve
pca tech_ms_1 tech_ms_2 tech_ms_3 tech_ms_4 tech_ms_5 tech_ms_6, blanks(0.2) comp(1)
matrix list e(L)
matrix define loadings = e(L)
xsvmat double loadings, names(col) rownames(var) saving("$working_ANALYSIS/results/intermediate/tech_opt_pca", replace)
use "$working_ANALYSIS/results/intermediate/tech_opt_pca", clear
encode var, gen(var_nr)
save "$working_ANALYSIS/results/intermediate/tech_opt_pca", replace
keep var var_nr
merge 1:1 var using "$working_ANALYSIS/results/intermediate/tech_opt_pca"

twoway (dropline Comp1 var_nr , horizontal mlabel(Comp1) mlabformat(%12.2f) mlabposition(top)) , ylabel(1(1)6, valuelabel) xlabel(0(0.2)0.6) xtitle(loadings) ytitle("") ysize(3) scale(*1.2)
gr_edit yaxis1.edit_tick 1 1 `""Future generations will be richer and better equipped" "to deal with adverse impacts of climate change.""', tickset(major)
gr_edit yaxis1.edit_tick 1 2 `""Technological innovation e.g., solar geoengineering offers" "a suitable solution to respond in case of a future climate emergency.""', tickset(major)
gr_edit yaxis1.edit_tick 1 3 `""The present costs and future benefits to society must be weighed" "against each other, while deciding about emission reduction policies.""', tickset(major)
gr_edit yaxis1.edit_tick 1 4 `""The usage of conventional energy sources is inevitable as global" "energy demand is too high to be covered by renewable energy.""', tickset(major)
gr_edit yaxis1.edit_tick 1 5 `""Technological innovations for climate change emerge more likely" "in a free-market economy without much interference from the Government.""', tickset(major)
gr_edit yaxis1.edit_tick 1 6 `""The transformation towards a sustainable society is possible by making productions" "more resourcesaving and without harming the economy (e.g. constant growth).""', tickset(major)
graph export "$working_ANALYSIS/results/figures/Figure S2.tif", replace  width(4000)
restore



** Fig S3: Validation Mindset measures: Book recommendet
* Who chooses which book?
gen book_2 = .
replace book_2 = 1 if book == 2
replace book_2 = 2 if book == 1
replace book_2 = 3 if book == 3

cibar tech_ms_pca, over(book_2) ///
	barlabel(on) blsize(small) blpos(11) gap(100) ///
	graphopts(ylabel(-.8(.4).8) ///
	legend(order(1 "More from Less (n=82)" 2 "Good Economics for hard times (n=114)" 3 "Doughnut Economics (n=84)") ring(1) rows(3) size(small) pos(6)) ///
	ytitle("Technological optimism")) bargap(10) //
graph export "$working_ANALYSIS/results/figures/fig_s3.tif", replace

ttest tech_ms_pca if book != 1, by(book) // (2) More from less vs. (3) Doughnut Economics 
ttest tech_ms_pca if book != 3, by(book) // (1) Good economics for hard times vs. (2) More from less 
ttest tech_ms_pca if book != 2, by(book) // (1) Good economics for hard times vs. (3) Doughnut Economics




// S3.2: Strateic negotiation mindset
preserve
pca negotiate1 negotiate2 negotiate3 negotiate4 negotiate5, comp(1)
matrix list e(L)
matrix define loadings = e(L)
xsvmat double loadings, names(col) rownames(var) saving("$working_ANALYSIS/results/intermediate/strat_neg_pca", replace)
use "$working_ANALYSIS/results/intermediate/strat_neg_pca", clear
encode var, gen(var_nr)
save "$working_ANALYSIS/results/intermediate/strat_neg_pca", replace
keep var var_nr
merge 1:1 var using "$working_ANALYSIS/results/intermediate/strat_neg_pca"
twoway (dropline Comp1 var_nr , horizontal mlabel(Comp1) mlabformat(%12.2f) mlabposition(top)) , ylabel(1(1)5, valuelabel) xlabel(0(0.2)0.6) xtitle(loadings) ytitle("") ysize(2) scale(*1.8)

gr_edit yaxis1.edit_tick 1 5 "Making the first offer to lead and frame the negotiation to own advantage.", tickset(major)
gr_edit yaxis1.edit_tick 1 4 "Not giving anything without taking something in return.", tickset(major)
gr_edit yaxis1.edit_tick 1 3 "Keeping one’s cards closed an only gradually and tactically open them.", tickset(major)
gr_edit yaxis1.edit_tick 1 2 "Threatening to leave the negotiations to get bargaining power.", tickset(major)
gr_edit yaxis1.edit_tick 1 1 "Making unrealistic requests to get an acceptable result.", tickset(major)
graph export "$working_ANALYSIS/results/figures/Figure S4.tif", replace width(3165)
restore


	  
************************************************************
*        S4 Additional Analysis and Robustness Tests       *
************************************************************
* Set globals
global info_source info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5
global socioeconomics edu1 edu3 edu4 edu5 // Education ref. cat.: edu2 (Social Sciences); female & age excluded to protect anonymity
global orga orga2 orga3 orga4 // Governmental organization ref. cat.
global countryspecifics ln_co2_emissionpc cri_score


// S4.1	Temperature rise deemed acceptable [Regression underlying Fig 2b - blue]
** Table S3: Effects of technological optimism mindset on temperature rise deemed acceptable.
* Binary model [Temp-rise >= 2°C]
probit temp_above tech_ms_pca  $info_source $orga cops_attended $socioeconomics i.income, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/table_s3.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Temp. rise >= 2°C") dec(2) replace

* Quasi-continious model 
reg temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust) beta
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/table_s3.doc", ///
addstat("Adjusted R2", `aR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Temp. rise: 0 to 5°C") dec(2) append

* Binary model (winsorized mindset)
probit temp_above tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income, vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/table_s3.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Temp. rise >= 2°C") dec(2) append

* Quasi-continious model (winsorized mindset)
reg temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income, vce(robust)
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/table_s3.doc", ///
addstat("Adjusted R2", `aR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Temp. rise: 0 to 5°C") dec(2) append





// S4.2	Carbon price suggested to reach temperature aim  [Regression underlying  Fig 2b - red]; 
** Table S4: Effects of technological optimism mindset on global carbon price deemed necessary to reach stated temperature target.
* Binary Model [Price deemed appropriate to reach temperature target < 60 USD]
probit price_below temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/table_s4.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Carbon price < 60USD") dec(2) replace

* Continious model [Log price]
reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
outreg2 using"$working_ANALYSIS/results/tables/table_s4.doc", ///
addstat("Adjusted R2", `aR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Carbon price") dec(2) append

* Binary Model [Price deemed appropriate to reach temperature target < 60 USD]
probit price_below temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local pR2 = e(r2_p)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
margins , dydx(*) post
outreg2 using "$working_ANALYSIS/results/tables/table_s4.doc", ///
addstat("Pseudo R2", `pR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Carbon price" "< 60USD" "Probit, Winsor") dec(2) append

* Continious model [Log price]
reg ln_carbon_price temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local aR2 = e(r2_a)
testparm $info_source 
local F1 = r(p)
testparm $orga
local F2 = r(p)
testparm $socioeconomics
local F3 = r(p)
outreg2 using "$working_ANALYSIS/results/tables/table_s4.doc", ///
addstat("Adjusted R2", `aR2', "Information sources", `F1', "Organization working for", `F2', "Socioeconomics", `F3') adec(3) word ctitle("Carbon price" "(ln, USD)" "(OLS, Winsor)") dec(2) append



** Table S5: Effects of technological optimism mindset on global carbon prices using different thresholds in the binary model
* Price < USD37
probit price_below_37 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local r2_p = e(r2_p)
eststo table_5_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Price < USD82
probit price_below_82 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local r2_p = e(r2_p)
eststo table_5_2: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Price < USD185
probit price_below_185 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local r2_p = e(r2_p)
eststo table_5_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
* Price < USD281
probit price_below_281 temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
local r2_p = e(r2_p)
eststo table_5_4: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

esttab table_5_1 table_5_2 table_5_3 table_5_4 using  "$working_ANALYSIS/results/tables/table_s5.rtf", se mtitles("Price below 37USD" "Price below 82USD") b(%4.2f) order(temp_rise tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income)  label stats(N r2_p, labels("N" "Pseudo R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace



** Figure S5: Detailed view on global carbon prices named for the section 0USD to 50USD
preserve 
keep if carbon_price <= 50
forvalues i = 1/6 {
sum ln_carbon_price if tr`i' == 1
local n_`i' = r(N)
}

twoway ///
(scatter carbon_price temp_rise_cropped if carbon_price <= 50 , jitter(.5) msize(medium) msymbol(circle_hollow))   ///
, ytitle("Global carbon price (USD/tCO2)")                                                                         ///
ylabel(0(10)50) ymtick(0(10)55)                                                                                    ///
xtitle("Temperature rise deemed acceptable (°C)", margin(0 0 0 4))                                                 ///
xlabel(1 `" "0°C" "(n=`n_1')" "' 2 `" "0.5°C" "(n=`n_2')" "'  3 `" "1°C" "(n=`n_3')" "' 4 `" "1.5°C" "(n=`n_4')" "' 5 `" "2°C" "(n=`n_5')" "' 6 `" "{&ge}2.5°C" "(n=`n_6')" "' ) scale(*1.1) 
graph export "$working_ANALYSIS/results/figures/fig_s5.tif", replace
restore


* Table S6: Effects of technological optimism mindset on global carbon prices excluding participants naming ambitious temperature targets (≤1.5°C) and low global carbon prices at the same time
foreach x in 1 5 10 20 30 40 50 {
	gen price_below_`x' = 0
	replace price_below_`x' = 1 if carbon_price < `x' & temp_rise <= 2
}

eststo table_6_1:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_1  == 0, vce(robust)
eststo table_6_2:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_5  == 0, vce(robust)
eststo table_6_3:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_10 == 0, vce(robust)
eststo table_6_4:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_20 == 0, vce(robust)
eststo table_6_5:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_30 == 0, vce(robust)
eststo table_6_6:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_40 == 0, vce(robust)
eststo table_6_7:reg ln_carbon_price temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if price_below_50 == 0, vce(robust)

esttab table_6_1 table_6_2 table_6_3 table_6_4 table_6_5 table_6_6 table_6_7 using "$working_ANALYSIS/results/tables/table_s6.rtf", se mtitles("price<1USD" "price<5USD" "price<10USD" "price<20USD" "price<30USD" "price<40USD" "price<50USD" "price<60USD") b(%4.2f) order(temp_rise tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level)  label stats(N r2_a, labels("N" "Adjusted R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace




// S4.3 Shift of burden

** Fig. : Shifting the burden to other countries and the future (Descriptives)
preserve

** Save number of observations per income-level in local
forvalues i = 1/4 {
sum income_level if income_level == `i'
local n_`i' = r(N)
}

** Collpase observations to receive median
collapse (median) price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future , by(income_level)

** Reshaping dataset from wide to long
foreach var in price_home price_oecd price_ldc {
rename `var'_now `var'1
rename `var'_future `var'2
}
reshape long price_home price_oecd price_ldc, i(income_level) j(now_future)
lab define now_future 1 "Now" 2 "Future"
lab val now_future now_future
gen income_level_future = .
replace income_level_future  = income_level if now_future == 1
replace income_level_future  = income_level + .25 if now_future == 2

** Draw figure
global y = -6
twoway ///
	rspike price_home price_oecd income_level if now_future == 1, vertical lwidth(vthick) lcolor(538y%25) xlabel(0(25)150)          || /// Now: Home-OECD
	rspike price_home price_ldc income_level if now_future == 1, vertical lwidth(vthick) lcolor(538bs1%25) xlabel(0(25)150)         || /// Now: Home-LDC
	rspike price_home price_oecd income_level_future if now_future == 2, vertical lwidth(vthick) lcolor(538y%25) xlabel(0(25)150)   || /// Future: Home-OECD
	rspike price_home price_ldc income_level_future  if now_future == 2, vertical lwidth(vthick) lcolor(538bs1%25) xlabel(0(25)150) || /// Future: Home-LDC
    scatter price_ldc  income_level if now_future == 1,  mcolor(538bs1%80)           || /// Now: LDC
	scatter price_home income_level if now_future == 1,  mcolor(538g%80)             || /// Now: Home
	scatter price_oecd income_level if now_future == 1,  mcolor(538y%80)             || /// Now: OECD
    scatter price_ldc  income_level_future if now_future == 2,  mcolor(538bs1%80)      || /// Future: LDC
	scatter price_home income_level_future if now_future == 2,  mcolor(538g%80)        || /// Future: Home
	scatter price_oecd income_level_future if now_future == 2,  mcolor(538y%80)        || /// Future: OECDw-Future: LDC, High
    line price_home income_level_future if income_level == 1,  lcolor(538g%40)  lpattern(dash) || /// Now-Future: Home, Low
	line price_home income_level_future if income_level == 2,  lcolor(538g%40)  lpattern(dash) || /// Now-Future: Home, Low-Mid
	line price_home income_level_future if income_level == 3,  lcolor(538g%40)  lpattern(dash) || /// Now-Future: Home, Upper-Mid
	line price_home income_level_future if income_level == 4,  lcolor(538g%40)  lpattern(dash)    /// Now-Future: Home, High
	ytitle("Area-specific carbon price" "(median, in USD/tCO2)", size($xytitle pt))                            ///
    ylabel(0 25 50 75 100 125 150, labsize($xylab pt) noticks nogrid) ymtick(25 50 75 100 125 150, grid)     ///
	yline(0, lcolor(gs12%40) lpattern(solid))                                                                ///
	xtitle(Income level (country), size($xytitle pt) margin(0 0 0 4))                                        ///
	xlabel(1.125 `" "Low" "(n=`n_1')" "'  2.125 `" "Low-Mid" "(n=`n_2')" "' 3.125 `" "Up-Mid" "(n=`n_3')" "' 4.125 `" "High" "(n=`n_4')" "', labsize(2.5 pt)) ///
	ttext($y 1 "Now " $y 1.25 "Future" $y 2  "Now" $y 2.25 "Future" $y 3 "Now"  $y 3.25 "Future" $y 4 "Now" $y 4.25 "Future", orientation(vertical) placement(north) color(gs10) size(7pt)) /// Y X "Text"	
		legend(order(5 "Price LDC" 2 "Diff LDC-Home" 6 "Price Home" 11 "Diff Home Now-Future" 7 "Price OECD" 3 "Diff Home-OECD") cols(2) pos(6) ring(1) size($legend pt) region(fcolor(%40))) graphregion(fcolor(none))  scale(1.2)
graph save "$working_ANALYSIS\results\intermediate\shift_burden_by_incomelevel", replace
graph export "$working_ANALYSIS\results\figures\Figure S6.tif", replace width(3165)
restore


** Table S7: Marginal effect of technological optimism mindset on current and future carbon prices deemed appropriate
mprobit ambition_home_fut temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3  , vce(robust)
local r2_p = e(r2_p)
eststo table_7_1: margins, dydx(*) predict(pr outcome(1)) post
estadd scalar r2_p = `r2_p'
mprobit ambition_home_fut temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3 , vce(robust)
eststo table_7_2: margins, dydx(*) predict(pr outcome(2)) post
mprobit ambition_home_fut temp_rise tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3 , vce(robust)
eststo table_7_3: margins, dydx(*) predict(pr outcome(4)) post

* Winsorized
mprobit ambition_home_fut temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3  , vce(robust)
local r2_p = e(r2_p)
eststo table_7_4: margins, dydx(*) predict(pr outcome(1)) post
estadd scalar r2_p = `r2_p'
mprobit  ambition_home_fut temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3 , vce(robust)
eststo table_7_5: margins, dydx(*) predict(pr outcome(2)) post
mprobit  ambition_home_fut temp_rise tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income if ambition_home_fut != 3 , vce(robust)
eststo table_7_6: margins, dydx(*) predict(pr outcome(4)) post

esttab table_7_1 table_7_2 table_7_3 table_7_4 table_7_5 table_7_6 using "$working_ANALYSIS/results/tables/table_s7.rtf", se mtitles("Now<60 & Fut<60" "Now<60 & Fut>60" "Now>60 & Fut>60" "Now<60 & Fut<60 (Winsor)" "Now<60 & Fut>60 (Winsor)" "Now>60 & Fut>60 (Winsor)") b(%4.2f) label stats(N, labels("N") fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) order(temp_rise tech_ms_pca  Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income) nonotes addnotes("Notes: The dependent variable is the proposed carbon prices in the home country now and in the future taking either the value 1 (carbon price today and in future <= 60 USD), 2 (today <= 60 USD but in future > 60 USD), 3 (today and in future > 60 USD). Estimates are average marginal effects from multinomial probit regressions with robust standard errors in brackets. * p<0.1, ** p<0.05, *** p<0.01") replace



**Figure S6: Shifting prices between countries and generations (Do individual delegates agree with "ranking" of burden)
* LDC<=Home 
gen ldc_se_home_now = 0
replace ldc_se_home_now = 1 if price_ldc_now <= price_home_now
tab ldc_se_home income_level, col // (16% state that price in LDCs should be higher than home)

gen shift_to_ldc_cut = shift_to_ldc
replace shift_to_ldc_cut =  500 if shift_to_ldc >= 500
replace shift_to_ldc_cut = -500 if shift_to_ldc <= -500

gen shift_to_oecd_cut = shift_to_oecd
replace shift_to_oecd_cut =  500 if shift_to_oecd >= 500
replace shift_to_oecd_cut = -500 if shift_to_oecd <= -500

gen shift_to_fut_cut = shift_future_home
replace shift_to_fut_cut =  500 if shift_future_home >= 500
replace shift_to_fut_cut = -500 if shift_future_home <= -500

cdfplot shift_to_ldc_cut, ///
title("{bf:a }", pos(11) span size($head2 pt)) xtitle("Shift from Home Country to" "Least Developed Countries (USD)") ytitle(Cum. freq.) ///
yline(0.4332 0.8375, lcolor(gs10)) ///
text(0.2 -250 "LDCs < Home (43%)" 0.6 -210 "LDCs = Home (40%)" 0.92 300 "LDCs > Home (17%)", place(c) just(center) size(8pt) color(gs6))
graph save "$working_ANALYSIS/results/intermediate/home_ldc_cdp", replace

cdfplot shift_to_oecd_cut, ///
title("{bf:b }", pos(11) span size($head2 pt)) xtitle("Shift from Home Country to" "OECD countries (USD)") ytitle(Cum. freq.) ///
yline(0.1805 0.4910, lcolor(gs10)) ///
text(0.1 -250 "OECD < Home (18%)" 0.35 -210 "OECD = Home (29%)" 0.7 300 "OECD > Home (53%)", place(c) just(center) size(8pt) color(gs6))
graph save "$working_ANALYSIS/results/intermediate/home_oecd_cdp", replace

cdfplot shift_to_fut_cut, ///
title("{bf:c }", pos(11) span size($head2 pt)) xtitle("Shift from Now to" "Future (Home country, USD)") ytitle(Cum. freq.) ///
yline(0.2094 0.0903, lcolor(gs10)) ///
text(-0.05 -250 "Future < Now (9%)" 0.15 -210 "Now = Future (12%)" 0.5 300 "Future > Now (79%)", place(c) just(center) size(8pt) color(gs6))
graph save "$working_ANALYSIS/results/intermediate/now_fut", replace

graph combine "$working_ANALYSIS/results/intermediate/home_ldc_cdp" "$working_ANALYSIS/results/intermediate/home_oecd_cdp" "$working_ANALYSIS/results/intermediate/now_fut", scale(*1.1)  imargin(tiny)
graph export "$working_ANALYSIS/results/figures/Figure S6.tif", replace width(3165)






// S4.4 Negotiation Style [Regression underlying Fig. 2d]
gen t_other_delegation = (t_own_delegation - 1) * (-1)
lab define other 0 "Own" 1 "Other"
lab val t_other_delegation other 

** Figure S7. Evaluation of other and own delegations negotiatoin behavior and effect of mindset on evaluation
* Fig S7a: Distribution
twoway kdensity negotiate_pca if t_own_delegation == 0 || kdensity negotiate_pca if t_own_delegation == 1 ,   ///
title("{bf:a }", pos(11) span size($head pt))         ///
ytitle("Density", size($xytitle pt))                                                                           /// 
ylab(0(0.1)0.4, labsize($xylab pt))                                                                           ///
xlab(, labsize($xylab pt))                                                                                    ///
legend(order(1 "Other delegations" 2 "Own delegation") size($legend pt) pos(11) ring(0) region(fcolor(%40)))  ///
xtitle("Strength of strategic negotiation", size($xytitle pt))
graph save "$working_ANALYSIS/results/intermediate/fig_7a", replace

* Fig. S7b: Mindset and Negotiations
eststo tableS8_1:reg negotiate_pca t_other##c.tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust)
sum tech_ms_pca
local tech_ms_min = r(min)
local tech_ms_max = r(max)
margins, at(tech_ms_pca = (`tech_ms_min' (1) `tech_ms_max' )) 
marginsplot, recast(line) ciopt(color(%20)) recastci(rarea) /// 
xtitle("Mindset", size($xytitle pt)) title("{bf:b }", pos(11) span size($head pt))  xla(-4(2)2, labsize($xylab pt)) yla(, labsize($xylab pt)) ytitle(" " "Effects on negotiation", size($xytitle pt))
gr save "$working_ANALYSIS/results/intermediate/fig_7b", replace
eststo tableS8_2 :reg negotiate_pca t_other##c.tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income, vce(robust)

graph combine "$working_ANALYSIS/results/intermediate/fig_7a" "$working_ANALYSIS/results/intermediate/fig_7b", ysize(2) iscale(1.1)
graph export "$working_ANALYSIS/results/figures/Figure S7.tif", replace width(3165)

* Table S8: Technological mindset and strategic negotiations 
esttab tableS8_1 tableS8_2 using "$working_ANALYSIS/results/tables/tableS8.rtf", order(t_other c.tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income) label se(%4.2f) nomtitles b(%4.3f) stats(N r2_a, labels("N" "Adjusted R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) replace 












// S4.5: Use books as explanatory variables / measures for mindset
*Table S9: Using the book recommendation as alternative explanatory variables 

** DV: Temperature above 2°C
probit temp_above book1 book3 $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp above (p>.1)
margins, dydx(*)
local r2_p = e(r2_p)
eststo table_9_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

** DV: Quasi continious temp-rise
eststo table_9_2: reg temp_rise book1 book3 $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp rise (p>.1)

** DV: Global carbon price suggested below USD60
probit price_below temp_rise book1 book3 $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp above (p>.1)
margins, dydx(*)
local r2_p = e(r2_p)
eststo table_9_3: margins, dydx(*) post
estadd scalar r2_p = `r2_p'

** DV: Log global carbon price
eststo table_9_4: reg ln_carbon_price temp_rise book1 book3 $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp rise (p>.1)

esttab table_9_1 table_9_2 table_9_3 table_9_4 using "$working_ANALYSIS/results/tables/tableS9.rtf", se mtitles("Temp >= 2°C" "Temp quasi cont." "Price < 60" "Log Price") b(%4.2f) order(temp_rise book1 book3 Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income)  label stats(N r2_p r2, labels("N" "Pseudo R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace









// S4.6: Environmental agreement
global head3     10 pt   // Title
global xytitle3  8 pt   // Axis title
global xylab3    8 pt   // Scale label
global margins   115 3 1 3

** Figure S8: Environemtal caution

* Figure S8a: agreement to single items on environmental caution
mylabels 0(25)100, myscale(@) local(pctlabel) suffix("%")
preserve
set obs `=_N+1' // generate vartiable to take values 1 for env_ms_2 & _3 as otherwise these bars are not represented in catplot
replace env_ms_2 = 1 in 278
replace env_ms_3 = 1 in 278

catplot env_ms_1 , text(-4 40 "Environmental events that historically happened once per" "century will occur at least once per year by 2050.", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins) fcolor(none) ifcolor(none))  yscale(off) fysize($fysize)
graph save  "$working_ANALYSIS/results/intermediate/fig_8_1", replace

catplot env_ms_2 , text(-4 40 "Besides greenhouse gas emissions, the earth is approaching many" "planetary boundaries that demand equal attention.", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
gr_edit .plotregion1.bars[1].draw_view.setstyle, style(no)
gr_edit .plotregion1.barlabels[1].draw_view.setstyle, style(no)
graph save "$working_ANALYSIS/results/intermediate/fig_8_2", replace

catplot env_ms_3 , text(-4 40 "200 million migrants will be moving either within" "their countries or across borders by 2050.", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS/results/intermediate/fig_8_3", replace

catplot env_ms_4 , text(-4 40 "Our planet’s resources are limited and" "will only sustain a limited population.", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS/results/intermediate/fig_8_4", replace

catplot env_ms_5 , text(-4 40 "Exponential economic growth cannot be sustained" "in a finite system like our planet.", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid labsize(relative3)) ytitle("percent", size(relative3)) title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(3) pos(6) ring(1) size(7.5 pt) symxsize(2.5)) plotregion(margin(zero)) graphregion(margin($margins)) fysize(9)
graph save "$working_ANALYSIS/results/intermediate/fig_8_5", replace

grc1leg "$working_ANALYSIS/results/intermediate/fig_8_2" "$working_ANALYSIS/results/intermediate/fig_8_3" "$working_ANALYSIS/results/intermediate/fig_8_4" "$working_ANALYSIS/results/intermediate/fig_8_1" "$working_ANALYSIS/results/intermediate/fig_8_5" , cols(1) legendfrom("$working_ANALYSIS/results/intermediate/fig_8_5") title("{bf:a }", size(11 pt)) graphregion(margin(5 5 -3 4))
gr_edit .legend.plotregion1.DragBy 1 31
graph save "$working_ANALYSIS/results/intermediate/fig_8a", replace


* Fig S8b. Raincloud plot for principal component
* Use egen to generate the median, quartiles, interquartile range (IQR), and mean. 
egen med_env = median(env_ms_pca)
egen lqt_env = pctile(env_ms_pca), p(25)
egen uqt_env = pctile(env_ms_pca), p(75)
egen iqr_env = iqr(env_ms_pca)
egen mean__env = mean(env_ms_pca)

* Find the lowest value that is more than lqt - 1.5 iqr (Lower whisker)
egen ls_env = min(env_ms_pca)

* Find the highest value that is less than uqt + 1.5 iqr (Upper whisker)
egen us_env = max(env_ms_pca)

* Set position of "raindrops" on x-axis by attributing ranodm values for x-axis
gen pos_rain_env = runiform(0.02,0.16)
replace pos_rain_env = pos_rain * (-1)

* Set position of Boxplot (In middle of "raindrops": between pos_rain)
gen pos_box_env = -.09

global gray gs6
global width medthick
twoway ///
kdensity env_ms_pca, recast(area) color(purple*1.5%50)   ||         /// Distribution (Cloud)
rbar lqt_env med_env pos_box_env, barw(.14) fcolor(white%0) lcolor($gray) lwidth($width) horizontal  || ///
rbar med_env uqt_env pos_box_env, barw(.14) fcolor(white%0) lcolor($gray) lwidth($width) horizontal  ||  ///
rspike lqt_env ls_env pos_box_env, lcolor($gray) lwidth($width) horizontal ||   ///
rspike uqt_env us_env pos_box_env, lcolor($gray) lwidth($width) horizontal ||   ///
scatter pos_rain_env env_ms_pca, color(purple*1.5%25) msize(small)    /// Single observation (Rain)
, legend(off) yscale(off) ylabel(none) xlabel(-6(2)2, labsize($xylab3)) xtitle("Environmental caution (PCA)", size($xytitle3)) yla(, labsize($xylab3))  title("{bf:b }" , size($head3)) graphregion(margin(17 17 0 0)) plotregion(margin(0 0 0 5)) fysize(40)
graph save "$working_ANALYSIS/results/intermediate/fig_8b", replace

* Combine A&B
graph combine "$working_ANALYSIS/results/intermediate/fig_8a" "$working_ANALYSIS/results/intermediate/fig_8b" , rows(2)  ysize(5)
graph export "$working_ANALYSIS/results/figures/fig_8.tif"






// S4.7: Determinants of mindset
** Table S10 Determinants of the technological optimism mindset
eststo tableS10_1:reg tech_ms_pca $info_source, vce(robust)
eststo tableS10_2:reg tech_ms_pca $orga , vce(robust)
eststo tableS10_3:reg tech_ms_pca cops_attended $socioeconomics, vce(robust)
eststo tableS10_4:reg tech_ms_pca i.income, vce(robust)
eststo tableS10_5:reg tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust)
eststo tableS10_6:reg tech_ms_pca_win $info_source $orga cops_attended $socioeconomics i.income, vce(robust)

esttab tableS10_1 tableS10_2 tableS10_3 tableS10_4 tableS10_5 tableS10_6 using "$working_ANALYSIS/results/tables/tableS10.rtf", order(Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income) label se(%4.2f) nomtitles b(%4.3f) stats(N r2_a, labels("N" "Adjusted R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) replace 








// S4.8: Increasing saliency of mindset
** Table S11: Effect of increased salience on temperature rise deemed acceptable and global carbon prise suggested as necessary
probit temp_above treat_tech##c.tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp above (p>.1)
margins, dydx(*)
local r2_p = e(r2_p)
eststo tableS11_1: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
eststo tableS11_2: reg temp_rise treat_tech tech_ms_pca tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust) 
eststo tableS11_3: reg temp_rise treat_tech##c.tech_ms_pca tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income, vce(robust)

probit price_below treat_tech##c.tech_ms_pca temp_rise $info_source $orga cops_attended $socioeconomics i.income, vce(robust) // Temp above (p>.1)
margins, dydx(*)
local r2_p = e(r2_p)
eststo tableS11_4: margins, dydx(*) post
estadd scalar r2_p = `r2_p'
eststo tableS11_5: reg ln_carbon_price treat_tech tech_ms_pca temp_rise  $info_source $orga cops_attended $socioeconomics i.income, vce(robust) 
eststo tableS11_6: reg ln_carbon_price treat_tech##c.tech_ms_pca temp_rise  $info_source $orga cops_attended $socioeconomics i.income, vce(robust) 

esttab tableS11_1 tableS11_2 tableS11_3 tableS11_4 tableS11_5 tableS11_6  using  "$working_ANALYSIS/results/tables/tableS11.rtf", se mtitles("Temp >= 2°C" "Temp quasi cont." "Price < 60" "Log Price") b(%4.2f) order(temp_rise treat_tech tech_ms_pca Info_source $info_source Orga_working $orga SocioEcon cops_attended $socioeconomics Income-level income)  label stats(N r2_p r2, labels("N" "Pseudo R-squared" ) fmt(%4.0f %4.2f)) star(* 0.10 ** 0.05 *** 0.01) varlabels(,elist(weight:_cons "{break}{hline @width}")) nonotes replace































