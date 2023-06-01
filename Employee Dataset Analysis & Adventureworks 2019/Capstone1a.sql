create database Capstone_1a;

Use Capstone_1a;

create table Employee
(
Employee_ID int not null primary key,
Employee_Name varchar(50) not null check(len(Employee_Name)<=50),
Gender char(2) not null,
M_ID int foreign key references employee(Employee_ID) default 'NULL',
Salary int check(Salary>0),
Deptno int not null,
);


create table Department 
(
Deptno int not null primary key,
DeptName varchar(20) ,
City varchar(20) check(City IN('NOIDA','DELHI' ,'LUCKNOW'))
);

alter table Employee
add constraint FK_01 foreign key(Deptno) references Department(Deptno);

alter table Employee
add EMAIL varchar(30) check(EMAIL like '%_@__%.__%') default 'NA';

alter table Employee
drop constraint FK_01;


alter table Department
drop constraint PK__Departme__0149C68697965EBA;

alter table Department
drop constraint [CK__Department__City__2A4B4B5E]

exec sp_rename 'Department.City','Location','Column';

alter table Department
add constraint PK_DEPT primary key(DeptNo);

alter table Department
add constraint CK_Location check([Location] IN('NOIDA','DELHI' ,'LUCKNOW'));

alter table Employee
add constraint FK_01 foreign key(Deptno) references Department(Deptno);

insert into Employee(Employee_ID,Employee_Name,Gender,M_ID,Salary,Deptno) values
(1,'LINDA','F',null,75000,10,);

ALTER TABLE Employee
ALTER COLUMN Employee_ID int not null;

ALTER TABLE Employee
ALTER COLUMN Gender varchar(2) not null;

select * from Employee;


insert into Employee
(Employee_ID,Employee_Name,Gender,M_ID,Salary,Deptno,EMAIL)
values
(1,'LINDA','F',null,75000,10,'linda@gmail.com');

insert into Department values
(10,'SALES','noida'),(20,'IT','noida'),(30,'FINANCE','lucknow'),(40,'MARKETING','delhi');

insert into Employee
(Employee_ID,Employee_Name,Gender,M_ID,Salary,Deptno,EMAIL)
values
(2,'MARY','F',1,40000,10,'mary@gmail.com'),
(3,'ANGELA','F',2,32000,10,'angela@gmail.com'),
(4,'JASON','M',1,50000,20,'jason@gmail.com'),
(5,'AHMED','M',4,30000,20,'ahmed@gmail.com'),
(6,'MARIA','F',4,40000,20,'maria@gmail.com'),
(7,'JOHN','M',1,60000,30,'john@gmail.com'),
(8,'JACK','M',7,55000,30,'jack@gmail.com'),
(9,'JUNE','F',7,40000,30,'june@gmail.com'),
(10,'OLA','F',8,35000,30,'ola@gmail.com');


select * from Employee;
select * from Department;


select employee_name from employee 
where RIGHT(employee_name,1) =LEFT(Employee_Name,1);


declare @Sname varchar(20),@Lname int
set @Sname=(select Employee_name from Employee where Employee_ID=5)
set @Lname=LEN(@Sname)
select employee_name from employee
where LEN(employee_name)>@Lname;




SELECT STRING_AGG (CONVERT(NVARCHAR(max),Employee_Name), ',') AS Comma_Seperated_Names
FROM Employee;


select employee_name , CONCAT(left(employee_name,1) ,right(employee_name,1))'Concat'
from employee;

select COUNT(employee_id)'No of Employee in Location' from Employee a
left join Department b
on a.Deptno = b.deptno
where [location] = 'lucknow';


select * from Employee a
left join Department b
on a.Deptno = b.deptno;

select sum(salary),a.Deptno from Employee a
left join Department b
on a.Deptno = b.deptno
group by a.Deptno ;


select a.Deptno, min(salary)'Min Sal By Dept',MAX(salary)'Max Salary by Dept' from Employee a
left join Department b
on a.Deptno = b.deptno
group by a.Deptno ;

select sum(salary)'Salary By Gender',a.Gender from Employee a
left join Department b
on a.Deptno = b.deptno
group by a.Gender;

