--create view on adventure works employee,person and address table so that sensitive columns are hidden in views.                                                                   --Question__1------------


-- Selecting HumanResources.Employee-----------------                                                                                                                           

select * from HumanResources.Employee;

-- Selecting Person.Person---------------------------

select * from Person.Person;

-- Selecting Person.Address---------------------------

select *from Person.Address;

--Creating View for Sensitive Information on HumanResources.Employee------------------

create view View_HRE1
with encryption as
select BusinessEntityID , NationalIDNumber , OrganizationLevel , OrganizationNode , JobTitle , BirthDate , Gender 
from HumanResources.Employee;

--Verifying Data in the HumanResources.Employee View ---------------------------------
	
select * from View_HRE1;

--Creating View for Sensitive Information on Person.Person------------------

create view View_PP1
with encryption as
select BusinessEntityID , PersonType ,(Title+''+FirstName+''+MiddleName+''+LastName)FullName , EmailPromotion , AdditionalContactInfo
from Person.Person;

--Verifying Data in the HumanResources.Employee View ---------------------------------

select * from View_PP1;

--Creating View for Sensitive Information on Person.Person------------------

create view View_PA1
with encryption as
select AddressLine1 , AddressLine2 , City , StateProvinceID , PostalCode
from Person.Address;

--Verifying Data in the HumanResources.Employee View ---------------------------------

select * from View_PA1;


--Trying to write insert command and see if it possible or not.--------------------------------                                                                                         --Ques-2---------

insert into View_PA1 values
('ABC','DEF','XYZ',77,490006);

--Viewing inserted values into View PersonAdress -----------------------------------------------


select * from View_PA1 where AddressLine1 = 'ABC';

--Compare the performance difference between permanent table,table variable and temporary table                                                                                         --Ques--3--------



--Selecting the data from the original Table --------------------------------------------


select * from Sales.SalesOrderHeader;


--Inserting more than 10000 values into the New Temporary Table named #temp_SalesOrderHeader-----------------


select * into #temp_SalesOrderHeader from Sales.SalesOrderHeader where SalesOrderId Between 43650 AND 54563

--Checking the Values inserted into the new table #temp_SalesOrderHeader-----------------------------------


select * from #temp_SalesOrderHeader;


--Viewing the values in Sales.SalesPerson Table------------------------------------------------


select * from Sales.SalesPerson;


--Creating a Right Join to check performance from the the Temporary Table Temp_SalesOrderHeader---------------------------


select a.SalesOrderID , a.SalesOrderNumber , a.AccountNumber , b.BusinessEntityID , b.TerritoryID
from #temp_SalesOrderHeader a right join Sales.SalesPerson b
on a.TerritoryID=b.TerritoryID
order by b.TerritoryID;


--Creating a Right Join to check performance from the the Permanent Table Sales.SalesOrderHeader---------------------------


select a.SalesOrderID , a.SalesOrderNumber , a.AccountNumber , b.BusinessEntityID , b.TerritoryID
from Sales.SalesOrderHeader a right join Sales.SalesPerson b
on a.TerritoryID=b.TerritoryID
order by a.TerritoryID;


--Write CTE to find manager of employees.-------------------------- -----------------                                                                                               --Question-4----------

--Creating Table Name Employee_Manager-------------------------------


create table Employee_Manager
(
EmployeeID int not null,
[Name] varchar(50),
ManagerID int
);

--Inserting Values into Table Employee_Manager------------------------------

insert into Employee_Manager values
(1,'JB',Null),(2,'UB',Null),(3,'RK',1),(4,'KK',2),(5,'MG',3);

--Verifying data inserted into the Table Employee Manager----------------------------

select * from Employee_Manager;

--CTE to find the manager of employees----------------------------------------------

WITH Employee_CTE(employeeid,name,managerid) AS  
(  
   SELECT EmployeeID,[Name],ManagerID from Employee_Manager where employeeid=5  
   UNION ALL  
   SELECT e.employeeid,e.name,e.managerid  
   from Employee_Manager e   
   INNER JOIN Employee_CTE c
   ON e.employeeid = c.managerid  
)
SELECT * FROM Employee_CTE order by employeeid ; 