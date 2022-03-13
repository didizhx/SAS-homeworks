*Question #43 ;
*3 Variables 10 observations ; 
data cancerrate;
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\CancerRates.dat';
input  Ranking 1-2 @5 CancerSite $ @18 IncidenceRate ; 
run;
proc print data = cancerrate;
run; 

data cancerrate;
infile 'Desktop\CancerRates.dat';
input  Ranking 1-2 @5 CancerSite $ @18 IncidenceRate ; 
run;
proc print data = cancerrate;
run; 

* Question 44; 
* 4 Variables and 173 observations; 
data AKC;
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\AKCbreeds.dat'
missover; 
input Breed & $35. RankingY1 & RankingY2 & RankingY3 & RankingY4 &; 
run;
proc print data = AKC; 
run; 

*Question 45; 
* 17 variables and 21 observations ; 
*Question 45; 
* 17 variables and 21 observations ; 
data Vaccines; 
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\Vaccines.dat'
missover;
input VaccineName & $29. DiseaseTransmission & $18. WorldwideIncidence & WorldwideDeaths & 
Chile $ 70-76 Cuba $ 77-82  US $ 83-88 UK $ 89-94  Finland $ 95-100 Germany $ 101-106  SaudiArabia $ 107-112 
Ethiopia $ 113-118 
Botswana $ 119-124 India $ 125-130 Australia $ 131-136  China $ 137-142 Japan $ 143-145; 
Run; 
proc print data = vaccines; 
run; 

*Question 46; 
*Character - Company Name, Country, ;
*Numeric - Ranking, Sales, Profits, Assets, Market Value; 
data BigCompanies; 
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\BigCompanies.dat';
input Rating 1-3 @5 CompanyName & $29. Country & $18.
Sales $ Profits $
Assets $  MarketValue $;
run;
proc print data = bigcompanies; 
run;

*Question 47 
*Crayon Number, Color Name, Hexadecimal Code, RGB triplet, pack size, year issued, and year retired
*Number - Crayon Number, pack size
*Character - Color Name, Hexadecimal Code, RGB Triplet, year issued and year retired;
data crayons; 
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\Crayons.dat'
missover; 
input Number 1-3 @4 ColorName & $29. HexCode & $ 30-35 RGB & $15. PackSize YearIssued $ YearRetired $; 
run; 
proc print data = crayons; 
run; 

*Question 48 
*Characters - Mountain Name, Years of First Ascent, 
*Numbers - Height m, Height ft, prominence m; 
data mountains;
infile 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter2_data\Mountains.dat';
input MountainName & $39. HeightM & comma5. 
 HeightFT & comma5. YearOfFirstAscent & $9. ProminenceM $; 
run; 
proc print data = mountains ;
run; 
