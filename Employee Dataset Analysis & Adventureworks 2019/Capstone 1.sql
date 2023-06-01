create database Capstone_1;

Use Capstone_1;

create table Employee
(
Employee_ID int IDENTITY(1000,1) not null primary key,
Employee_Name varchar(50) not null check(len(Employee_Name)<=50),
Gender char(2) not null,
M_ID int foreign key references employee(Employee_ID) default 'NULL',
Salary int check(Salary>0),
Deptno int not null,
);

drop table Employee;


select * from Employee;


create table Department 
(
Deptno int not null primary key,
DeptName varchar(20) ,
City varchar(20) check(City IN('NOIDA','DELHI' ,'LUCKNOW'))
);


alter table Employee
add constraint FK_01 foreign key(Deptno) references Department(Deptno);

select *from Department;

alter table Employee
add EMAIL varchar(30) check(EMAIL like '%_@__%.__%') default 'NA';

select * from Employee;

alter table Employee
drop constraint FK_01;


alter table Department
drop constraint PK__Departme__0149C6869243A674;

alter table Department
drop constraint [CK__Department__City__30F848ED];

exec sp_rename 'Department.City','Location','Column';


alter table Department
add constraint PK_DEPT primary key(DeptNo);

alter table Department
add constraint CK_Location check([Location] IN('NOIDA','DELHI' ,'LUCKNOW'));

alter table Employee
add constraint FK_01 foreign key(Deptno) references Department(Deptno);


insert into Employee values
(1,'LINDA','F',10,null,75000),
(2,'MARY','F',10,1,40000),
(3,'ANJELA','F',10,2,32000),
(4,'JASON','M',20,1,50000),
(5,'AHMED','M',20,4,30000),
(6,'MARIA','F',20,4,40000),
(7,'JOHN','M',30,1,60000),
(8,'JACK','M',30,7,55000),
(9,'JUNE','F',30,7,40000),
(10,'OLA','M',30,8,35000);

insert into Employee values
('LINDA','F',10,null,75000),
('MARY','F',10,1,40000),
('ANJELA','F',10,2,32000),
('JASON','M',20,1,50000),
('AHMED','M',20,4,30000),
('MARIA','F',20,4,40000),
('JOHN','M',30,1,60000),
('JACK','M',30,7,55000),
('JUNE','F',30,7,40000),
('OLA','M',30,8,35000);

insert into Employee values
(1,'LINDA','F',null,75000,10);
('MARY','F',1,40000,10),
('ANGELA','F',2,32000,20);


create table Employee
(
Employee_ID int IDENTITY(1000,1) not null primary key,
Employee_Name varchar(50) not null check(len(Employee_Name)<=50),
Gender char(2) not null,
M_ID int foreign key references employee(Employee_ID) default 'NULL',
Salary int check(Salary>0),
Deptno int not null,
);

ALTER TABLE Employee
ALTER COLUMN Employee_ID int not null;

ALTER TABLE Employee
ALTER COLUMN Gender varchar(2) not null;

ALTER DATABASE SCOPED CONFIGURATION 
  SET VERBOSE_TRUNCATION_WARNINGS = ON;

  insert into Employee(Employee_ID,Employee_Name,Gender,M_ID,Salary,Deptno)
  values
(1,'LINDA','F',null,75000,10);
