***********************************************************************************
**** Moving Markets? Government Bond Investors and Microeconomic Policy Changes ***
**** Mosley, Layna, Paniagua, Victoria and Wibbels, Erik **************************
***********************************************************************************

** Replication Code #2

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


*************
** Table 7 **
*************

xtset idcode date2
	
set more off

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow prime USmarkets_pc, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve  USmarkets_pc electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 Procapitalewindow Anticapitalewindow ///
prime reserve   USmarkets_pc electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket prime USmarkets_pc, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve  USmarkets_pc electionmonth_dummy execrlc_recoded growth, fe vce(cluster idcode)

xtreg cds5yr_pchg2 laborpromarket laborantimarket corppromarket corpantimarket ///
prime reserve  USmarkets_pc electionmonth_dummy execrlc_recoded lgdp, fe vce(cluster idcode)


