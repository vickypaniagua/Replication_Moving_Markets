***********************************************************************************
**** Appendix: Moving Markets? Government Bond Investors and Microeconomic Policy Changes ***
**** Mosley, Layna, Paniagua, Victoria and Wibbels, Erik **************************
***********************************************************************************


** Replication Code #1
**EVENT STUDY ANALYSIS


*****************************************************************
* Event window= 5, Estimation window=30, Gap between windows= 15
******************************************************************

use "~\Data_Moving_Market_Event_Study.dta", clear

sort group_id
by group_id: gen event_window=1 if dif>=-2 & dif<=2
egen count_event_obs=count(event_window), by(group_id)

by group_id: gen estimation_window=1 if dif<-17 & dif>=-47
egen count_est_obs=count(estimation_window), by(group_id)
replace event_window=0 if event_window==.
replace estimation_window=0 if estimation_window==.

tab idcode group_id if count_event_obs<5
tab idcode group_id if count_est_obs<30

codebook group_id if count_event_obs<5
codebook group_id if count_est_obs<30


 drop if count_event_obs <5
 drop if count_est_obs < 30
 

**** Estimate Normal Performance 

set more off 

gen predicted_return=.
*egen id=group(country_id)* 
 /* for multiple event dates, use:*/
 egen id = group(group_id)
forvalues i=1(1)47 { /*note: replace N with the highest value of id */ 
	l id idcode if id==`i' & dif==0
	reg cds5yr_pchg USmarkets_pc if id==`i' & estimation_window==1 
	predict p if id==`i'
	replace predicted_return = p if id==`i' & event_window==1 
	drop p
} 

*** Calculate Abnormal Returns

sort id date2
gen abnormal_return=cds5yr_pchg-predicted_return if event_window==1
by id: egen cumulative_abnormal_return = sum(abnormal_return) 

*Test for significance


sort id date2
by id: egen ar_sd = sd(abnormal_return) 
/*with x days as number of days in event window*/
gen test =(1/sqrt(5)) * ( cumulative_abnormal_return /ar_sd) 
gen sig = abs(test)>1.96
gen sigcarpospro = test>=1.96 & Procapital==1
gen sigcarnegpro = test<-1.96 & Procapital==1
gen sigcarposanti = test>=1.96 & Anticapital==1
gen sigcarneganti = test<-1.96 & Anticapital==1
gen sigpro = abs(test)>1.96 & Procapital==1
gen siganti = abs(test)>1.96 & Procapital==0
list id wbcode cumulative_abnormal_return e_date type Procapital sig sigcarpospro sigcarnegpro sigcarposanti sigcarneganti test if dif==0


***************************************************
* Event window= 10, estimation window= 30, gap=15
***************************************************

use "/Users/victoriapaniagua/Dropbox/Working Papers/PUBLISHED/Mosley Paniagua Wibbels - Economics and Politics 2020/Credit Default Swaps/Replication materials CDS paper/Event study/CDS_for_Event_Analysis_final.dta", clear

sort group_id
by group_id: gen event_window=1 if dif>=-5 & dif<=5
egen count_event_obs=count(event_window), by(group_id)

by group_id: gen estimation_window=1 if dif<-20 & dif>=-50
egen count_est_obs=count(estimation_window), by(group_id)
replace event_window=0 if event_window==.
replace estimation_window=0 if estimation_window==.


tab idcode group_id if count_event_obs<11
tab idcode group_id if count_est_obs<30

codebook group_id if count_event_obs<11
codebook group_id if count_est_obs<30


 drop if count_event_obs <11
 drop if count_est_obs < 30
 

****Estimate Normal Performance 


set more off 

gen predicted_return=.
*egen id=group(country_id)* 
 /* for multiple event dates, use:*/
 egen id = group(group_id)
