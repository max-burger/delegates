*-----------------
*   Cleaning & Generating
*-----------------

use "$working_ANALYSIS\data\delegates_raw.dta", clear



*---------
*   Generating variables
*----------

// Sociodemographics
* Education
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
** Temperature above 1.5 degrees
gen temp_above = .
replace temp_above = 0 if temp_rise <= 1.5
replace temp_above = 1 if temp_rise > 1.5
lab var temp_above "Temperature rise above 1.5°C deemed acceptable"

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
** Logarithmic form of suggested carbon prices
gen ln_carbon_price = ln(carbon_price + 1)
label var ln_carbon_price "Natural logarithm of suggested carbon_price"

** Cropping carbon price suggested at 500 for visualization in figure 1a
gen carbon_price_cap = carbon_price
replace carbon_price_cap  = 501 if carbon_price > 500
egen mean_carbon_price = mean(carbon_price), by(temp_rise_cropped)
egen median_carbon_price = median(carbon_price), by(temp_rise_cropped)
tab temp_rise_cropped , gen(tr)

** Price suggested below 60 USD
gen price_below = .
replace price_below = 0 if carbon_price >= 60 
replace price_below = 1 if carbon_price < 60 
lab var price_below "Price suggested < USD60"

/*
Carbon price suggestions tested
Different models suggest different minimal global carbon prices to stay below a certain temperature rise. In the main paper we use USD60 as thte threshold. As robustness test, we also test against other specifications: 82 USD, 185 USD, 281 USD
*/
foreach i in 37 60 82 185 281 {
	gen price_below_`i' = .
		replace price_below_`i'= 1 if carbon_price < `i'
		replace price_below_`i'= 0 if carbon_price >=  `i'
        lab var price_below_`i' "Price below USD `i' suggested"
}

** Shifting
// Other countries
* To OECD
gen shift_to_oecd = price_oecd_now - price_home_now 
lab var shift_to_oecd "Shift to OECD Countries (if > 0 shift to others)" 
* To LDCs
gen shift_to_ldc = price_ldc_now - price_home_now 
lab var shift_to_ldc "Shift to LD Countries (if > 0 shift to others)" 

* From LDC to OECD
gen shift_ldc_oecd = price_oecd_now - price_ldc_now 
lab var shift_ldc_oecd "Shift from LDC to OECD (if > 0 OECD-countries should pay higher price)"

// Shifting responsibilties to the future
* Home Country
gen shift_future_home = price_home_future - price_home_now 
lab var shift_future_home "Shift to future: Home (if>0 shift to future)" 
* OECD Countries
gen shift_future_oecd = price_oecd_future - price_oecd_now 
lab var shift_future_oecd "Shift to future: OECD (if>0 shift to future)"
* Least Developed Countries
gen shift_future_ldc = price_ldc_future  - price_ldc_now
lab var shift_future_ldc "Shift to future: Home (if>0 shift to future)"









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

** Categorizing the ambitions of delegates for prices now and in the future
gen ambition_home_fut = .
replace ambition_home_fut = 1 if price_home_now < 60  & price_home_future < 60  // Low ambition
replace ambition_home_fut = 2 if price_home_now < 60  & price_home_future >= 60 // Shift to future
replace ambition_home_fut = 3 if price_home_now >= 60 & price_home_future < 60  // Shift to now
replace ambition_home_fut = 4 if price_home_now >= 60 & price_home_future >= 60 // High ambition
lab define ambition_fut 1 "Low ambition" 2 "Future pay more" 3 "Now pay more" 4 "High ambition", replace
lab val ambition_home_fut ambition_fut



// Principal components
** Technological optimism
alpha tech_ms_1 tech_ms_2 tech_ms_3 tech_ms_4 tech_ms_5 tech_ms_6 
pca tech_ms_1 tech_ms_2 tech_ms_3 tech_ms_4 tech_ms_5 tech_ms_6
predict tech_ms_pca
lab var tech_ms_pca "Technological optimism mindset (PCA)"

* Winsorized variable of technological optimism (used for robustness test)
winsor2 tech_ms_pca, suffix(_win) cuts(5 95)

** Environmental caution
alpha env_ms_1 env_ms_2 env_ms_3 env_ms_4 env_ms_5 
pca env_ms_1 env_ms_2 env_ms_3 env_ms_4 env_ms_5 
predict env_ms_pca
lab var env_ms_pca "Items on environmental caution (PCA)"

** Negotiations
pca negotiate1 negotiate2 negotiate3 negotiate4 negotiate5 negotiate6 negotiate7 // negotiate 3 only contributes marginally
pca negotiate1 negotiate2 negotiate4 negotiate5 negotiate6 negotiate7 // 
predict negotiate_pca
lab var negotiate_pca "PCA: Negotiations (higher values, higher agreement)"

** Negotiate own and other delgeation
* Own delegation
gen negotiate_pca_own = .
replace negotiate_pca_own = negotiate_pca if t_own_delegation == 1

* Other delegation
gen negotiate_pca_other = .
replace negotiate_pca_other = negotiate_pca if t_own_delegation == 0




*--- SAVE ---*
save "$working_ANALYSIS\data\delegates_analysis.dta", replace







