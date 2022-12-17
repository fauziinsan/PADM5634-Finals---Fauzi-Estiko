* ==============================================================================
* Project			: Corruption Final Project
* Authors   		: Fauzi Insan Estiko
* Purpose			: PS4
* Stata version  	: 14
* Date created		: Oct 2022
* ==============================================================================

set more off

foreach b in jalan_jakarta palangkaraya_lgbt polsek_palmerah rs_bandung satpam_shopee vbpm satu_oknum polsek_rudi bripda_bagus   {
	import delimited "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/`b'.csv.csv", varnames(1) encoding(ISO-8859-1) clear
	foreach i in profile_picture tweet_url {
		drop if `i' == "" 

	}


	replace posted_time=subinstr(posted_time, "+00:00", "",.)
	replace posted_time=subinstr(posted_time, "T", " ",.)


	generate double numtime = clock(posted_time, "YMDhms")
	format numtime %tc
	keep replies retweets likes numtime 
	drop if numtime ==.

		foreach i in replies retweets likes {
		destring `i', replace	
	}


	gen cat="`b'"


	save "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/`b'.dta", replace 

} 

// VBPM 
use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/vbpm.dta", clear 
gen dailydate = dofc(numtime)
format dailydate %td
gen year=year(dailydate) 

collapse (mean) replies retweets likes (sum) qreplies=replies qretweets=retweets qlikes=likes, by(year) 


	twoway line replies year,  legend(label(1 "Replies")) lc(blue) lpattern(solid) ///
		|| line retweets year, legend(label(2 "Retweets")) lc(red) lpattern(longdash) ///
		|| line likes year, legend(label(3 "Likes")) lc(green) lpattern(shortdash) yaxis(2) ytitle("", axis(2)) ///
		xtitle("Year")  ytit("") caption("Author's calculation from Twitter", span size(vsmall))


		gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/vbpm.png", replace

// oknum 
use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/satu_oknum.dta", clear 
gen dailydate = dofc(numtime)
format dailydate %td
gen year=year(dailydate) 

collapse (mean) replies retweets likes (sum) qreplies=replies qretweets=retweets qlikes=likes, by(year) 

set obs `=_N+3'
local y = 3 
foreach i in 2020 2019 2018 {
	replace year = `i' if _n == `y'
	local ++y
}
local y =3 
foreach i in 2020 2019 2018 {
	replace replies = 0 if year == `i'
	replace retweets= 0 if year == `i'
	replace likes = 0 if year == `i'
}

sort year

	twoway line replies year,  legend(label(1 "Replies")) lc(blue) lpattern(solid) ///
		|| line retweets year, legend(label(2 "Retweets")) lc(red) lpattern(longdash) ///
		|| line likes year, legend(label(3 "Likes")) lc(green) lpattern(shortdash) yaxis(2) ytitle("", axis(2)) ///
		xtitle("Year")  ytit("") caption("Author's calculation from Twitter", span size(vsmall))


		gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/oknum.png", replace


// general

set scheme plotplainblind

use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/jalan_jakarta.dta", clear

foreach i in palangkaraya_lgbt polsek_palmerah rs_bandung satpam_shopee satu_oknum polsek_rudi bripda_bagus {
	append using "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/`i'.dta"
	}

	save "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full-data.dta", replace 

** replies

clear matrix
mat res=J(50,5,.)
local row=1
local x =1
foreach i in jalan_jakarta bripda_bagus polsek_palmerah palangkaraya_lgbt polsek_rudi rs_bandung {
	foreach j in replies retweets likes {
		sum `j' if cat == "`i'" 
		gen `i'_`x'=r(mean)
		local ++x
	}
	local x=1
	
}


