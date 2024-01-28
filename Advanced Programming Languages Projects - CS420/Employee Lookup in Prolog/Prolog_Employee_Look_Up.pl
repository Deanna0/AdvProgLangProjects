


% Predicate to read data from a CSV 
:- use_module(library(csv)).

% Predicate to read data from a CSV file and store it as rules
read_csv_and_store(Filename) :-
        csv_read_file(Filename, Rows, []),
        process_rows(Rows).

% Process each row in the CSV file and store data as rules
process_rows([]).
process_rows([Row|Rows]) :-
        process_row(Row),
        process_rows(Rows).

%%%%% TASK 2 %%%%%%
% Store data from a row as a rule
process_row(row(EEID, Name, Job, Department, Business, Gender, Ethnicity, Age, Hire, Salary, Bonus, Country, City, Exit)) :-
        assert(employee(EEID, Name, Job, Department, Business, Gender, Ethnicity, Age, Hire, Salary, Bonus, Country, City, Exit)).

% Determine if an Employee is working in Seattle
is_seattle_employee(Name) :-
        employee(_,Name,_,_,_,_,_,_,_,_,_,_,'Seattle',_).

% Problem 2
is_senior_manager_in_IT(Name) :-
	employee(_,Name,'Sr. Manager','IT',_,_,_,_,_,_,_,_,_,_);
	employee(_,Name,'Sr. Manger','IT',_,_,_,_,_,_,_,_,_,_).

% Determine if an Employee is a director in the finance department and works in miami
is_director_finance_miami(Name) :-
	employee(_,Name,'Director','Finance',_,_,_,_,_,_,_,_,'Miami',_).

% Determine if an Employee is from the US, works in manufacturing, older than 4-, Asian & Male
is_asian_US_manufacturing_40M(Name, Business, Gender, Ethnicity, Age) :-
	employee(_,Name,_,_,Business,Gender,Ethnicity,Age,_,_,_,'United States',_,_),
	% grabs information from employee and matches them to see if the equal the requirements below
	Business = 'Manufacturing',
	Gender = 'Male',
	Ethnicity = 'Asian',
	Age > 40.

% Greets an Employee by stating their Name, Job Title, Department, & Business unit
greet(EEID) :-
	employee(EEID,Name,Department,Job,Business,_,_,_,_,_,_,_,_,_),
	% writes a greeting message of "Hello, NAME, DEPARTMENT of JOB, BUSINESS" depending on the employee's information
	write('Hello, '),
	write(Name),
	write(', '),
	write(Department),
	write(' of '),
	write(Job),
	write(', '),
	write(Business). 

% 6. Computes years until retirement. Assumes retirement age is 65
years_until_retirement(Name,Age,Years_to_retire) :-
	employee(_,Name,_,_,_,_,_,Age,_,_,_,_,_,_),
	% grabs information from employee and matches them to see if the equal the requirements below
	RetirementAge = 65,
	Years_to_retire is RetirementAge - Age.

% 7. Determines Research & Developement employees with Black Ethnicity within the ages of 25 to 50
is_rd_black_midAge(Name, Business, Ethnicity, Age) :-
	employee(_,Name,_,_,Business,_,Ethnicity,Age,_,_,_,_,_,_),
	% grabs information from employee and matches them to see if the equal the requirements below
	Business = 'Research & Development',
	Ethnicity = 'Black',
	Age >= 25,
	Age =< 50.

% 8. Determine if an Employee is from IT or Finance and from Pheonix or Miami or Austin
is_ITorFin_PHXorMIAorAUS(Name, Department, City) :-
	employee(_,Name,_,Department,_,_,_,_,_,_,_,_,City,_),
	(Department = 'IT'; Department = 'Finance'), % if the Department = IT or Finance the first check is true & can move onto the second check
	(City = 'Phoenix'; City = 'Miami'; City = 'Austin'). % if City = Phoenix or Miami or Austin then second check is true which means this employee fulfills all the requirements

% 9. Determine if a female employee is in a senior role
is_female_senior_role(Name, Job) :-
	employee(_,Name,Job,_,_,'Female',_,_,_,_,_,_,_,_),
	atom_concat(L,_,Job), % splits atom apart
	L = 'Sr.'. % if Sr. was successfully separated then this statement will be true

% 10. Determine if an employee is a highly paid senior manager. They make over $120,000
is_highly_paid_senior_manager(Name, Salary) :-
	employee(_,Name,_,_,_,_,_,_,_,Salary,_,_,_,_),
	normalize_space(string(X), Salary),
	% '$999,999 ' == "$999,999"
	split_string(X,",","$",L),
	% "$999,999" == ["999", "999"]
	nth0(0,L,A),
	nth0(1,L,B),
	string_concat(A,B,Num),
	% ["999","999"] = "999999"
	string_to_atom(Num, Number),
	% "999999" == '999999'
	atom_number(Number,Int),
	%'999999' == 999999
	Int >= 120000.

%%%%% Task 3 %%%%%%%%

% 11. Determine if an employee's age is a prime number
is_prime_age(Name, Age) :-
	employee(_,Name,_,_,_,_,_,Age,_,_,_,_,_,_),
	not(prime(Age,2))

prime(Age,Count) :-
	N is Count * Count,
	N =< Age,
	Age mod Count =:= 0.

