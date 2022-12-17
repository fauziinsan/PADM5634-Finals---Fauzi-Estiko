use "/Volumes/Expansion/JPAL/Dropbox x/Digital Finance/7 Data/build/output/sakernas2020.dta", replace


** Short summary on internet usage

gen internet= R17A==1
replace internet=0 if internet!=1


sum internet  [aw=FINAL_WEIG]


** Create demographics variables

* Java

gen java = KODE_PROV==31 | KODE_PROV==32 | KODE_PROV==33 | KODE_PROV==34 | KODE_PROV==35 | KODE_PROV==36



** CREATING MATRIX FOR GRAPH

// Create matrix
clear matrix
mat res=J(3,5,.)


// Fill in matrix
local row=1

foreach var of varlist java female higher_than_hs {
	// Mean
	sum `var' if internet==1 [aw=FINAL_WEIG]
		mat res[`row',1] = r(mean)
		
	// Error bars
	local se = r(sd) / sqrt(r(N))	
		mat res[`row',2] = 	r(mean)-1.96*`se'
		mat res[`row',3] = 	r(mean)+1.96*`se'
		
	//category
	mat res[`row',5]=`row'

	
	local ++row
}

//marker
mat res[1,4]=1
mat res[2,4]=1.5
mat res[3,4]=2



// Replace dataset with matrix
drop _all
svmat res
rename res1 mean
rename res2 ll
rename res3 ul
rename res4 marker




** CREATING GRAPH

// Vertical bar chart
twoway (bar mean marker if res5==1, barwidth(0.45)) || ///
		(bar mean marker if res5==2, barwidth(0.45)) || ///
		(bar mean marker if res5==3, barwidth(0.45)) || ///
		(rcap ll ul marker, lcol(gs4) lwidth(thin) msize(tiny)), ///
		ytit("Share of those that operate internet", size(small)) ///
		graphregion(color(white) fcolor(white)) ///
		yscale(range(0 .5)) ylab(#5, labsize(small)) ///
		xtit("") title("Internet Usage") subtit("") ///
		xlabel(1 "Location: Java" 1.5 "Gender: Female" ///
		2 "Edu: Higher than HS" , ///
		angle(hor) labsize(small) notick) legend(off)
		
gr export "/Users/fauziestiko/Documents/Cornell/sem 1/corruption/internet usage.png", replace
