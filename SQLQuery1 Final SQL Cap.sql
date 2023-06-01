create database FinalCapstonetrial;
use FinalCapstonetrial;

create table SuperMarketSales(
Invoice_ID varchar(50) primary key,
Branch varchar(5),
City varchar(25),
Customer varchar(30),
Gender varchar(25),
Product_Line varchar(100),
Unit_Price float,
Quantity int,
"Tax_5%" float,
Total float,
"Date" date,
"Time" time,
Payments varchar(30),
cogs float,
gross_margin float,
gross_income float,
Rating float
);

select * from SuperMarketSales;
select * from supermarket;



select COUNT("Invoice ID") , "Product line" from supermarket_salesUpload group by "Product line" order by COUNT("Invoice ID") desc;

select * from 
(select COUNT("Invoice ID"), "Product line" , "City" , DENSE_RANK() over(partition by City,"Product line" order by count("Invoice_ID") desc)Ranking
from supermarket_salesUpload );


select * from 
(select COUNT("Invoice_ID") , "Product line" , "Customer type" , DENSE_RANK() over ( partition by City order by "Invoice ID")"Ranking" from supermarket_salesUpload );


SELECT "Invoice ID", DENSE_RANK() OVER (PARTITION BY city ORDER BY count("Invoice ID") DESC) as dense_rank
FROM supermarket_salesUpload;


select * from (select a.Employee_Name ,a.salary,b.deptname, DENSE_RANK() over(partition by b.deptno order by Salary desc) Ranking
	from supermarket_salesUpload ) ;

	select COUNT("Invoice ID") , "City" from supermarket_salesUpload group by "City" order by COUNT("Invoice ID") desc;


	SELECT COUNT("Invoice ID"), city, "Product line", DENSE_RANK() OVER (PARTITION BY city,"Product Line" ORDER BY sales DESC) as dense_rank
FROM supermarket_salesUpload;


select count("Invoice ID" ), Payment from supermarket_salesUpload group by Payment order by COUNT("Invoice ID") desc;
select * from supermarket;


select "Invoice ID", Rating, cogs from supermarket where cogs in(select top(10) cogs from supermarket order by cogs desc);

																																																																										

declare @AOR float
declare @AOT float
set @AOR = (select AVG(CONVERT(float,rating)) from supermarket)
set @AOT = (select AVG(convert(float,total)) from supermarket)
select  ("Invoice ID") ,city , "Product line", CONVERT(float,rating) as Rating , convert(float,total) as Total from supermarket
where convert(float,rating) > @AOR and convert(float,total) >@AOT
order by rating desc;
 select MAX("unit price") from supermarket;

declare @AOR float
declare @AOT float
set @AOR = (select AVG(CONVERT(float,rating)) from supermarket)
set @AOT = (select AVG(convert(float,total)) from supermarket)
select  count("Invoice ID") ,city , "Product line" from supermarket
where convert(float,rating) > @AOR and convert(float,total) >@AOT
group by city
order by rating desc;

declare @R1 float
declare @R2 float
declare @R3 float
declare @R4 float
set @R1 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 0 and 25))
set @R2 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 26 and 50))
set @R3 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 51 and 75))
set @R4 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 76 and 100))
select @R1 as "Unit Price between 0-25", @R2 as "Unit Price between 25-50" ,@R3 as "Unit Price between 50-75", @R4 as "Unit Price between 75-100"



declare @Q1 float
declare @Q2 float
declare @Q3 float
declare @Q4 float
set @Q1 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 0 and 2.5))
set @Q2 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 2.6 and 5.0))
set @Q3 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 5.1 and 7.5))
set @Q4 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 7.6 and 10.0))
select @Q1 as "Rating between 0-2.5", @Q2 as "Rating between 2.6-5.0" ,@Q3 as "Rating between 5.1-7.5", @Q4 as "Rating between 7.6-10.0"

select * from supermarket;

select sum(convert(float,total)) as "Sum of Total" , "Product line" from supermarket group by "Product line" order by sum(convert(float,total)) desc;

select count("Invoice ID") from supermarket  group by City having convert(float,rating) > AVG(CONVERT(float,rating)) and convert(float,total) >AVG(convert(float,total));

declare @P1 float
declare @P2 float
declare @P3 float
declare @P4 float
set @P1= (select SUM(CONVERT(float,"Quantity")) from supermarket where (CONVERT(float,"Quantity") >50))
select @P1;





##################################### Working Codes ########################################

#############trend by city
//
select COUNT("Invoice ID") as "Number of Invoices" , "City" from supermarket group by "City" order by COUNT("Invoice ID") desc;

########### trend by product line
//
select COUNT("Invoice ID") as "Number of Invoices" , "Product line" from supermarket group by "Product line" order by COUNT("Invoice ID") desc;

############Trend(by city and product line)
//
select count("Invoice ID" )as "Number of Customers", City, "Product line" from supermarket group by "Product line","City" order by COUNT("Invoice ID") desc;

#############Customer and their payment method

select count("Invoice ID" )as "Number of Customers", Payment as "Payment Method" from supermarket group by Payment order by COUNT("Invoice ID") desc;

#############Top 10 cogs with rating and ID

select "Invoice ID", Rating, cogs from supermarket where cogs in(select top(10) cogs from supermarket order by cogs desc);

############### Top 50 customers who spent the most money

select "Invoice ID", Gender ,"Customer Type" , City ,  total from supermarket where total in (select top(50) total from supermarket order by total desc) ;


############# Customer division by unit price range	

declare @R1 float
declare @R2 float
declare @R3 float
declare @R4 float
set @R1 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 0 and 25))
set @R2 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 26 and 50))
set @R3 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 51 and 75))
set @R4 = (select COUNT("Invoice ID") from supermarket where (convert(float,"unit price") between 76 and 100))
select @R1 as "Unit Price between 0-25", @R2 as "Unit Price between 25-50" ,@R3 as "Unit Price between 50-75", @R4 as "Unit Price between 75-100";

############ Customers with Highest Rating and are above 500 Total 

declare @AOR float
declare @AOT float
set @AOR = (select AVG(CONVERT(float,rating)) from supermarket)
set @AOT = (select AVG(convert(float,total)) from supermarket)
select  ("Invoice ID") ,city , "Product line", CONVERT(float,rating) as Rating , convert(float,total) as Total from supermarket
where convert(float,rating) > @AOR and convert(float,total) >@AOT
order by rating desc;



##########Customers by City and Gender

select COUNT("Invoice ID") as "Count from every Product line" , "City" , "gender" from supermarket group by "City","gender" order by COUNT("Invoice ID") desc;


######## Sum  of Purchase done city wise by gender division

select sum(convert(float,total)) as "Sum of Total" , "City" , "gender" from supermarket group by "City","gender" order by sum(convert(float,total)) desc;


######## Total of Total Between all Ratings of division between every 2.5 rating

declare @Q1 float
declare @Q2 float
declare @Q3 float
declare @Q4 float
set @Q1 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 0 and 2.5))
set @Q2 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 2.6 and 5.0))
set @Q3 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 5.1 and 7.5))
set @Q4 = (select sum(convert(float,"Total")) from supermarket where (convert(float,"rating") between 7.6 and 10.0))
select @Q1 as "Rating between 0-2.5", @Q2 as "Rating between 2.6-5.0" ,@Q3 as "Rating between 5.1-7.5", @Q4 as "Rating between 7.6-10.0"

################ Sales trend according to product line

select sum(convert(float,total)) as "Sum of Total" , "Product line" from supermarket group by "Product line" order by sum(convert(float,total)) desc;