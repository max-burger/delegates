*--------------------------------------------------
* Analysis 
*-------------------------------------------------



*********************************************************
**********               STRUCTURE             **********
*********************************************************
/*

I) Fig. 1. Technological optimism, temperature rise deemed acceptable, and carbon prices

II) In text-statistics not mentioned in the supplementary online material
    - "Delegates vastly agree to limit global warming: The majority perceives a rise above 1.5°C unacceptable (78%), with only few (8%) deeming an increase of 2.5°C or more acceptable."
    - "The median global carbon price recommended in our sample is 50 USD [...]"
    - "Roughly half of all delegates interviewed stated rather unambitious carbon prices below 60 USD (55%). Only 37% (19% and 13%, respectively) deemed a price of at least 82 USD (185 USD, 281 USD) as appropriate"
    - "This variance in global price suggested is highest for the three low temperature options (0°C, 0.5°C and 1°C), with price suggestions ranging from 0 to 2,000 USD (Levene’s test F(1, 275)=21.7, p<0.001)."
    - "Of the 100 delegates [suggesting prices between 0°C und 1°C] in favor of these ambitious temperature targets, 62% indicated global carbon prices below 60 USD as appropriate to stay below the temperature target."
    - "In addition, we find that participants who claim to be influential in their delegation score higher on the technological optimism mindset (r=.23, p<.001)."
*/




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
catplot tech_ms_1 , text($pos_text1 "Future generations will be richer and better equipped to deal" "with adverse impacts of climate change." $pos_text2 "{it:.46}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt1", replace
catplot tech_ms_2 , text($pos_text1  "Technological innovation e.g., solar geoengineering offers" "a suitable solution to respond in case of a future climate emergency." $pos_text2 "{it:.51}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt2", replace
catplot tech_ms_3 , text($pos_text1  "The present costs and future benefits to society must be weighed" "against each other, while deciding about emission reduction policies." $pos_text2 "{it:.44}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(1) pos(6) ring(1) size(vsmall)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt3", replace

catplot tech_ms_5 , text($pos_text1 "Transformation towards a sustainable society is possible by making" "productions more resourcesaving and without harming the economy." $pos_text2 "{it:.43}" 180 2 "{it:Loading}" "{it:(PCA)}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid)  title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(3) pos(6) ring(1) size(7.5 pt) rowgap(minuscule) symxsize(2.5)) plotregion(margin(zero)) graphregion(margin($margins)) yscale(off) fysize($fysize)
graph save "$working_ANALYSIS\results\intermediate\fut_opt6", replace

catplot tech_ms_4 , text($pos_text1 "Technological innovations for climate change emerge more likely in a" "free-market economy without much interference from the Government." $pos_text2 "{it:.38}", size($textsize) place(w) just(right)) stack percent asyvar yla(`pctlabel', nogrid labsize(relative3)) ytitle("percent", size(relative3)) title("") bargap(0) blabel(bar, size(medium) format(%9.0f) pos(center)) l1title("")  b1title("") legend(rows(3) pos(6) ring(1) size(7.5 pt) symxsize(2.5)) plotregion(margin(zero)) graphregion(margin($margins)) fysize(46)
graph save "$working_ANALYSIS\results\intermediate\fut_opt5", replace

* Combine the single plots
grc1leg "$working_ANALYSIS\results\intermediate\fut_opt6" "$working_ANALYSIS\results\intermediate\fut_opt3" "$working_ANALYSIS\results\intermediate\fut_opt2" "$working_ANALYSIS\results\intermediate\fut_opt1" "$working_ANALYSIS\results\intermediate\fut_opt5" , cols(1) legendfrom("$working_ANALYSIS\results\intermediate\fut_opt6") title("{bf:a }", size(11 pt) pos(11) ring(15)) graphregion(margin(2 3 -3 0)) plotregion(margin(0 0 0 0)) 
gr_edit .legend.plotregion1.DragBy 1 35
gr_edit .plotregion1.graph1.plotregion1.textbox3.style.editstyle horizontal(center) editcopy
gr_edit .plotregion1.graph1.plotregion1.textbox3.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph1.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph2.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph3.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph4.plotregion1.textbox2.style.editstyle size(13) editcopy
gr_edit .plotregion1.graph5.plotregion1.textbox2.style.editstyle size(13) editcopy
graph save "$working_ANALYSIS\results\intermediate\tech_opt_answers", replace
graph export "$working_ANALYSIS\results\intermediate\1a_tech_opt_answers.tif", replace





// Fig 1b
** Global carbon price and temperature rise 
* Global Generate variable defining position of observations on x-axis
egen carbon_price_rank = rank(carbon_price_cap), by(temp_rise_cropped) unique
egen temp_rise_cropped_freq = count(carbon_price_cap), by(temp_rise_cropped)
gen  temp_rise_cropped_jitter2 = temp_rise_cropped + (carbon_price_rank *.006) - (temp_rise_cropped_freq / 2 * 0.006)

* National: Generate variable defining position of observations on x-axis
foreach var in now future {
egen price_rank_h_`var' = rank(price_home_`var'_cap), unique
}

gen h_now_jitter = .
replace h_now_jitter = .5 + (price_rank_h_now *.001)
gen h_future_jitter = .
replace h_future_jitter = 1 + (price_rank_h_future * .001)
gen h_now_stat = .
replace h_now_stat = .6
gen h_future_stat = .
replace h_future_stat = 1.1


* Save number of observations in locals
forvalues i = 1/6 {
sum ln_carbon_price if tr`i' == 1
local n_`i' = r(N)
}
twoway ///
(scatter carbon_price_cap temp_rise_cropped_jitter2 , mcolor(%30) msize(medium) msymbol(o)) ///
(scatter mean_carbon_price temp_rise_cropped , mcolor("119 94 239") mlcolor("94 64 201")  mlwidth(medium) msymbol(triangle))                           ///
(scatter median_carbon_price temp_rise_cropped , mcolor("220 38 127") mlcolor("208 17 111")  mlwidth(medium) msymbol(square))                           ///
, title("{bf:b }", pos(11) span size($head pt))                                             ///
ytitle("Global carbon price to stay below" "stated temperat. target (USD/tCO2)", size($xytitle pt))                               ///
ylabel(, labsize($xylab pt))                                                                ///
xtitle("Temperature rise deemed acceptable (°C)", size($xytitle pt)  margin(0 0 0 4))       ///
xlabel(1 `" "0°C" "(n=`n_1')" "' 2 `" "0.5°C" "(n=`n_2')" "'  3 `" "1°C" "(n=`n_3')" "' 4 `" "1.5°C" "(n=`n_4')" "' 5 `" "2°C" "(n=`n_5')" "' 6 `" "{&ge}2.5°C" "(n=`n_6')" "' , labsize(2.1 pt))                                         ///
xscale(range(0.85 6.2 )) ///
legend(order(1 "Observation" 2 "Mean" 3 "Median") size($legend pt) rows(1) pos(6) ring(1) region(fcolor(%40))) ///
fysize(45) fxsize(40) scale(*1.25) graphregion(margin(0 0 1.3 0) fcolor(none) lcolor(none)) plotregion(margin(0 0 0 0)) 
graph save "$working_ANALYSIS\results\intermediate\price_temprise", replace


* National carbon prices home (now/future)
twoway ///
(scatter price_home_now_cap h_now_jitter , mcolor(purple%30) msize(medium) msymbol(o))  ///
(scatter mean_price_home_now h_now_stat , mcolor("119 94 239") mlcolor("94 64 201")  mlwidth(medium) msymbol(triangle))                    ///
(scatter median_price_home_now h_now_stat , mcolor("220 38 127") mlcolor("208 17 111")  mlwidth(medium) msymbol(square))                        ///
(scatter price_home_future_cap h_future_jitter , mcolor(orange%30) msize(medium) msymbol(o)) ///
(scatter mean_price_home_future h_future_stat , mcolor("119 94 239") mlcolor("94 64 201")  mlwidth(medium) msymbol(triangle))                  ///
(scatter median_price_home_future h_future_stat , mcolor("220 38 127") mlcolor("208 17 111")  mlwidth(medium) msymbol(square))                  ///
, title("{bf: }", pos(11) span size($head pt))                                   ///
ytitle("National carbon price to stay below" "2°C temp. target (USD/tCO2)", size($xytitle pt))            ///
ylabel(, labsize($xylab pt)) yscale(alt) ///
xtitle("Time period", size($xytitle pt)  margin(0 0 0 4)) ///
xlabel(.6 "Now" 1.1 "Future", labsize(8 pt)) xscale(range(0.47 1.3)) ///
legend(off) ///
fysize(45) fxsize(20) scale(*1.25) graphregion(margin(6 0 13.3 3.6) fcolor(none) lcolor(none)) plotregion(margin(0 0 0 0)) nodraw
graph save "$working_ANALYSIS\results\intermediate\global_price", replace







// Fig. 1c. Marginsplot global carbon price and home carbon price deemed necessary 
* Set globals
global info_source info_cc_1 info_cc_2 info_cc_3 info_cc_4 info_cc_5
global socioeconomics edu1 edu3 edu4 edu5 // Education ref. cat.: edu2 (Social Sciences); gender and age erased to not jepardize anonimity of participants
global orga orga2 orga3 orga4 // Governmental organization ref. cat.
global countryspecifics lower_middle_income upper_middle_income high_income // Income level: ref.cat: low; country-level erased to not jepardize anonimity of participants


* Probit, DV: Global carbon price 
quietly: probit price_below temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
eststo p1: margins, dydx(tech_ms_pca) post

* Probit, DV: Carbon price home now
quietly: probit price_below_home_now temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
eststo p2: margins, dydx(tech_ms_pca) post

* Probit, DV: Carbon price home now
quietly: probit price_below_home_future temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics treat_tech, vce(robust)
eststo p3: margins, dydx(tech_ms_pca) post

* Marginsplot
coefplot(p1, offset(-0.3)) (p2, offset(0)) (p3, offset(.3)), legend(order(3 "Average marginal effect" 1 "95% Confidence interval" 2 "90% Confidence interval") size($legend pt) rows(3) rowgap(tiny) pos(6) ring(1) region(fcolor(%40))) title("{bf:c} ", pos(11) span size($head pt))  byopts(compact rows(1)) yline(0, lpattern(dash) lcolor(gs3)) ylabel(-.02(.02).1, labsize($xylab pt)) xlab(.7 "Global" 1 "National now" 1.3 "National future", labsize($xylab pt)) ytitle("Estimated impact: Tech. optimism" "and proposing carbon price < 60USD", size($xytitle pt)) grid(none) levels(95 90) ciopts(lwidth(0.8 2)  lcolor(*1 *.3) recast(rcap)) mlabel(cond(@pval<.01, "***", cond(@pval<.05, "**", cond(@pval<.1, "*", "")))) msize(3pt) msymbol(D) mlabsize(10pt) mlabposition(2) subtitle(, size(9pt) lstyle(none) margin(small) nobox justification(center) alignment(top) bmargin(top)) vertical graphregion(margin(15 2 0 0) fcolor(none) lcolor(none)) plotregion(margin(0 0 0 0)) scale(*1.25) fysize(80) 
graph save "$working_ANALYSIS\results\intermediate\margins_temp_price", replace 




// Combine graph b & c
graph combine "$working_ANALYSIS\results\intermediate\price_temprise" "$working_ANALYSIS/results/intermediate/global_price.gph" "$working_ANALYSIS\results\intermediate\margins_temp_price", rows(1) fysize(50)
gr save "$working_ANALYSIS/results/intermediate/figure1_bc.gph", replace

// Combine graph a with b&c
graph combine "$working_ANALYSIS\results\intermediate\tech_opt_answers" "$working_ANALYSIS/results/intermediate/figure1_bc.gph" , rows(2) ysize(5) graphregion(margin(b=0))

gr_edit plotregion1.graph2.plotregion1.graph1.yaxis1.title.DragBy 0 -1.6     // Graph B: reposition y-axis title 
gr_edit plotregion1.graph2.plotregion1.graph2.xaxis1.title.DragBy 0.75 0      // Graph B: reposition x-axis title
gr_edit plotregion1.graph2.plotregion1.graph1.legend.plotregion1.DragBy 0 9  // Graph B: reposition legend

gr_edit plotregion1.graph2.plotregion1.graph3.legend.plotregion1.key[1].DragBy -1 0   // Graph C: Legend key 1 
gr_edit plotregion1.graph2.plotregion1.graph3.legend.plotregion1.label[1].DragBy -1 0 // Graph C: Legend label 1
gr_edit plotregion1.graph2.plotregion1.graph3.legend.plotregion1.key[3].DragBy 1 0    // Graph C: Legend key 3
gr_edit plotregion1.graph2.plotregion1.graph3.legend.plotregion1.label[3].DragBy 1 0  // Graph C: Legend label 3
gr_edit plotregion1.graph2.plotregion1.graph3.legend.DragBy 1 0 // Graph C: Legend Move

gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.major.num_rule_ticks = 0
gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.edit_tick 1 0.7 `"Global"', tickset(major) editstyle(tickstyle(textstyle(size(8 pt))))
gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.major.num_rule_ticks = 0
gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.edit_tick 2 1 `""National" "now""', tickset(major) editstyle(tickstyle(textstyle(size(2.3))))
gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.major.num_rule_ticks = 0
gr_edit plotregion1.graph2.plotregion1.graph3.xaxis1.edit_tick 3 1.3 `""National" "future""', custom tickset(major) editstyle(tickstyle(textstyle(size(2.3))))
gr_edit plotregion1.graph2.plotregion1.graph3.yoffset = -1.6                 // Graph C: offset y
gr_edit plotregion1.graph2.plotregion1.graph3.plotregion1.plot8.style.editstyle area(linestyle(color("255 220 184"))) editcopy
gr_edit plotregion1.graph2.plotregion1.graph3.plotregion1.plot7.style.editstyle area(linestyle(color("255 128 0"))) editcopy
gr_edit plotregion1.graph2.plotregion1.graph3.plotregion1.plot9.style.editstyle marker(fillcolor("255 128 0")) editcopy

gr save "$working_ANALYSIS/results/intermediate/Figure 1", replace
gr export "$working_ANALYSIS/results/figures/Figure 1.tif", replace width(4000)
gr export "$working_ANALYSIS/results/figures/Figure 1.eps", replace






*---------------------------------------
*   III) In text-statistics not mentioned in the supplementary online material
*------------------------------
// Second, delegates vastly agree to limit global warming: The majority perceives a rise above 1.5°C unacceptable (78%), with only few (8%) deeming an increase of 2.5°C or more acceptable (Figure 1b). 
tab temp_rise

// "Roughly half of all delegates interviewed stated rather unambitious carbon prices below 60 USD (55%). Only 37% (19% and 13%, respectively) deemed a price of at least 82 USD (185 USD, 281 USD) as appropriate"
sum price_below_60 price_below_82 price_below_185 price_below_281

// "The median global carbon price recommended in our sample is 50 USD [...]"
sum carbon_price, d

// "The median national carbon prices in the delegates’ home country are set rather low at 25 USD and 50 USD for the present (today-2030) and future (2080-2100) respectively."
sum price_home_now price_home_future, d

// "Respondents with higher technological optimism showed a significant preference for recommending the book advocating for incremental changes based on efficiency to address ecological problems (“More from Less” by Andrew McAfee), while being less likely to suggest the alternative which calls for transformative solutions and re-thinking our economies"
ttest tech_ms_pca, by(book2) // More from less
ttest tech_ms_pca, by(book3) // Doughnut economics


// An increase in the technological optimist mindset by one is linked to a greater likelihood of suggesting global carbon prices below 60 USD
probit price_below temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics , vce(robust)
margins, dydx(tech_ms_pca) post // 5.7 pp, z= 2.78, p=.005
matrix B = r(b)
gen dydx1 = B[1,1]
sum tech_ms_pca 
di  dydx1 * r(sd) // 8.4pp [Change of 1 SD]

// Results at the national level demonstrate that an increase in technological optimism is strongly associated with a higher probability of recommending current and future carbon prices below 60 USD.
probit price_below_home_now temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics, vce(robust)
margins, dydx(tech_ms_pca) post // 5.8 pp, z= 3.32, p=.001
matrix B = r(b)
gen dydx2 = B[1,1]
sum tech_ms_pca 
di  dydx2 * r(sd) // 8.5 pp [Change of 1 SD]

probit price_below_home_future temp_above tech_ms_pca $info_source $orga cops_attended $socioeconomics $countryspecifics , vce(robust)
margins, dydx(tech_ms_pca) post // 4.3 pp, z= 2.08, p=.044
matrix B = r(b)
gen dydx3 = B[1,1]
sum tech_ms_pca 
di  dydx3 * r(sd) // 6.3 pp [Change of 1 SD]


