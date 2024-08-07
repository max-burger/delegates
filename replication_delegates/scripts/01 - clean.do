*-----------------
*   Cleaning & Generating
*-----------------

use "$working_ANALYSIS\data\delegates_raw.dta", clear

*---------
*   Generating variables
*----------

// Sociodemographics
* Binary variables for education categories
tab edu, generate(edu)

* Organization currently working for
gen orga = .
replace orga = 1 if organization == 1 | organization == 2 // International (11) & national (168) gov orga 
replace orga = 2 if organization == 3 //  University/Research Institute
replace orga = 3 if organization == 5 //  Environmental NGO
replace orga = 4 if organization == 4 |  organization == 6 |  organization == 7 //  Private Company (n=8), Non-environmental NGO (n=6), Other (n=26)
tab organization
lab define orga_lab 1 "Governmental Organization" 2 "University/Research Institute" 3 "Environmental NGO" 4 "Other"
lab val orga orga_lab
tab orga, gen(orga)



// Temperature rise deemed acceptable
* Binary variable being 1 if temperature rise above 1.5 degrees is deemed acceptable and 0 otherwise
gen temp_above = .
replace temp_above = 0 if temp_rise <= 1.5
replace temp_above = 1 if temp_rise > 1.5
lab var temp_above "Temperature rise above 1.5°C deemed acceptable"

* Cropped temperature rise deemed acceptable
/*
Very few people suggested temperatures of 2.5°C or higher to be acceptable:
2.5°C -> 9
3.0°C -> 4
3.5°C -> 2
4.0°C -> 2
4.5°C -> 0
5.0°C -> 4
Therefore, for the illustration Figure 1a all temperature suggestions of 2.5°C or more are summarized under >= 2.5°C
*/
gen temp_rise2 = temp_rise
replace temp_rise2 = 2.5 if temp_rise >= 2.5
tostring temp_rise2, gen(temp_rise3)
sort temp_rise
lab define temp 1 "0" 2 ".5" 3 "1" 4 "1.5", replace
encode temp_rise3, gen(temp_rise_cropped) lab(temp)
lab var temp_rise_cropped"All those suggesting 2.5 or more collected in 2.5"
drop temp_rise2 temp_rise3





// Global carbon price suggested
* Logarithmic form of suggested carbon prices
gen ln_carbon_price = ln(carbon_price + 1)
label var ln_carbon_price "Natural logarithm of suggested carbon_price"

* Cropping global carbon price suggested at USD500 for visualization in figure 1b
gen carbon_price_cap = carbon_price
replace carbon_price_cap  = 501 if carbon_price > 500
lab var carbon_price_cap "Carbon price capped at USD500"
egen mean_carbon_price = mean(carbon_price), by(temp_rise_cropped)
lab var mean_carbon_price "Mean carbon price (non-capped)"
egen median_carbon_price = median(carbon_price), by(temp_rise_cropped)
lab var median_carbon_price "Median carbon price (non-capped)"
tab temp_rise_cropped , gen(tr)


* Cropping area-specific carbon prices at USD500 for visualization in figure 1c
foreach var in price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future ln_carbon_price {
gen `var'_cap = `var'
replace `var'_cap  = 501 if `var' > 500
lab var `var'_cap "Carbon price capped at USD500"
egen mean_`var' = mean(`var')
lab var mean_`var' "Mean carbon price (non-capped)"
egen median_`var' = median(`var')
lab var median_`var' "Median carbon price (non-capped)"
}


* Binary variable being 1 if global carbon price below 60 USD suggested
gen price_below = .
replace price_below = 0 if carbon_price >= 60 
replace price_below = 1 if carbon_price < 60 
lab var price_below "Price suggested < USD60"

* Binary variable being 1 if national carbon prices (now & future) below 60 USD suggested
foreach var in now future {
	gen price_below_home_`var' = .
	replace price_below_home_`var' = 0 if price_home_`var' >= 60
	replace price_below_home_`var' = 1 if price_home_`var' < 60
	lab var price_below_home_`var' "Price suggested < USD60"
	}


/*
Carbon price suggestions tested
Different models suggest different minimal global carbon prices to stay below a certain temperature rise. In the main paper we use USD60 as thte threshold. As robustness test, we also test against other specifications: 37 USD 82 USD, 185 USD, 281 USD
*/
foreach i in 37 60 82 185 281 {
	gen price_below_`i' = .
		replace price_below_`i'= 1 if carbon_price < `i'
		replace price_below_`i'= 0 if carbon_price >=  `i'
        lab var price_below_`i' "Price below USD `i' suggested"
}


* National carbon price (now)
foreach i in 37 60 82 185 281 {
	gen price_now_below_`i' = .
		replace price_now_below_`i'= 1 if price_home_now < `i'
		replace price_now_below_`i'= 0 if price_home_now >=  `i'
        lab var price_now_below_`i' "National price now below USD `i' suggested"
}


* National carbon price (future)
foreach i in 37 60 82 185 281 {
	gen price_future_below_`i' = .
		replace price_future_below_`i'= 1 if price_home_future < `i'
		replace price_future_below_`i'= 0 if price_home_future >=  `i'
        lab var price_future_below_`i' "National price future below USD `i' suggested"
}




// Region- and time-specific carbon price suggestions
** Logarithms of prices suggested prices for home, OECD, LDC / now, future
foreach var in price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future {
gen ln_`var' = log(`var' + 1)
}
lab var ln_price_home_now "Ln of Price Home Now"
lab var ln_price_oecd_now "Ln of Price OECD Now"
lab var ln_price_ldc_now "Ln of Price LDCs Now"
lab var ln_price_home_future "Ln of Price Home Future"
lab var ln_price_oecd_future "Ln of Price OECD Future"
lab var ln_price_ldc_future "Ln of Price LDCs Future"



* Average carbon price
alpha carbon_price carbon_price price_home_now price_oecd_now price_ldc_now price_home_future price_oecd_future price_ldc_future, gen(carbon_price_mean)

* Average carbon price (log)
alpha ln_carbon_price ln_carbon_price ln_price_home_now ln_price_oecd_now ln_price_ldc_now ln_price_home_future ln_price_oecd_future ln_price_ldc_future, gen(ln_carbon_price_mean)








// Principal components
** Technological optimism
pca tech_ms_1 tech_ms_2 tech_ms_3 tech_ms_4 tech_ms_5
predict tech_ms_pca
lab var tech_ms_pca "Technological optimism mindset (PCA)"

* Winsorized variable of technological optimism (used for robustness test)
winsor2 tech_ms_pca, suffix(_win) cuts(5 95)





*--- SAVE ---*
save "$working_ANALYSIS\data\delegates_analysis.dta", replace







