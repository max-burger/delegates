# Replication Package
This repository contains the raw data and code that replicates tables and figures for the following paper: <br><br>
__Title:__ Climate delay: The downside of believing in technological fixes<br>
__Authors:__ Max Burger<sup>1,*</sup>, Donia Mahabadi<sup>1,2</sup> & Björn Vollan<sup>1</sup> <br>
__Affiliations:__ <sup>1</sup> Department of Economics, Philipps University Marburg, 35032 Marburg, Germany <br>
<sup>2</sup> Leibniz-Institute of Ecological Urban and Regional Development, Weberplatz 1, 01217 Dresden, Germany <br>
__*Correspondence to:__ Björn Vollan bjoern.vollan@wiwi.uni-marburg.de <br>
__ORCID:__ Burger: 0000-0003-2334-3885; Mahabadi: 0000-0002-2104-9247; Vollan: 0000-0002-5592-4185 <br>
__Classification:__ Social Sciences, Economic Sciences <br>
__Keywords:__ Technological optimism, Carbon pricing, Climate delay, Mindset, Leverage points <br>

## Abstract
One paradigm contributing to climate delay is the belief that technological innovation such as capturing and storing carbon can decouple economic growth from emissions in order to achieve the 1.5°C target without systemic changes. Based on surveys with UNFCCC COP24 delegates, higher belief in technological solutions related to climate change is associated with accepting higher temperature increases by 2100 and recommending lower carbon prices. While technology is important, relying solely on potential future advancements increases the risk of irreversible and catastrophic environmental and societal consequences. Our research emphasizes the importance of mindsets and paradigms in the pursuit of  climate action.

## License
The data and code are licensed under a Creative Commons Attribution 4.0 International Public License. See __LICENSE.txt__ for details.

## Software requirements
All analysis were done in Stata version 16:
- Add-on packages are included in __scripts/libraries/stata__ and do not need to be installed by user. The names, installation sources, and installation dates of these packages are available in __scripts/libraries/stata/stata.trk__.

## Instructions
1.	Save the folder __‘replication_PLOS’__ to your local drive.
2.	Open the master script __‘run.do’__ and change the global pointing to the working direction (line 20) to the location where you save the folder on your local drive 
3.	Run the master script __‘run.do’__  to replicate the analysis and generate all tables and figures reported in the paper and supplementary online materials

## Datasets
- Wave 1 – Survey experiment: __‘wave1_survey_experiment_raw.dta’__
- Wave 2 – Follow-up Survey: __‘wave2_follow_up_raw.dta'__
- Map: shape-files __‘plz2stellig.shp’ ‘OSM_PLZ.shp’__, area codes __‘Postleitzahlengebiete_-_OSM.csv’__,  (all links to the sources can be found in the script ‘04_figure2_germany_map.do’)
- Pretest: __‘pre-test_corona_raw.dta’__
- For Appendix S7: __‘alter_geschlecht_zensus_det.xlsx’, ‘vaccination_landkreis_raw.dta’, ‘census2020_age_gender.csv’__ (all links to the sources can be found in the script ‘06_AppendixS7.do’)
- For Appendix S10: ‘__vaccination_landkreis_raw.dta’__ (all links to the sources can be found in the script ‘07_AppendixS10.do’)

## Descriptions of scripts
__1_1_clean_wave1.do__ <br>
This script processes the raw data from wave 1, the survey experiment <br>
__1_2_clean_wave2.do__ <br>
This script processes the raw data from wave 2, the follow-up survey <br>
__1_3_merge_generate.do__ <br>
This script creates the datasets used in the main analysis and for robustness checks by merging the cleaned data from wave 1 and 2, tests the exclusion criteria and creates additional variables <br>
__02_analysis.do__ <br>
This script estimates regression models in Stata, creates figures and tables, saving them to __results/figures and results/tables__ <br>
__03_robustness_checks_no_exclusion.do__ <br>
This script runs the main analysis using the dataset without applying the exclusion criteria. Results are saved in __results/tables__ <br>
__04_figure2_germany_map.do__  <br>
This script creates Figure 2 in the main manuscript using publicly available data on vaccination numbers in Germany. <br>
__05_figureS1_dogmatism_scale.do__ <br>
This script creates Figure S1 using data from a pretest to adjust the dogmatism scale. <br>
__06_AppendixS7.do__ <br>
This script creates the figures and tables provided in Appendix S7 on the representativity of our sample compared to the German average using publicly available data about the age distribution in Germany. <br>
__07_AppendixS10.do__ <br>
This script creates the figures and tables provided in Appendix S10 on the external validity of vaccination rates in our sample using publicly available data on vaccination numbers in Germany.




