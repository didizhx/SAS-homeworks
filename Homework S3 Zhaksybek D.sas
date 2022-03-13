libname Ch6 'C:\Users\dzhaksybek\OneDrive - IESEG\SAS BA Tools commercial\data files\SAS_Additional_Exercises\Chapter6_data';
*Question 29;
*Countries data;
DATA australia;
SET ch6.australia;
rank = _N_;
Country = 'Australia';
RUN;

DATA brazil;
SET ch6.brazil;
rank = _N_;
Rename Menina = Girl Menino = Boy;
Country = 'Brazil';
RUN;
DATA france;
SET ch6.france;
rank = _N_;
Rename Fille = Girl Garcon = Boy;
Country = 'France';
RUN;
DATA india;
SET ch6.india;
rank = _N_;
Rename Laraki = Girl Laraka = Boy;
Country = 'India';
RUN;

DATA russia;
SET ch6.russia;
rank = _N_;
Rename Devushka = Girl Malchik = Boy;
Country = 'Russia';
RUN;

*Grouping;
DATA groupcountry;
SET australia russia india brazil france;
RUN;
PROC PRINT DATA = groupcountry;
RUN;

*Grouping by rank;
DATA groupinterleav;
SET australia russia india brazil france;
BY rank;
PROC PRINT DATA = groupinterleav;
RUN;

*Question 30;
proc sort data = Ch6.teachers out = teacher_sorted;
by TeacherScore CurriculumGrd;
run;
data teachers_two;
merge ch6.district (rename=(TS=TeacherScore CG=CurriculumGrd)) teacher_sorted;
by TeacherScore CurriculumGrd;
if Teacher ^= "";
run;
proc sort data = teachers_two;
by Teacher;
run;
*Question 31;
proc sort data = Ch6.aveprices out = aveprices_sorted;
by year commodity;
run;
proc means data = aveprices_sorted noprint;
by year commodity;
output out = aveprices_means(drop = _type_ _freq_) mean(price) = YearMeanPrice;
run;
proc transpose data = aveprices_sorted prefix = Month out = aveprices_transpose(drop = _label_ _name_);
by year commodity;
var price;
run;
data aveprices_two;
merge aveprices_transpose aveprices_means;
by year commodity;
run;
data eggs gas milk;
set aveprices_two;
if commodity = "Egg" then output eggs;
else if commodity = "Gas" then output gas;
else if commodity = "Milk" then output milk;
run;

*Quesiton 32; 

PROC FREQ DATA = C6EA.txgroup NOPRINT;
BY id;
TABLES id tx / OUT = subject_duplicates;
RUN;

PROC PRINT DATA = sub_dup;
WHERE count > 1;
RUN;

PROC SORT DATA = C6EA.V OUT = V_S NODUP;
BY id;
RUN;

PROC SORT DATA= C6EA.TG OUT = TG_S NODUP;
BY id;
RUN;

DATA full;
MERGE V_S TG_S;
BY id;
RUN;

PROC MEANS DATA = C6EA.V MEDIAN NOPRINT;
VAR B_C;
OUTPUT OUT= median_C MEDIAN(B_C) = chol_median;
run;



DATA _null_;
SET median_C;
CALL symput("med", chol_median);
RUN;

DATA C_G;
SET C;
LENGTH Group $40;
IF B_C <= &med then group = "Less than or equal to median";
ELSE IF B_C > &med then group = "Greater than median";
ELSE group = "Unknown";
RUN;

DATA schedule(rename=(visitdt=visitnumber0));
SET C_G;

ARRAY visitday (3) visitnumber1-visitnumber3;
DO i = 1 to 3 by 1;
visitday(i) = visitdt + (i * 30);
END;

DROP visit i;
FORMAT visitdt mmddyy10. visitnumber1-visitnumber3 mmddyy10.;
RUN;


*Question 33; 
proc sort data = ch6.users out = users_sorted nodup;
by userid;
run;

proc sort data = ch6.projects out = projects_sorted nodup;
by userid;
run;

data users_projects complete incompleted none;
merge users_sorted projects_sorted;
by userid;
if first.userid then total = 0;
if enddate <> . then total + 1;
if enddate <> . then output complete;
if enddate = . then output incompleted;
if projectid = . then output none;
output users_projects;
run;

*Question 34;
*PART A:;
proc sort data = ch6.iluvthe80s out = bands_sorted;
	by band;
run;

data SongsperBand; 
set bands_sorted;
by band;
if first.band then total = 0;
total + 1; run;

*Part B;
proc sort data = ch6.iluvthe80s out = genre_sorted;
by genre; run;

proc means data = genre_sorted median noprint;
by genre;
var length;
output out = med_length(drop=_type_ _freq_) median(length) = MedianLength;
run;

*PART C:;
proc sort data = SongsperBand;
	by genre;
run;

data counts_with_median;
	merge SongsperBand med_length;
	by genre;
run;


*Question 35;

* PART A:Sort order in SchoolSurbey is student_id. sorting by family id instead ;
data schoolsurvey;
set ch6.schoolsurvey;
run; 
proc sort data=schoolsurvey;
by Family_id;
run; 

* Part B:;
data Grade6 (rename = (DOB = GR6DOB)); 
set schoolsurvey; ;
if grade = '6th';
run;
* Part C:;

data Merged;
merge schoolsurvey Grade6;
by family_id;
Difference_Age = dob - GR6DOB;
run;

*Part D;
proc freq data = Merged noprint;
	where Difference_Age < 0;
	tables family_id / out = older_freq(rename = (COUNT = NumOldSibs));
run;

proc freq data = Merged noprint;
	where Difference_Age > 0;
	tables family_id / out = younger_freq(rename = (COUNT = NumYoungSibs));
run;

data SibFreq;
	merge Merged older_freq younger_freq;
	by family_id;
	gr_count = 1;
	if grade = "6th";
run;




*Question 36;
*Sort order in Friends data set by ID Ascending. NewInfo is not sorted as data is added 
every time a new donation or change in info received;
*friends data set; 
data friends;
set ch6.friends ; 
input ID LastName $ FirstName$ Address $ City $ State $ Volunteer $;
run;
*newinfo dataset;
data newinfo; 
set ch6.newinfo;
input ID Donation $ Campaign $ Volunteer $ LastName $ FirstName $ Address $ City $ State $; 
run; 
*sorting newinfo dataset; 
proc sort data=newinfo; 
by ID; 
run; 
* PARTB: updating the master data set;
data ch6.friends; 
update ch6.friends newinfo;
by ID; 
drop = Donation Campaign; 
run; 
*PART C: report;
* sum of total donations by id; 
proc means noprint data=newinfo; 
var donation; by ID; 
output out=DonationSum SUM(donation) = Total_Donations; 
run; 

* merging total donations per id with FRIENDS table to create a report; 
data combined; 
merge friends DonationSum; by id; 
run; 
 
* printing the report; 

proc print data=combined LABEL; 
Var id FirstName LastName Total_Donations; 
run; 


