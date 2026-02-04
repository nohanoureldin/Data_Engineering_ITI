create database Course_Center

use Course_Center;
create table Instructor (
    ID int identity(1,1) primary key,
    First_name varchar(50),
    Last_name varchar(50),
    Birth_date date,
	Age as (year(getdate()) - year(Birth_date)),
    Overtime int unique,
    Salary int
		check (Salary between 1000 and 3000)
		default 3000,	
	NetSalary as (Salary + Overtime),
    Hiredate date
		default getdate(),
    Address varchar(100)
)

create table Course(
	CID int identity(1,1) primary key,
	Cname varchar(50),
	Duration time unique
)

create table Ins_Teach(
	Ins_ID int,
	CID int,
	Duration time,

	foreign key (Ins_ID) references Instructor(ID)
		on delete cascade
		on update cascade,
	foreign key (CID) references Course(CID)
		on delete cascade
		on update cascade
)

create table Lab(
	LID int identity(1,1) primary key,
	Location varchar(100),
	Capacity int
		check (Capacity <= 20),
	CID int,

	foreign key (CID) references Course(CID)
		on delete cascade
		on update cascade
)