forvalues i=1(1)47 { /*note: replace N with the highest value of id */ 
	l id idcode if id==`i' & dif==0
	reg cds5yr_pchg USmarkets_pc if id==`i' & estimation_window==1 
	predict p if id==`i'
	replace predicted_return = p if id==`i' & event_window==1 
	drop p
} 

*** Calculate Abnormal Returns


sort id date2
gen abnormal_return=cds5yr_pchg-predicted_return if event_window==1
by id: egen cumulative_abnormal_return = sum(abnormal_return) 

*Test for significance



sort id date2
by id: egen ar_sd = sd(abnormal_return) 
/*with x days as number of days in event window*/
gen test =(1/sqrt(10)) * ( cumulative_abnormal_return /ar_sd) 
gen sig = abs(test)>1.96
gen sigcarpospro = test>=1.96 & Procapital==1
gen sigcarnegpro = test<-1.96 & Procapital==1
gen sigcarposanti = test>=1.96 & Anticapital==1
gen sigcarneganti = test<-1.96 & Anticapital==1
gen sigpro = abs(test)>1.96 & Procapital==1
gen siganti = abs(test)>1.96 & Procapital==0
list id wbcode cumulative_abnormal_return e_date type Procapital sig sigcarpospro sigcarnegpro sigcarposanti sigcarneganti test if dif==0


****************************************************
** Event window= 15, estimation window= 30, gap 15
****************************************************

use "/Users/victoriapaniagua/Dropbox/PhD Political Science - DUKE/RA/Wibbels-Mosley-Paniagua/Data/CDS_for_Event_Analysis_final.dta", clear


sort group_id
by group_id: gen event_window=1 if dif>=-7 & dif<=7
egen count_event_obs=count(event_window), by(group_id)

by group_id: gen estimation_window=1 if dif<-22 & dif>=-52
egen count_est_obs=count(estimation_window), by(group_id)
replace event_window=0 if event_window==.
replace estimation_window=0 if estimation_window==.



tab idcode group_id if count_event_obs<15
tab idcode group_id if count_est_obs<30

codebook group_id if count_event_obs<15
codebook group_id if count_est_obs<30


 
 drop if count_event_obs <15
 drop if count_est_obs < 30
 

****Estimate Normal Performance 




set more off 

gen predicted_return=.
*egen id=group(country_id)* 
 /* for multiple event dates, use:*/
 egen id = group(group_id)
forvalues i=1(1)47 { /*note: replace N with the highest value of id */ 
	l id idcode if id==`i' & dif==0
	reg cds5yr_pchg USmarkets_pc if id==`i' & estimation_window==1 
	predict p if id==`i'
	replace predicted_return = p if id==`i' & event_window==1 
	drop p
} 

*** Calculate Abnormal Returns


sort id date2
gen abnormal_return=cds5yr_pchg-predicted_return if event_window==1
by id: egen cumulative_abnormal_return = sum(abnormal_return) 

*Test for significance


sort id date2
by id: egen ar_sd = sd(abnormal_return) 
/*with x days as number of days in event window*/
gen test =(1/sqrt(15)) * ( cumulative_abnormal_return /ar_sd) 
gen sig = abs(test)>1.96
gen sigcarpospro = test>=1.96 & Procapital==1
gen sigcarnegpro = test<-1.96 & Procapital==1
gen sigcarposanti = test>=1.96 & Anticapital==1
gen sigcarneganti = test<-1.96 & Anticapital==1
gen sigpro = abs(test)>1.96 & Procapital==1
gen siganti = abs(test)>1.96 & Procapital==0
list id wbcode cumulative_abnormal_return e_date type Procapital sig sigcarpospro sigcarnegpro sigcarposanti sigcarneganti test if dif==0


*****************************************************
** Event window = 21, estimation window= 30, gap=15
*****************************************************

use "/Users/victoriapaniagua/Dropbox/PhD Political Science - DUKE/RA/Wibbels-Mosley-Paniagua/Data/CDS_for_Event_Analysis_final.dta", clear

sort group_id
by group_id: gen event_window=1 if dif>=-10 & dif<=10
egen count_event_obs=count(event_window), by(group_id)

