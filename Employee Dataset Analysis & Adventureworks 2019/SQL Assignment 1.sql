--Databse Creation-------------------------------------

create database assignment_1;

-- Using Database-------------------------------------

use assignment_1;

--Creating Table Employee------------------------------


create table employee 
(
E_ID int IDENTITY(1000,1) not null primary key,
E_Name varchar(50) not null check(len(E_Name)<=50),
Gender char(2) not null,
M_ID int foreign key references employee(E_ID) default 'NULL',
Salary int check(Salary>0),
Dept varchar(20) not null,
);

-- Creating Table SalesPerson------------------------------

create table Sales_Person 
(
Sales_Person_ID int IDENTITY(1,1) not null primary key,
E_Name varchar(50) not null check(len(E_Name)<=50),
E_ID int not null foreign key references employee(E_ID),
Hire_Date date default 'NULL',
Region varchar(50) default 'NULL',
Sales_Value int not null check(Sales_Value>0),
P_Date date default 'NULL'
);

-- Creating Table Orders-----------------------------------

create table orders 
(
Order_ID int IDENTITY(1,1) not null unique,
Sales_Person_ID int foreign key references Sales_Person(Sales_Person_ID),
Order_Date date default 'NULL',
Order_Value int not null check(Order_Value>0),
Ship_Date date default 'NULL',
City varchar(50) check(len(City)<=50) default 'NULL'
);
