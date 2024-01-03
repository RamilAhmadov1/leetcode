
--drop table employees;
--drop table transactions;
--drop table loan_customer;
--drop table loan;
--drop table customer_Accounts;
--drop table customers;
--drop table accounts;
--drop table branches;
--drop table bank;

create table Bank(
bankno           varchar(25)  constraint banknorequired not null,
bankname         varchar(50)  constraint banknamerequired not null,
bankcode         char(15)     constraint bankcoderequired not null,
bankaddress      varchar(100) constraint bankaddressrequired not null,
bankemail        varchar(50)  constraint bankemailrequired not null,     
constraint BankPk primary key (bankno),
constraint UniqueBankEmail unique(bankemail));


create table Branches (
branchno        varchar(25)  constraint branchnorequired not null,
bankno          varchar(25),  
branchname      varchar(50)  constraint branchnamerequired not null,
branchphone     char(15)     constraint branchphonerequired  not null,  
branchaddress   varchar(50)  constraint branchaddressrequired  not null,
branchcity      varchar(25)  constraint branchcityrequired  not null,
branchemail     varchar(50)  constraint emailrequired not null, 
branchstate     char(10)     constraint branchstaterequired  not null,
constraint BranchesPk primary key (branchno),
constraint BankFk foreign key(bankno)references Bank,
constraint Uniquebranchemail Unique(branchemail));

create table Accounts(
accountno              varchar(30)  constraint accountnorequired not null,
branchno               varchar(25), 
accont_type            varchar(30)     constraint accont_typerequired not null,
account_bal            number(8,2) default 0,
account_open_date      date constraint account_open_date not null,
account_close_date     date, 
constraint AccountsPk primary key (accountno),
constraint BranchsFk  foreign key (branchno) references branches);

create table Customers (
custno             varchar(25)   constraint custnorequired not null,
branchno           varchar(25), 
custfirstname      varchar(50)   constraint custfirstnamerequired not null,
custlastname       varchar(50)   constraint custlastnamerequired not null,
custphone          varchar(20)   constraint custphonerequired not null,
custemail          varchar(50)   constraint custemailrequired not null,
custaddress        varchar(100),   
custcity           varchar(30),   
custstate          varchar(20),      
custzip            char(10),          
custdate_of_birth  date,          
custbal        number(8,2) default 0,
constraint CustomersPk primary key (custno),
constraint Customersbranchhfk foreign key(branchno)references branches,
constraint Uniquecustemail unique(custemail));

--intersection table between customer and account tables.
create table Customer_Accounts( 
custno     varchar(25),  
accountno  varchar(30), 
constraint Customer_AccountsPk primary key (custno, accountno),
constraint CustomersFk foreign key (custno) references customers on delete cascade,
constraint AccountsFk foreign key (accountno) references accounts on delete cascade);


create table Loan (
loanno         char(15), 
branchno        varchar(25),
loan_amount     number(8,2) default 0,
loan_startdate  date,
constraint Pkloan primary key(loanno),
constraint Fkbranches foreign key(branchno) references branches);


--intersection table between Customer and loan tables.
create table Loan_customer(
loanno   char(15),
custno   varchar(25),
constraint Loan_customerPk primary key(loanno, custno),
constraint loanfk foreign key (loanno) references Loan on delete cascade,
constraint LoanCustomersfk foreign key (custno) references customers on delete cascade);

create table Transactions (
transaction_no         char(15),
accountno              varchar(20), 
transaction_date       date,
transaction_amount     number(8,2) default 0,
constraint Transaction_noPk primary key(transaction_no),
constraint AccountFk foreign key (accountno) references accounts);


create table Employees (
empno             number(4) constraint empnorequired not null,
branchno          varchar(25),
empfirstname      varchar(50) constraint empfirstnamerequired not null,
emplastname       varchar(50)constraint emplastnamerequired not null,
empdate_of_birth  date,    
empgender         char(6) constraint empgenderrequired not null,
empemail          varchar(50)  constraint empemailrequired not null,  
empsalary         number(8,2),
emp_hire_date     date,   
constraint Pkemployees primary key (empno),
constraint FkEmployees foreign key (branchno) references branches,
constraint UniqueEmpEmail unique (empemail));



--Queries
/*selecting all the braches*/
select * from branches; 

/*elect customer number and customer name and show the branchname
for each customer*/
select branches.branchno, branchname, custno, custfirstname, custlastname
from branches, customers
where branches.branchno = customers.branchno;

/*select the customer name and loan number and show branches*/
select branches.branchno, custfirstname, custlastname, loanno
from loan, customers, branches
where branches.branchno = customers.branchno
and branches.branchno = loan.branchno;

/*select bank and branch and show the employees*/
select bankname, branchname, branchcity, empno, empfirstname, emplastname
from bank, branches, employees
where branches.branchno = employees.branchno;

/*SELECT THEBRANCHNAME, CUSTOMER NAME CUSTOMER CITY AND BALLANCE WITH JOIN OPERATOR STYLE*/
select BRANCHNAME, CUSTFIRSTNAME, CUSTLASTNAME, CUSTCITY, CUSTBAL
from BRANCHES JOIN CUSTOMERS
ON  branches.branchno = customers.branchno;









