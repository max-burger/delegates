*--------------------------------------------------
* Analysis 
*-------------------------------------------------



*********************************************************
**********               STRUCTURE             **********
*********************************************************
/*
Main Body:
I)  Fig. 1: Descriptives
	a) Carbon price and temperature rise
	b) Shifting the burden

II) Fig. 2: Inferential
	a) Answers towards technological optimism items
	b) Technological optimism mindset and temperature & prices suggested

III) In text-statistics not mentioned in the supplementary online material
    - "Delegates vastly agree to limit global warming: The majority perceives a rise above 1.5°C unacceptable (78%), with only few (8%) deeming an increase of 2.5°C or more acceptable."
    - "The median global carbon price recommended in our sample is 50 USD [...]"
    - "Roughly half of all delegates interviewed stated rather unambitious carbon prices below 60 USD (55%). Only 37% (19% and 13%, respectively) deemed a price of at least 82 USD (185 USD, 281 USD) as appropriate"
    - "This variance in global price suggested is highest for the three low temperature options (0°C, 0.5°C and 1°C), with price suggestions ranging from 0 to 2,000 USD (Levene’s test F(1, 275)=21.7, p<0.001)."
    - "Of the 100 delegates [suggesting prices between 0°C und 1°C] in favor of these ambitious temperature targets, 62% indicated global carbon prices below 60 USD as appropriate to stay below the temperature target."
    - "In addition, we find that participants who claim to be influential in their delegation score higher on the technological optimism mindset (r=.23, p<.001)."
*/


use "$working_ANALYSIS\data\delegates_analysis.dta", clear


*---------------------------------------
*   I) FIGURE 1 
*------------------------------
// Figure Settings
* Text size
global head     10 // Title
global legend    8 // Legend
global xytitle   8 // Axis title
global xylab     8 // Scale label
global fysize	 22 
global textsize  14 pt



// Fig 1a: Distribution of answers towards technological optimism items
** Catplot for each item
global margins 145 0 1 3 // set margins for all
global pos_text1 -15 50
global pos_text2  50 -4