declare @AOMD int
set @AOMD = (select AVG(a.salary) from Employee a left join Department b on a.Deptno=b.Deptno where DeptName='Marketing')
select a.Employee_name , a.salary from Employee a
left join Department b
on a.Deptno=b.Deptno
where a.Salary>@AOMD;

declare @Average_Of_M_Dept int
set @Average_Of_M_Dept = (select a.salary from Employee a left join Department b on a.Deptno=b.Deptno where b.DeptName='Marketing')          ----DOUBT
select c.employee_name , c.salary from Employee c 
left join Department d
on c.Deptno=d.Deptno
where c.salary>=@Average_Of_M_Dept;


declare @COFD int
set @COFD = (select COUNT(a.Employee_ID) from Employee a left join Department b on a.Deptno=b.Deptno where b.DeptName='FINANCE')
select d.DeptName , COUNT(c.Employee_ID)'No of Employees in the Dept' from Employee c
left join Department d 
on c.Deptno=d.Deptno
group by Deptname
having COUNT(DeptName)>@COFD
;


create table Sales
(
[SID] int primary key,
sales money,
sdate date,
E_ID int
);


insert into Sales values
(101,4000,'2005-10-10',1),
(102,2300,'2006-01-12',1),
(103,9000,'2005-06-20',2),
(104,4500,'2007-02-10',2),
(105,3200,'2007-02-27',3),
(106,2100,'2008-05-25',3),
(107,6200,'2008-04-14',4),
(108,1900,'2009-10-24',4),
(109,9100,'2009-03-20',5),
(110,7600,'2010-12-12',5),
(111,8300,'2010-09-15',6),
(112,4800,'2010-06-23',6),
(113,3900,'2010-08-10',7),
(114,8100,'2010-11-14',7),
(115,4900,'2011-10-19',8),
(116,5000,'2011-04-20',8),
(117,8400,'2011-05-24',8),
(118,2700,'2011-10-12',9),
(119,7100,'2012-08-20',9),
(120,4100,'2012-03-15',9),
(121,2100,'2012-03-15',10),
(122,9300,'2012-09-15',10),
(123,9200,'2013-07-15',11),
(124,8300,'2013-03-15',11);


select * from Sales;
select * from Employee;
select * from Department;
drop table Sales;

alter table Sales
add constraint FK_S foreign key(Employee_ID) references Employee(Employee_ID);

alter table Sales 
rename column E_ID to Employee_Name;

exec sp_rename 'Sales.E_ID','Employee_ID','Column';

insert into Employee values
(11,'Nick','M',10,54000,20,'Nick@gmail.com');

alter table Sales
drop constraint [FK_S];

