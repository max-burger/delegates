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
1.	Save the folder __‘replication_ncc’__ to your local drive.
2.	Open the master script __‘run.do’__ and change the global pointing to the working direction (line 20) to the location where you save the folder on your local drive 
3.	Run the master script __‘run.do’__  to replicate the analysis and generate all tables and figures reported in the paper and supplementary online materials

## Dataset
- Online-survey with COP 24 delegates: The dataset is named ‘delegates_raw.dta’

## Descriptions of scripts
__01 – clean.do__ <br> 
This script processes the raw survey data and prepares it for analysis.<br>
__02_analysis.do__<br> 
This script estimates the regressions in Stata, and creates figures and tables, displayed in the main text.<br>
__03_analysis_som.do__<br>
This script carries out all estimations and creates all figures and tables contained in the supplementary online material.<br>