prime(Age,Count) :-
	Count < Age,
	CountNext is Count + 1,
	prime(Age,CountNext).

%Problem 12
average_salary(Job_Title, Salary) :-
	distinct(Job_Title,employee(_,_,Job_Title,_,_,_,_,_,_,_,_,_,_,_)), % 
	findall(Salaryy,employee(_,_,Job_Title,_,_,_,_,_,_,Salaryy,_,_,_,_), L), % finds all salaries of a specific job title and inputs those values into L 
	sumList(L,0, Summm), % adds all salaries of a particular job_title together 
	length(L, NumOfEmployees), % gets the number of employees per job title
	Salary is Summm / NumOfEmployees. % Salary = total amount of money per each job title / # of employees for said job title
sumList([],Summm,Summm):- % base case when you get to the end of the list
	Summm is Summm + 0.
sumList([H|T], Acc, Summm) :- % recursive part of adding all the salaries together
	num(H,HInt), % converts the string version of a salary to a number 
	NewAcc is HInt + Acc, % Accumulator value is the thing that adds the salaries together per jobtitle 
	sumList(T,NewAcc,Summm).
num(H,HInt) :- 
	normalize_space(string(X),H), 
	split_string(X,",","$",L), % splits the string at ',' & '$' 
	nth0(0,L,A), % grabs first half of the number xxx,
	nth0(1,L,B), % grabs second half of the number ,xxx
	string_concat(A,B,Num), % concats both halves together to get one number
	string_to_atom(Num, Number), % turns string into an atom
	atom_number(Number,Int), % turns atom into num
	HInt = Int.

% Problem 13
total_salary(Name,Salary) :-
	employee(_,Name,_,_,_,_,_,_,_,AnnualSalary,Bonus,_,_,_),
	percent(Bonus,NumBonus),
	numm(AnnualSalary,Salaryyy),
	X is NumBonus * (1 / 100),
	Y is Salaryyy * X,
	Z is Salaryyy + Y,
	Salary = Z.

numm(AnnualSalary, Salaryyy) :-
	normalize_space(string(X),AnnualSalary),
	split_string(X,",","$",L),
	nth0(0,L,A),
	nth0(1,L,B),
	string_concat(A,B,Num),
	string_to_atom(Num, Number),
	atom_number(Number,Int),
	Salaryyy = Int.

percent(Bonus, NumBonus) :-
	normalize_space(string(X),Bonus),
	split_string(X,"%","%",L),
	nth0(0,L,A),
	string_to_atom(A,Number),
	atom_number(Number,Int),
	NumBonus = Int.	

% Problem 14
takehome_salary(Name, Job_Title, Take_home_salary) :-
	employee(_,Name,Job_Title,_,_,_,_,_,_,_,_,_,_,_),
	total_salary(Name,Salary),
	tax(Salary,Take),
	Take_home_salary = Take.

tax(Salary,Take_home_salary) :-
	Salary < 50000,
	Take_home_salary is Salary - (Salary * (20 / 100)).

tax(Salary,Take_home_salary) :-
        Salary > 50000,
	Salary < 100000,
        Take_home_salary is Salary - (Salary * (25 / 100)).

tax(Salary,Take_home_salary) :-
        Salary > 100000,
	Salary < 200000,
        Take_home_salary is Salary - (Salary * (30 / 100)).

tax(Salary,Take_home_salary) :-
        Salary > 200000,
        Take_home_salary is Salary - (Salary * (35 / 100)).

% 15. Determine years of service at the company
total_years(Name,Years) :-
	employee(_,Name,_,_,_,_,_,_,Hire,_,_,_,_,Exit),
	%% Hire year string to number %%
	split_string(Hire, "/", "", HirePart), % breaks apart the hire date
	nth0(2, HirePart, HireYearsString), % takes the year from the string and gives it to HireYearString
	atom_number(HireYearsString, HireYear), % converts the hire year string to a number called HireYear
	%% Exit year string to number %%
	(Exit = "" ->
		split_string(Exit, "/", "", ExitPart),
		nth0(2, ExitPart, ExitYearsString),
		atom_number(ExitYearsString, ExitYear)
		
	;
		ExitYear is 0
	),

	%% Determining years of service %%
	CurrentDate is 2023, % standard date to compare given dates too

	TempHire is HireYear + 2000, % Ex 1. HireYear = 99 -> TempHire = 2099, thats >=  current date so employee's hire date is 1999
				     % Ex 2. HireYear = 01 -> TempHire = 2001, thats =< current date so employee's hire date is 2001 
	(TempHire > CurrentDate -> 
		AdjHire is HireYear + 1900
	;
		AdjHire is TempHire
	),	
	
	(ExitYear = 0 ->
		Years is CurrentDate - AdjHire % if the same year has been found just subtract the current year from the Adjhire date 
	;
		TempExit is ExitYear + 2000, % adjusting the Exit Year's date from the spread sheet by adding 2000
		(TempExit > 2023 -> % if the TempExit year is greater than the current year then this person exited in 19XX rather than 20XX (look to tempHire for an example, TempExit works the same)
			AdjExit is ExitYear + 1900
		;
			AdjExit is TempExit
		),
		
		Years is abs(AdjExit - AdjHire) % get the # of years from the Adjusted Dates 
	).
	 