select distinct top 2 b.deptname , a.employee_name , a.Salary from Employee a
left join Department b
on a.Deptno=b.Deptno
right outer join  Sales c
on a.Employee_ID=c.Employee_ID
where b.DeptName='IT'
order by a.Salary desc;

	select distinct top 2 b.deptname , a.employee_name , a.Salary from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join  Sales c
	on a.Employee_ID=c.Employee_ID
	order by a.Salary desc;

	select distinct top 2 a.Employee_Name ,a.salary, DENSE_RANK() over(order by Salary desc)'Ranking By salary'
	from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join  Sales c
	on a.Employee_ID=c.Employee_ID
	where b.deptname = 'IT'
	order by Salary desc;
	

	select distinct a.Employee_Name , b.deptname  , a.salary,  DENSE_RANK() over(order by a.Salary desc)'Ranking By salary'
	from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join  Sales c
	on a.Employee_ID=c.Employee_ID
	group by b.Deptno
	having a.Salary in
	(select top 2 MAX(Salary) from Employee)
	 ;


	 select distinct a.Employee_Name , b.deptname  , a.salary
	 from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join Sales c
	on a.Employee_ID  = c.Employee_ID
	where a.Salary in
	(select MAX(a.Salary) from Sales  group by b.Deptno);

	select distinct a.employee_name , b.deptname,Salary from
	 employee a inner join department b
	 on a.deptno= b.deptno
	  inner join Sales c 
	 on a.Employee_ID=c.employee_id
	 where a.salary in
	 (select top 2 max(salary) from Employee)
	  group by b.deptno
	 order by Salary desc;
	
	 
	 select distinct top 2 a.employee_name , b.deptname,max(Salary) from
	 employee a inner join department b
	 on a.deptno= b.deptno
	  inner join Sales c 
	 on a.Employee_ID=c.employee_id
	 where a.salary in
	 (select top 2 max(salary) from Employee)

	 order by Salary desc

	 select distinct top 2  b.deptname,max(Salary) from
	 employee a inner join department b
	 on a.deptno= b.deptno
	  inner join Sales c 
	 on a.Employee_ID=c.employee_id
	 order by Salary desc;

	 
	select distinct a.Employee_Name ,a.salary,b.deptname, DENSE_RANK() over(order by Salary desc)'Ranking By salary'
	from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join  Sales c
	on a.Employee_ID=c.Employee_ID
	
	order by Salary desc;

	select * from (select a.Employee_Name ,a.salary,b.deptname, DENSE_RANK() over(partition by b.deptno order by Salary desc) Ranking
	from Employee a
	left join Department b
	on a.Deptno=b.Deptno) c
    where c.Ranking<=2;
	--group by (select DENSE_RANK()over(partition by b.deptno order by a.salary desc)

	select * from (select b.deptname,a.employee_name,b.deptno,salary,DENSE_RANK() over (partition by 


	select * from Sales;
select * from Employee;
select * from Department;

	select distinct b.deptname ,(select sum(sales) from sales c ) from 
	 employee a inner join department b
	 on a.deptno= b.deptno
	 
	 select * from (select a.Employee_Name ,a.salary,b.deptname, DENSE_RANK() over(partition by b.deptno order by Salary desc) Ranking
	from Employee a
	left join Department b
	on a.Deptno=b.Deptno) c
	
    where c.Ranking<=2;

	SELECT b.deptname, SUM(SALARY) 
FROM DEPARTMENT b
LEFT JOIN EMPLOYEE a ON a.Deptno=b.Deptno
GROUP BY b.Deptno
UNION 
SELECT 0 deptno, SUM(SALARY) SALARY
FROM EMPLOYEE

SELECT D.D_ID, SUM(E.SALARY) 
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.D_ID=E.D_ID
GROUP BY b.deptname
UNION 
SELECT 0 D_ID, SUM(SALARY) SALARY
FROM EMPLOYEE

SELECT b.dept, 
       SUM(SALARY) OVER (PARTITION BY D_ID) AS [Dept Salary], 
       SUM(SALARY) OVER () AS [Total Salary] 
FROM EMPLOYEE 

select distinct b.deptname ,sum(sales) over (partition by b.deptno order by b.deptno desc) as 'Total sales By Dept'from 
	 employee a join department b
	 on a.deptno= b.deptno
	join  Sales c
	on a.Employee_ID=c.Employee_ID
	

	select distinct sum(sales),DeptName from employee a
	join department b
	 on a.deptno= b.deptno
	 join  Sales c
	on a.Employee_ID=c.Employee_ID
	group by DeptName;

	select Employee_Name , s.sales  ,s.sdate
	from employee a inner join sales s
	on a.Employee_ID = s.Employee_ID
	where datepart(M,s.sdate)=10;

	SELECT E.first_name AS "Employee Name",
   M.first_name AS "Manager"
    FROM employees E 
      LEFT OUTER JOIN employees M
       ON E.manager_id = M.employee_id;


	   SELECT m.Employee_Name as 'Manager Name', e.Employee_Name AS "Employee Name"
    FROM employee E 
      right JOIN employee M
       ON e.m_id = m.Employee_ID;
	   select * from Employee;


	   select * from Sales;
select * from Employee;
select * from Department;

    select * from Employee a
	left join Department b
	on a.Deptno=b.Deptno
	right outer join  Sales c
	on a.Employee_ID=c.Employee_ID
	
		select Employee_Name , s.sales 
		from employee a inner join sales s
		on a.Employee_ID = s.Employee_ID
		where s.sales <=0;

		select * from (select distinct a.Employee_Name ,s.sales, DENSE_RANK() over( order by s.sales desc) Ranking
	from Employee a
	left join sales s
	on a.Employee_ID=s.employee_ID) c
    where c.Ranking<2;
	

	Create view [dbo].[sample01]
	with SCHEMABINDING
	as
	select a.Employee_Name,b.DeptName,a.Salary,b.Location
	from dbo.Employee a join dbo.Department b
	on a.Deptno=b.Deptno
	Go
	
	select * from sample01;

	
	select * from Employee;
	select SUSER_ID();
	select SUSER_NAME();
	select @@SPID as'Session ID';

	create table audit
	(
	Employee_ID int,
	Employee_Name varchar(50),
	Gender varchar(2),
	M_ID int,
	Salary int,
	Email varchar(50),
	[User_ID] int,
	[Username] varchar(50),
	[Time] datetime,
	[Session_ID] int
	);
	select * from audit;
	go

	create trigger A_F_I_E
	on Employee
	after insert
	as 
	begin
	declare @EID int;
	declare @Ename varchar(50);
	declare @Gen varchar(2);
	declare @MID int;
	declare @Sal int;
	declare @EM varchar(50);
	declare @U_ID varchar(50);
	declare @UName varchar(50);
	declare @timedate datetime;
	declare @S_ID int;
	
	set @EID=(select Employee_ID from inserted);
	set @Ename=(select Employee_Name from inserted);
	set @Gen=(select Gender from inserted);
	set @MID=(select M_ID from inserted);
	set @Sal=(select Salary from inserted);
	set @EM=(select EMAIL from inserted);
	set @U_ID =(select SUSER_ID());
	set @UName= (select SUSER_NAME());
	set @timedate =(select GETDATE());
	set @S_ID=(select @@SPID);


	insert into [audit] values 
	(@EID,@Ename,@Gen,@MID,@Sal,@EM,@U_ID,@UName,@timedate,@S_ID);
	end

	insert into Employee
(Employee_ID,Employee_Name,Gender,M_ID,Salary,Deptno,EMAIL)
values
(12,'JONAH','M',3,34000,20,'jonah@gmail.com');



select * from audit;go

create trigger U_F_I_E
	on Employee
	for update
	as 
	begin
	declare @EIDN int;
	declare @EIDO int;
	declare @EnameN varchar(50);
	declare @EnameO varchar(50);
	declare @GenN varchar(2);
	declare @GenO varchar(2);
	declare @MIDN int;
	declare @MIDO int;
	declare @SalN int;
	declare @SalO int;
	declare @EMN varchar(50);
	declare @EMO varchar(50);
	declare @U_ID varchar(50);
	declare @UName varchar(50);
	declare @timedate datetime;
	declare @S_ID int;
	
	set @EIDN=(select Employee_ID from inserted );
	set @EIDO=(select Employee_ID from deleted );
	set @EnameN=(select Employee_Name from inserted);
	set @EnameO=(select Employee_Name from deleted);
	set @GenN=(select Gender from inserted);
	set @GenO=(select Gender from deleted);
	set @MIDN=(select M_ID from inserted);
	set @MIDO=(select M_ID from deleted);
	set @SalN=(select Salary from inserted);
	set @SalO=(select Salary from deleted);
	set @EMN=(select EMAIL from inserted);
	set @EMO=(select EMAIL from deleted);
	set @U_ID =(select SUSER_ID());
	set @UName= (select SUSER_NAME());
	set @timedate =(select GETDATE());
	set @S_ID=(select @@SPID);

	if(@EIDO

	insert into [audit] values 
	(@EID,@Ename,@Gen,@MID,@Sal,@EM,@U_ID,@UName,@timedate,@S_ID);
	end
	go

	create trigger Up_F_I_E
	on Employee
	for update
	as 
	begin
	declare @EID int;
	declare @Ename varchar(50);
	declare @Gen varchar(2);
	declare @MID int;
	declare @Sal int;
	declare @EM varchar(50);
	declare @U_ID varchar(50);
	declare @UName varchar(50);
	declare @timedate datetime;
	declare @S_ID int;
	
	set @EID=(select Employee_ID from inserted);
	set @Ename=(select Employee_Name from inserted);
	set @Gen=(select Gender from inserted);
	set @MID=(select M_ID from inserted);
	set @Sal=(select Salary from inserted);
	set @EM=(select EMAIL from inserted);
	set @U_ID =(select SUSER_ID());
	set @UName= (select SUSER_NAME());
	set @timedate =(select GETDATE());
	set @S_ID=(select @@SPID);


	insert into [audit] values 
	(@EID,@Ename,@Gen,@MID,@Sal,@EM,@U_ID,@UName,@timedate,@S_ID);
	end
	update Employee set M_ID= 2 where Employee_ID=12;
	go
	create trigger D_F_I_E
	on Employee
	for delete
	as 
	begin
	declare @EID int;
	declare @Ename varchar(50);
	declare @Gen varchar(2);
	declare @MID int;
	declare @Sal int;
	declare @EM varchar(50);
	declare @U_ID varchar(50);
	declare @UName varchar(50);
	declare @timedate datetime;
	declare @S_ID int;
	
	set @EID=(select Employee_ID from deleted);
	set @Ename=(select Employee_Name from deleted);
	set @Gen=(select Gender from deleted);
	set @MID=(select M_ID from deleted);
	set @Sal=(select Salary from deleted);
	set @EM=(select EMAIL from deleted);
	set @U_ID =(select SUSER_ID());
	set @UName= (select SUSER_NAME());
	set @timedate =(select GETDATE());
	set @S_ID=(select @@SPID);


	insert into [audit] values 
	(@EID,@Ename,@Gen,@MID,@Sal,@EM,@U_ID,@UName,@timedate,@S_ID);
	end

	delete from Employee where Employee_ID=12;

	select * from audit;
	go

	Create Procedure Employee_Fetch(@EMP_IDin int,@MANIDout int output )
	as
	begin
	
	select a.Employee_Name, b.DeptName,a.EMAIL
	from employee a inner join department b
	on a.deptno=b.deptno
	where Employee_ID = @EMP_IDin 
	select @MANIDout=a.M_ID from employee a;
	
	end

	execute Employee_Fetch
	go

	alter Procedure Employee_Fetch(@EMP_IDin int,@MANIDout int output )
	as
	begin
	declare @manager int;
	select a.employee_ID,a.Employee_Name, b.DeptName,a.EMAIL
	from employee a inner join department b
	on a.deptno=b.deptno
	where Employee_ID = @EMP_IDin 
	select @manager=a.M_ID from employee a where Employee_ID =@EMP_IDin;
	set @MANIDout=@manager
	end

	declare @manager1 int
	exec Employee_Fetch @emp_IDin = 2,@MANIDout=@manager1 out
	print @manager1;
	 go


	 select * from Employee;
	 go

	 alter procedure Forlength(@EmplID int)
	 as 
	 begin
	 declare @lengthOfName int;
	 set @lengthofname = (select len(employee_name) from employee where employee_ID=@EmplID)

	 select employee_ID, employee_name,gender,salary,@lengthOfName as 'Length of Characters' from Employee where Employee_ID=@EmplID;
	 end

	 exec Forlength @EmplID = 2;
	 go

	 create function (@INvalue int)returns varchar(20)
	 as
	 begin
	 declare @SQUAREOF int;
	 end
	 go
	 CREATE FUNCTION DFUN
( @INvalue INT,@Val int )

RETURNS VARCHAR(50)

AS

BEGIN

   DECLARE @Switch varchar(50);
   DECLARE @VALU float;
   set @Val=@VALU
   IF @Switch ='P'
      SET @Switch = (select POWER(@VALU,2));
   ELSE 
      SET @Switch = (select EXP(@valu));
	  
   RETURN @switch;

END;
go
select dfun('p',4);
go


CREATE FUNCTION dt
( @in INT,@valu int,@pow int )

RETURNS VARCHAR(50)

AS

BEGIN

   DECLARE @inp int;
   declare @val int;
   declare @po int;
   set @inp=@in;
   set @po=@pow;
   set @val = (select POWER(@inp,@po));
   

   RETURN @val;

END;
use Capstone_1a;
go
select dbo.dt(2,1,3);
go


CREATE FUNCTION ndt
( @in INT )

RETURNS VARCHAR(50)

AS

BEGIN

   declare @val int;
   set @val = cast((select getdate())as int);
   

   RETURN @val;

END;

use Capstone_1a;
go
select dbo.ndt(1);
go




create procedure EMP_DETAILS(@BID varchar(max)
select
from


