***********************************************************************************
**** Appendix: Moving Markets? Government Bond Investors and Microeconomic Policy Changes ***
**** Mosley, Layna, Paniagua, Victoria and Wibbels, Erik **************************
***********************************************************************************


** Replication Code #3

use "Data_Moving_Market.dta", clear

* Data preparation 

* Labor regulation and corporate tax event windows  

foreach type in labor corp{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

	
foreach type in labor corp{
	gen `type'ewindow=0
	
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}	
	

* Pro-market and anti-market event windows 


foreach type in Procapital Anticapital{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

	
foreach type in Procapital Anticapital{
	gen `type'ewindow=0
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}

	
* Labor & pro-market, labor & anti-market, corporate & pro-martet, corporate & anti-market event windows. 


gen laborpromarket=0
replace laborpromarket=1 if laborewindow==1 & Procapitalewindow==1

gen laborantimarket=0
replace laborantimarket=1 if laborewindow==1 & Anticapitalewindow==1

gen corppromarket=0
replace corppromarket=1 if corpewindow==1 & Procapitalewindow==1

gen corpantimarket=0
replace corpantimarket=1 if corpewindow==1 & Anticapitalewindow==1





***************
** Table A13 **
***************

xtset idcode date2
	
set more off

xtreg cds5yr_pchg Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded inflat growth, fe vce(cluster idcode)

xtreg cds5yr_pchg Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded inflat lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded inflat growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded inflat lgdp, fe vce(cluster idcode)


********************
** Tables A14-A17 **
********************

use "Data_Moving_Market.dta", clear

* Replace panelsize as follows:
* Table A14: 2
* Table A15: 5
* Table A16: 10
* Table A17: 15


foreach type in labor corp{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

	
foreach type in labor corp{
	gen `type'ewindow=0
	
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}	
	

foreach type in Procapital Anticapital{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


* Replace panelsize (see above)	
global panelsize=2

	
foreach type in Procapital Anticapital{
	gen `type'ewindow=0
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}

	
gen laborpromarket=0
replace laborpromarket=1 if laborewindow==1 & Procapitalewindow==1

gen laborantimarket=0
replace laborantimarket=1 if laborewindow==1 & Anticapitalewindow==1

gen corppromarket=0
replace corppromarket=1 if corpewindow==1 & Procapitalewindow==1

gen corpantimarket=0
replace corpantimarket=1 if corpewindow==1 & Anticapitalewindow==1

**

xtset idcode date2
	
set more off

xtreg cds5yr_pchg Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)



***************
** Table A18 **
***************

**** See below ****

***************
** Table A19 **
***************


**** See below ****


***************
** Table A20 **
***************


xtreg cds5yr_pchg2 Procapitalewindow##i.autoc Anticapitalewindow##i.autoc ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow##i.autoc Anticapitalewindow##i.autoc ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket##i.autoc laborantimarket##i.autoc corppromarket##i.autoc corpantimarket##i.autoc ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket##i.autoc laborantimarket##i.autoc corppromarket##i.autoc corpantimarket##i.autoc ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)


***************
** Table A21 **
***************

xtreg cds5yr_pchg2 Procapitalewindow##i.oecd Anticapitalewindow##i.oecd ///
prime reserve electionmonth_dummy growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow##i.oecd Anticapitalewindow##i.oecd ///
prime reserve electionmonth_dummy lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket##i.oecd laborantimarket##i.oecd corppromarket##i.oecd corpantimarket##i.oecd ///
prime reserve electionmonth_dummy  growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket##i.oecd laborantimarket##i.oecd corppromarket##i.oecd corpantimarket##i.oecd ///
prime reserve electionmonth_dummy lgdp, fe vce(cluster idcode)

***************
** Table A23 **
***************

drop if year>=2007 & year<=2010

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)


***************
** Table A24 **
***************


drop if year>=2009 & year<=2012

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)



***************
** Table A25 **
***************

drop if year>=2007 & year<=2010

xtreg vol Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg vol Procapitalewindow Anticapitalewindow ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg vol laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg vol laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)



***************
** Table A18 **
***************


use "Data_Moving_Market.dta", clear


