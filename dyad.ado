*  1.0.1 19nov2010
*  1.0.0 15nov2010   
*  William Reed 
*  wlr@umd.edu

capture prog drop dyad
program dyad
*version 11.0
args start stop

quietly insheet using "http://www.correlatesofwar.org/COW2%20Data/SystemMembership/2008/system2008.1.csv", clear
quietly rename ccode ccodea
quietly keep ccodea year
quietly save frame, replace

local year=`start'
while `year'<=`stop'{
quietly use frame, clear
quietly keep if year==`year'
quietly save `year', replace
local year=`year'+1
}

local year=`start'
while `year'<=`stop'{
quietly use `year'
quietly gen ccodeb=ccodea
quietly fillin ccodea ccodeb
quietly drop if _fillin==0
quietly drop _fillin
quietly gen yeara=`year'
quietly save dyad`year', replace
local year=`year'+1
}

forvalues i=`start'/`stop' { 
quietly append using dyad`i'
quietly erase dyad`i'.dta
quietly erase `i'.dta
}
quietly erase frame.dta
quietly drop year
quietly rename yeara year
quietly sort year ccodea ccodeb
quietly drop if ccodea>ccodeb
quietly duplicates drop
quietly rename ccodea ccode1
quietly rename ccodeb ccode2
quietly label var ccode1 "country code 1"
quietly label var ccode2 "country code 2"
quietly label var year "year"

quietly drop if ccode1==255  & ccode2==260  & year==1990      
quietly drop if ccode1==255  & ccode2==265  & year==1990     
quietly drop if ccode1==678  & ccode2==679  & year==1990   
quietly drop if ccode1==679  & ccode2==680  & year==1990 


end







