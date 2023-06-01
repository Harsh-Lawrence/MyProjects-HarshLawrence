create database sequel_Class;

create table Names 
(
First_Name varchar(50),
Middle_Name varchar(50),
Last_Name varchar(50)
);

select * from Names;

alter table Names
add constraint ck_01 check(len(First_Name)<50);

alter table Names
add constraint ck_02 check(len(Middle_Name)<50);

alter table Names
add constraint ck_03 check(len(Last_Name)<50);

alter table Names
add constraint ck_04 check((len(First_Name)+len(Middle_Name)+len(Last_Name))<50);