foreach i in jalan_jakarta_1 bripda_bagus_1 polsek_palmerah_1 palangkaraya_lgbt_1 polsek_rudi_1 rs_bandung_1  {
	// mean
	sum `i' 
	mat res[`row', 1]=r(mean)

	//error bars
	local se = r(sd) / sqrt(r(N))
	mat res[`row',2] = 	r(mean)-1.96*`se'
	mat res[`row',3] = 	r(mean)+1.96*`se'

	//category
	mat res[`row',4]=`row'


	local ++row

}

//marker
mat res[1,5]=1
mat res[2,5]=1.5
mat res[3,5]=2
mat res[4,5]=2.5
mat res[5,5]=3


		
drop _all
svmat res


twoway 	(bar res1 res5 if res4==1, barwidth(0.4)) || ///
		(bar res1 res5 if res4==2, barwidth(0.4)) || ///
		(bar res1 res5 if res4==3, barwidth(0.4)) || ///
		(bar res1 res5 if res4==4, barwidth(0.4)) || ///
		(bar res1 res5 if res4==5, barwidth(0.4)), ///
		ytit("Proportion", size(vsmall)) ///
		graphregion(color(white) fcolor(white)) ///
		yscale(range(0 1)) ylab(#5, labsize(vsmall)) ///
		legend(off) xtit("")  ///
		xlabel(1 `" "Jakarta" "road"  "' 1.5 `" "Bripda" "Bagus"  "' 2 `" "Racist" "police"  "' 2.5 `" "Islamic" "cafe"  "' 3 `" "Nurse" "hospital"  "', ///
		angle(hor) labsize(vsmall) notick) ///
		xsize(7)


gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full_replies.png", replace

** retweets

use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full-data.dta", clear


clear matrix
mat res=J(50,5,.)
local row=1
local x =1
foreach i in jalan_jakarta bripda_bagus polsek_palmerah palangkaraya_lgbt polsek_rudi rs_bandung {
	foreach j in replies retweets likes {
		sum `j' if cat == "`i'" 
		gen `i'_`x'=r(mean)
		local ++x
	}
	local x=1
	
}


foreach i in jalan_jakarta_2 bripda_bagus_2 polsek_palmerah_2 palangkaraya_lgbt_2 polsek_rudi_2 rs_bandung_2  {
	// mean
	sum `i' 
	mat res[`row', 1]=r(mean)

	//error bars
	local se = r(sd) / sqrt(r(N))
	mat res[`row',2] = 	r(mean)-1.96*`se'
	mat res[`row',3] = 	r(mean)+1.96*`se'

	//category
	mat res[`row',4]=`row'


	local ++row

}

//marker
mat res[1,5]=1
mat res[2,5]=1.5
mat res[3,5]=2
mat res[4,5]=2.5
mat res[5,5]=3


		
drop _all
svmat res


twoway 	(bar res1 res5 if res4==1, barwidth(0.4)) || ///
		(bar res1 res5 if res4==2, barwidth(0.4)) || ///
		(bar res1 res5 if res4==3, barwidth(0.4)) || ///
		(bar res1 res5 if res4==4, barwidth(0.4)) || ///
		(bar res1 res5 if res4==5, barwidth(0.4)), ///
		ytit("Proportion", size(vsmall)) ///
		graphregion(color(white) fcolor(white)) ///
		yscale(range(0 1)) ylab(#5, labsize(vsmall)) ///
		legend(off) xtit("")  ///
		xlabel(1 `" "Jakarta" "road"  "' 1.5 `" "Bripda" "Bagus"  "' 2 `" "Racist" "police"  "' 2.5 `" "Islamic" "cafe"  "' 3 `" "Nurse" "hospital"  "', ///
		angle(hor) labsize(vsmall) notick) ///
		xsize(7)


gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full_retweets.png", replace

** likes

use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full-data.dta", clear


clear matrix
mat res=J(50,5,.)
local row=1
local x =1
foreach i in jalan_jakarta bripda_bagus polsek_palmerah palangkaraya_lgbt polsek_rudi rs_bandung {
	foreach j in replies retweets likes {
		sum `j' if cat == "`i'" 
		gen `i'_`x'=r(mean)
		local ++x
	}
	local x=1
	
}


foreach i in jalan_jakarta_3 bripda_bagus_3 polsek_palmerah_3 palangkaraya_lgbt_3 polsek_rudi_3 rs_bandung_3  {
	// mean
	sum `i' 
	mat res[`row', 1]=r(mean)

	//error bars
	local se = r(sd) / sqrt(r(N))
	mat res[`row',2] = 	r(mean)-1.96*`se'
	mat res[`row',3] = 	r(mean)+1.96*`se'

	//category
	mat res[`row',4]=`row'


	local ++row

}

//marker
mat res[1,5]=1
mat res[2,5]=1.5
mat res[3,5]=2
mat res[4,5]=2.5
mat res[5,5]=3


		
drop _all
svmat res


twoway 	(bar res1 res5 if res4==1, barwidth(0.4)) || ///
		(bar res1 res5 if res4==2, barwidth(0.4)) || ///
		(bar res1 res5 if res4==3, barwidth(0.4)) || ///
		(bar res1 res5 if res4==4, barwidth(0.4)) || ///
		(bar res1 res5 if res4==5, barwidth(0.4)), ///
		ytit("Proportion", size(vsmall)) ///
		graphregion(color(white) fcolor(white)) ///
		yscale(range(0 1)) ylab(#5, labsize(vsmall)) ///
		legend(off) xtit("")  ///
		xlabel(1 `" "Jakarta" "road"  "' 1.5 `" "Bripda" "Bagus"  "' 2 `" "Racist" "police"  "' 2.5 `" "Islamic" "cafe"  "' 3 `" "Nurse" "hospital"  "', ///
		angle(hor) labsize(vsmall) notick) ///
		xsize(7)


gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full_likes.png", replace



** regressions 
use "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/full-data.dta", clear
foreach i in jalan_jakarta bripda_bagus polsek_palmerah palangkaraya_lgbt rs_bandung  {
	sum numtime if cat=="`i'"
	gen numtime_`i'=`r(min)'
	format numtime_`i' %tc
}


gen max_jalan_jakarta="27jun2022 14:06:10 "
gen max_bripda_bagus="5dec2021 5:23:00"
gen max_polsek_palmerah="24nov2022 20:00:00"
gen max_palangkaraya_lgbt="30sep2022 15:00:00"
gen max_rs_bandung="07nov2022 17:00:00"
foreach i in jalan_jakarta bripda_bagus polsek_palmerah palangkaraya_lgbt rs_bandung {
	gen mt_`i'=clock(max_`i', "DMYhms")
	format mt_`i' %tc
	gen d_`i'=mt_`i'-numtime_`i'
}
gen java=.
foreach i in jalan_jakarta bripda_bagus polsek_palmerah {
	replace java =  cat == "`i'"
}
gen pol=.
foreach i in jalan_jakarta {
	replace pol =  cat == "`i'"
}

keep if cat=="jalan_jakarta" | cat=="bripda_bagus" | cat=="polsek_palmerah" | cat=="palangkaraya_lgbt" | cat=="rs_bandung"

gen diff=.
replace diff = 5.57e+08 if cat=="jalan_jakarta"
replace diff = 6.95e+07 if cat=="bripda_bagus"
replace diff = 3.79e+07 if cat=="polsek_palmerah" 
replace diff = 2.62e+08 if cat=="palangkaraya_lgbt"
replace diff = 5.96e+07 if cat=="rs_bandung"

replace diff=diff/86400

eststo clear
eststo: reg diff replies retweets likes
eststo: reg diff replies retweets likes java pol
esttab  using "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/table 1.tex", noobs title("Simple OLS Regression") ///
	label nonumbers booktabs replace  r2 se



/*

collapse (mean) replies retweets likes java pol diff (sum) qreplies=replies qretweets=retweets qlikes=likes, by(cat) 

replace diff=diff/86400
eststo clear
eststo: reg diff replies retweets likes
esttab  using "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/table 1.tex", noobs title("Simple OLS Regression") ///
	label nonumbers booktabs replace  r2 se
*/








