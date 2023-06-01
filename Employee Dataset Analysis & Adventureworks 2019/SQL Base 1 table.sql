create database Sequel_Trials;

use Sequel_Trials;

create table Student(
Student_ID int CONSTRAINT pk1_tb1 PRIMARY KEY,
F_Name varchar(50),
L_Name varchar(50),
);

create table ID_Card(
Student_ID int not null CONSTRAINT fk1_tb1 FOREIGN KEY REFERENCES Student(Student_ID),
Name varchar(50)
);

select * from Student;
select * from ID_Card;

create table Course_Term(
Course_ID int not null CONSTRAINT fk2_tb4 FOREIGN KEY REFERENCES Course(Course_ID),
Term_ID int not null CONSTRAINT pk3_tb4 PRIMARY KEY,
Start_Date Date,
End_Date Date,
);

create table Course(
Course_ID int CONSTRAINT pk2_tb3 PRIMARY KEY,
Course_Name varchar(50),
Course_Num int,
);

create table Term(
Term_ID int not null CONSTRAINT fk3_tb5 FOREIGN KEY REFERENCES Course_Term(Term_ID),
Section_Number int
);

create table Professor(
ProfID int not null CONSTRAINT pk3_tb6 PRIMARY KEY,
Name_List varchar(50),
Status_Check varchar(20)
);