mylabels 0(25)100, myscale(@) local(pctlabel) suffix("%") // set label for axis
catplot tech_ms_1 , text($pos_text1 "Future generations will be richer and better equipped to deal" "with adverse impacts of climate change." $pos_text2 "{it:.42}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt1", replace
catplot tech_ms_2 , text($pos_text1  "Technological innovation e.g., solar geoengineering offers" "a suitable solution to respond in case of a future climate emergency." $pos_text2 "{it:.47}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt2", replace
catplot tech_ms_3 , text($pos_text1  "The present costs and future benefits to society must be weighed" "against each other, while deciding about emission reduction policies." $pos_text2 "{it:.38}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt3", replace
catplot tech_ms_4 , text($pos_text1 "The usage of conventional energy sources is inevitable as global" "energy demand is too high to be covered by renewable energy." $pos_text2 "{it:.43}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt4", replace
catplot tech_ms_5 , text($pos_text1 "Technological innovations for climate change emerge more likely in a" "free-market economy without much interference from the Government." $pos_text2 "{it:.37}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid labsize(relative3)) ytitle("percent", size(relative3)) title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(3) pos(6) ring(1) size(7.5 pt) symxsize(2.5)) plotregion(margin(zero)) graphregion(margin($margins)) fysize(50)
graph save "$working_ANALYSIS\results\intermediate\fut_opt5", replace
catplot tech_ms_6 , text($pos_text1 "Transformation towards a sustainable society is possible by making" "productions more resourcesaving and without harming the economy." $pos_text2 "{it:.37}" 180 2 "{it:Loading}" "{it:(PCA)}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(3) pos(6) ring(1) size(7.5 pt) rowgap(minuscule) symxsize(2.5)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt6", replace

* Combine the single plots
grc1leg "$working_ANALYSIS\results\intermediate\fut_opt6" "$working_ANALYSIS\results\intermediate\fut_opt3" "$working_ANALYSIS\results\intermediate\fut_opt2" "$working_ANALYSIS\results\intermediate\fut_opt4" "$working_ANALYSIS\results\intermediate\fut_opt1" "$working_ANALYSIS\results\intermediate\fut_opt5" , cols(1) legendfrom("$working_ANALYSIS\results\intermediate\fut_opt6") title("{bf:a }", size(11 pt) pos(11) ring(15)) graphregion(margin(2 3 -3 4)) plotregion(margin(0 0 0 5)) 
gr_edit .legend.plotregion1.DragBy 1 35
gr_edit .plotregion1.graph1.plotregion1.textbox3.style.editstyle horizontal(center) editcopy
gr_edit .plotregion1.graph1.plotregion1.textbox3.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph1.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph2.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph3.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph4.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph5.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph6.plotregion1.textbox2.style.editstyle size(13) editcopy
graph save "$working_ANALYSIS\results\intermediate\tech_opt_answers", replace




// Fig 1b: Stripplot: Price and temperature rise 
* Generate variable defining position of observations on x-axis
egen carbon_price_rank = rank(carbon_price_cap), by(temp_rise_cropped) unique
egen temp_rise_cropped_freq = count(carbon_price_cap), by(temp_rise_cropped)
gen  temp_rise_cropped_jitter2 = temp_rise_cropped + (carbon_price_rank *.006) - (temp_rise_cropped_freq / 2 * 0.006)

* Save number of observations in locals
forvalues i = 1/6 {
sum ln_carbon_price if tr`i' == 1
local n_`i' = r(N)
}
twoway ///
(scatter carbon_price_cap temp_rise_cropped_jitter2 , mcolor(%30) msize(medium) msymbol(o))              ///
(scatter mean_carbon_price temp_rise_cropped , msymbol(triangle))                                  ///
(scatter median_carbon_price temp_rise_cropped , msymbol(square))                                  ///
, title("{bf:b }", pos(11) span size($head pt))                                                          ///
ytitle("Global carbon price (USD/tCO2)", size($xytitle pt))                                              ///
ylabel(, labsize($xylab pt))                                                                             ///
xtitle("Temperature rise deemed acceptable (°C)", size($xytitle pt)  margin(0 0 0 4))                    ///
xlabel(1 `" "0°C" "(n=`n_1')" "' 2 `" "0.5°C" "(n=`n_2')" "'  3 `" "1°C" "(n=`n_3')" "' 4 `" "1.5°C" "(n=`n_4')" "' 5 `" "2°C" "(n=`n_5')" "' 6 `" "{&ge}2.5°C" "(n=`n_6')" "' , labsize(2.5 pt))                                                ///
legend(order(1 "Observation" 2 "Mean" 3 "Median") size($legend pt) rows(1) pos(6) ring(1) region(fcolor(%40))) ///
fysize(40) scale(*1.25) graphregion(margin(0 10 0 0)) plotregion(margin(0 0 0 0))

graph save "$working_ANALYSIS\results\intermediate\price_temprise", replace
graph export "$working_ANALYSIS\results\intermediate\price_temprise.tif", replace





// Fig. 1c. Coefficient plots temperature rise acceptable and price deemed necessary 
* Set globals
global info_source info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5
global socioeconomics edu1 edu3 edu4 edu5 // Education ref. cat.: edu2 (Social Sciences); gender and age erased to not jepardize anonimity of participants
global orga orga2 orga3 orga4 // Governmental organization ref. cat.
global countryspecifics lower_middle_income upper_middle_income high_income // Income level: ref.cat: low

* Save number of observations for display
sum tech_ms_pca
local tech_ms_min = r(min)
local tech_ms_max = r(max)

* Probit, DV: Temperature rise deemed acceptable
probit temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
margins, dydx(tech_ms_pca)
margins, at(tech_ms_pca = (`tech_ms_min' (1) `tech_ms_max' )) saving("$working_ANALYSIS\results\intermediate\probit_margins_temp2.gph", replace)

* Probit, DV: Price deemed appropriate to reach temperature target
probit price_below temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics i.income , vce(robust)
margins, dydx(tech_ms_pca)
margins, at(tech_ms_pca = (`tech_ms_min' (1) `tech_ms_max' )) saving("$working_ANALYSIS\results\intermediate\probit_margins_price2.gph", replace)

* Marginsplot
combomarginsplot "$working_ANALYSIS\results\intermediate\probit_margins_temp2.gph" "$working_ANALYSIS\results\intermediate\probit_margins_price2.gph", labels("Temperature rise {&ge} 2°C acceptable" "Global carbon price < 60 USD suggested")  xtitle("Technological optimism mindset (PCA)", size($xytitle)) title("{bf:c }", size($head) pos(11) ring(15))  xla(-4(2)2, labsize($xylab)) yla(, labsize($xylab))  ytitle("Effects on probability of" "accepting/suggesting", size($xytitle)) recast(line) recastci(rarea)  file2opts(msize(6pt)) fileci1opts(recast(rarea) lw(none) fcolor(%20)) fileci2opts(recast(rarea) lw(none) fcolor(%20)) legend(rows(2) pos(11) ring(0) size($legend) region(fcolor(%20))) graphregion(margin(10 0 15 0)) plotregion(margin(0 0 0 0)) scale(*0.4) fysize(40) 
gr_edit legend.DragBy -.05 0
gr save "$working_ANALYSIS/results/intermediate/margins_temp_price.gph", replace


// Combine graph b & c
graph combine "$working_ANALYSIS\results\intermediate\price_temprise" "$working_ANALYSIS/results/intermediate/margins_temp_price.gph", rows(1) fysize(40)
gr save "$working_ANALYSIS/results/intermediate/figure1_bc.gph", replace

// Combine graph a with b&c
graph combine "$working_ANALYSIS\results\intermediate\tech_opt_answers" "$working_ANALYSIS/results/intermediate/figure1_bc.gph", rows(2) ysize(5)
gr save "$working_ANALYSIS/results/figures/Figure_2", replace
gr export "$working_ANALYSIS/results/figures/Figure_2.tif", replace

















*------------ OLD



// Fig. 1b: Shifting the burden to other countries and the future (Descriptives)
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
	title("{bf:b }", pos(11) span size($head pt))                                                            ///
	ytitle("Area-specific carbon price (median, in USD/tCO2)", size($xytitle pt))                            ///
    ylabel(0 25 50 75 100 125 150, labsize($xylab pt) noticks nogrid) ymtick(25 50 75 100 125 150, grid)     ///
	yline(0, lcolor(gs12%40) lpattern(solid))                                                                ///
	xtitle(Income level (country), size($xytitle pt) margin(0 0 0 4))                                        ///
	xlabel(1.125 `" "Low" "(n=`n_1')" "'  2.125 `" "Low-Mid" "(n=`n_2')" "' 3.125 `" "Up-Mid" "(n=`n_3')" "' 4.125 `" "High" "(n=`n_4')" "', labsize(2.5 pt)) ///
	ttext($y 1 "Now " $y 1.25 "Future" $y 2  "Now" $y 2.25 "Future" $y 3 "Now"  $y 3.25 "Future" $y 4 "Now" $y 4.25 "Future", orientation(vertical) placement(north) color(gs10) size(7pt)) /// Y X "Text"	
		legend(order(5 "Price LDC" 2 "Diff LDC-Home" 6 "Price Home" 11 "Diff Home Now-Future" 7 "Price OECD" 3 "Diff Home-OECD") cols(2) pos(6) ring(1) size($legend pt) region(fcolor(%40))) graphregion(fcolor(none)) 
graph save "$working_ANALYSIS\results\intermediate\shift_burden_by_incomelevel", replace
graph export "$working_ANALYSIS\results\intermediate\shift_burden_by_incomelevel.tif", replace
restore

// Combine Graph a and b
graph combine "$working_ANALYSIS\results\intermediate\price_temprise"  "$working_ANALYSIS\results\intermediate\shift_burden_by_incomelevel", rows(1) scale(1.3) graphregion(margin(zero))
graph save "$working_ANALYSIS\results\figures\Figure 1", replace
graph export "$working_ANALYSIS\results\figures\Figure 1.tif", replace







*---------------------------------------
*   II) FIGURE 2: The effect of technological optimism mindset on temperature rise deemed acceptable, carbon prices, and strategic negotiation
*------------------------------

// Fig 2: Inferential (Marginsplot)
global head3     22 pt   // Title
global legend3   18 pt   // Legend
global xytitle3  20 pt   // Axis title
global xylab3    20 pt   // Scale label
global fysize	 22 
global textsize  14 pt







*---------------------------------------
*   III) In text-statistics not mentioned in the supplementary online material
*------------------------------
// "Delegates vastly agree to limit global warming: The majority perceives a rise above 1.5°C unacceptable (78%), with only few (8%) deeming an increase of 2.5°C or more acceptable."
tab temp_rise

// "The median global carbon price recommended in our sample is 50 USD [...]"
sum carbon_price, d

// "Roughly half of all delegates interviewed stated rather unambitious carbon prices below 60 USD (55%). Only 37% (19% and 13%, respectively) deemed a price of at least 82 USD (185 USD, 281 USD) as appropriate"
sum price_below_60 price_below_82 price_below_185 price_below_281

// "This variance in global price suggested is highest for the three low temperature options (0°C, 0.5°C and 1°C), with price suggestions ranging from 0 to 2,000 USD (Levene’s test F(1, 275)=21.7, p<0.001)."
gen temp_rise1 = 0 
replace temp_rise1 = 1 if temp_rise >=1.5
robvar ln_carbon_price, by(temp_rise1) // Robsut test for equality of variances of logiritzmized carbon price across those suggesting a price of 0°C, 0.5°C or 1°C as acceptable against the rest

// "Of the 100 delegates [suggesting prices between 0°C und 1°C] in favor of these ambitious temperature targets, 62% indicated global carbon prices below 60 USD as appropriate to stay below the temperature target."
sum price_below_60 if temp_rise <= 1

// "In addition, we find that participants who claim to be influential in their delegation score higher on the technological optimism mindset (r=.23, p<.001)."
pwcorr tech_ms_pca influence, sig

