by group_id: gen estimation_window=1 if dif<-25 & dif>=-55
egen count_est_obs=count(estimation_window), by(group_id)
replace event_window=0 if event_window==.
replace estimation_window=0 if estimation_window==.



tab idcode group_id if count_event_obs<21
tab idcode group_id if count_est_obs<30

codebook group_id if count_event_obs<21
codebook group_id if count_est_obs<30

 drop if count_event_obs <21
 drop if count_est_obs < 30
 

****Estimate Normal Performance 



set more off 

gen predicted_return=.
*egen id=group(country_id)* 
 /* for multiple event dates, use:*/
 egen id = group(group_id)
forvalues i=1(1)47 { /*note: replace N with the highest value of id */ 
	l id idcode if id==`i' & dif==0
	reg cds5yr_pchg USmarkets_pc  if id==`i' & estimation_window==1 
	predict p if id==`i'
	replace predicted_return = p if id==`i' & event_window==1 
	drop p
} 

*** Calculate Abnormal Returns

sort id date2
gen abnormal_return=cds5yr_pchg-predicted_return if event_window==1
by id: egen cumulative_abnormal_return = sum(abnormal_return) 

*Test for significance



sort id date2
by id: egen ar_sd = sd(abnormal_return) 
/*with x days as number of days in event window*/
gen test =(1/sqrt(21)) * ( cumulative_abnormal_return /ar_sd) 
gen sig = abs(test)>1.96
gen sigcarpospro = test>=1.96 & Procapital==1
gen sigcarnegpro = test<-1.96 & Procapital==1
gen sigcarposanti = test>=1.96 & Anticapital==1
gen sigcarneganti = test<-1.96 & Anticapital==1
gen sigpro = abs(test)>1.96 & Procapital==1
gen siganti = abs(test)>1.96 & Procapital==0
list id wbcode cumulative_abnormal_return e_date type Procapital sig sigcarpospro sigcarnegpro sigcarposanti sigcarneganti test if dif==0



**************************
**************************
******* Appendix *********
**************************
**************************


********************
** Tables A6-A7 **
******************** 

use "~\Data_Moving_Market_Event_Study.dta", clear

* Vary estimation window size 

sort group_id
by group_id: gen event_window=1 if dif>=-5 & dif<=5
egen count_event_obs=count(event_window), by(group_id)

by group_id: gen estimation_window=1 if dif<-20 & dif>=-50
egen count_est_obs=count(estimation_window), by(group_id)
replace event_window=0 if event_window==.
replace estimation_window=0 if estimation_window==.

tab idcode group_id if count_event_obs<10
tab idcode group_id if count_est_obs<30

codebook group_id if count_event_obs<10
codebook group_id if count_est_obs<30

drop if count_event_obs <10
drop if count_est_obs < 30
 
set more off 

gen predicted_return=.
*egen id=group(country_id)* 
 /* for multiple event dates, use:*/
 egen id = group(group_id)
forvalues i=1(1)47 { /*note: replace N with the highest value of id */ 
	l id idcode if id==`i' & dif==0
	reg cds5yr_pchg USmarkets_pc if id==`i' & estimation_window==1 
	predict p if id==`i'
	replace predicted_return = p if id==`i' & event_window==1 
	drop p
} 

sort id date2
gen abnormal_return=cds5yr_pchg-predicted_return if event_window==1
by id: egen cumulative_abnormal_return = sum(abnormal_return) 


sort id date2
by id: egen ar_sd = sd(abnormal_return) 
/*with x days as number of days in event window*/
gen test =(1/sqrt(5)) * ( cumulative_abnormal_return /ar_sd) 
gen sig = abs(test)>1.96
gen sigpro = abs(test)>1.96 & Procapital==1
gen siganti = abs(test)>1.96 & Procapital==0
list id wbcode cumulative_abnormal_return e_date type sigpro siganti test if dif==0