foreach type in labor corp{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

/*Generate event dummies*/

foreach type in labor corp{
forvalues i = 1/$panelsize{
	gen byte `type'leaddiff`i' = 0
	gen byte `type'lagdiff`i' = 0
	forvalues e = 1/${`type'enum} {
		replace `type'leaddiff`i' = 1 if (date2 - `type'event`e'== `i')
		replace `type'lagdiff`i' = 1 if (date2 - `type'event`e' == -`i')
	}
}

/*With multiple event dummies turned on, we don't want an omitted category*/

gen byte `type'event = 0
forvalues e = 1/${`type'enum}{
	replace `type'event = 1 if date2 == `type'event`e'
}

drop *lagdiff1

/*Set the end point dummies to stay on, and count up*/
sort idcode date2

by idcode: replace `type'leaddiff$panelsize = sum(`type'leaddiff$panelsize)

gsort idcode - date2

by idcode: replace `type'lagdiff$panelsize = sum(`type'lagdiff$panelsize)
}
sort idcode date2




foreach type in Procapital Anticapital{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

/*Generate event dummies*/

foreach type in Procapital Anticapital{
forvalues i = 1/$panelsize{
	gen byte `type'leaddiff`i' = 0
	gen byte `type'lagdiff`i' = 0
	forvalues e = 1/${`type'enum} {
		replace `type'leaddiff`i' = 1 if (date2 - `type'event`e'== `i')
		replace `type'lagdiff`i' = 1 if (date2 - `type'event`e' == -`i')
	}
}

/*With multiple event dummies turned on, we don't want an omitted category*/

gen byte `type'event = 0
forvalues e = 1/${`type'enum}{
	replace `type'event = 1 if date2 == `type'event`e'
}

drop *lagdiff1

/*Set the end point dummies to stay on, and count up*/
sort idcode date2

by idcode: replace `type'leaddiff$panelsize = sum(`type'leaddiff$panelsize)

gsort idcode - date2

by idcode: replace `type'lagdiff$panelsize = sum(`type'lagdiff$panelsize)
}
sort idcode date2 


**

xtset idcode date2

set more off

areg cds5yr_pchg Procapitalleaddiff* Procapitallagdiff* Anticapitalleaddiff* Anticapitallagdiff* *event ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth, absorb(idcode) cluster(idcode)

areg cds5yr_pchg *leaddiff* *lagdiff* *event ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp, absorb(idcode) cluster(idcode)

areg cds5yr_pchg *leaddiff* *lagdiff* *event ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth inflat, absorb(idcode) cluster(idcode)

areg cds5yr_pchg *leaddiff* *lagdiff* *event ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp inflat, absorb(idcode) cluster(idcode)


***************
** Table A19 **
***************


use "/Users/victoriapaniagua/Dropbox/Working Papers/Credit Default Swaps/Wibbels-Mosley-Paniagua/CDS_Data_Approach1+2_full_final_single.dta", clear


global panelsize=7

bysort idcode: gen eventcount=sum(eventday)

	summ eventcount
	global enum = r(max)
	
	gen ewindow = 0
	forvalues i = 1/$panelsize{
	forvalues e = 1/${enum} {
	replace ewindow=1 if (date2 - event`e' <= `i' & date2 - event`e' >= -`i') 
	}
	}
	*


foreach type in labor corp{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

	
foreach type in labor corp{
	gen `type'ewindow=0
	
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}	
	

foreach type in Procapital Anticapital{
	bysort idcode: gen `type'eventcount=sum(`type'eventday)

	summ `type'eventcount
	global `type'enum = r(max)
	
	}


global panelsize=7

	
foreach type in Procapital Anticapital{
	gen `type'ewindow=0
	forvalues i = 1/$panelsize{
	forvalues e = 1/${`type'enum} {
	replace `type'ewindow= 1 if (date2 - `type'event`e'<= `i' & date2 - `type'event`e'>= `i')
	}
	}
	}


gen laborpromarket=0
replace laborpromarket=1 if laborewindow==1 & Procapitalewindow==1

gen laborantimarket=0
replace laborantimarket=1 if laborewindow==1 & Anticapitalewindow==1

gen corppromarket=0
replace corppromarket=1 if corpewindow==1 & Procapitalewindow==1

gen corpantimarket=0
replace corpantimarket=1 if corpewindow==1 & Anticapitalewindow==1

**

xtset idcode date2
	
set more off
	
xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime USmarkets_pc reserve electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)


