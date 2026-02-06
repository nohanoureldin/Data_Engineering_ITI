-- lab day 7
-- 1. Create a view that displays student full name, course name if the
-- student has a grade more than 50.
use ITI
drop view if exists vstudentwithcoursewithgrade

create view vstudentwithcoursewithgrade
as
select CONCAT(s.St_Fname,' ', s.St_Lname) as FullName, c.Crs_Name
from Student s
join Stud_Course sc
on s.St_Id = sc.St_Id join Course c
on sc.Crs_Id = c.Crs_Id
where sc.Grade > 50
select * from vstudentwithcoursewithgrade

--2. Create an Encrypted view that displays manager names and the topics
-- they teach.
create view vmanagerandtopicss
with encryption
as
select i.ins_name as ManagerName, t.Top_Name as TopicName
from Department d join Instructor i
on d.Dept_Manager = i.Dept_Id
join Ins_Course ic
on i.Ins_Id = ic.Ins_Id
join course c
on ic.Crs_Id = c.Crs_Id
join Topic t
on c.Top_Id = t.Top_Id

select * from vmanagerandtopicss
sp_helptext 'vmanagerandtopicss'

--3. Create a view that will display Instructor Name, Department Name for
-- the ‘SD’ or ‘Java’ Department
create view vinstructoranddepartment
as
select  i.Ins_Name, d.Dept_Name
from Instructor i join Department d
on i.Dept_Id = d.Dept_Id
where d.Dept_Name in ('SD','Java')

select * from vinstructoranddepartment

-- 4. Create a view “V1” that displays student data for student who lives in
-- Alex or Cairo.
-- Note: Prevent the users to run the following query
-- Update V1 set st_address=’tanta’
-- Where st_address=’alex’
create view V1
as
select *
from Student
where St_Address in('Alex', 'Cairo')
with check option 

update v1
set st_address = 'tanta'
where st_address = 'alex'

--.5 Create a view that will display the project name and the number of
-- employees work on it. “Use Company DB”
use Company_SD
create view vprojectandworksforandemployee
as
select p.pname, count(w.essn) as emp_count
from project p left join Works_for w
on p.pnumber = w.pno
group by p.pname
select * from vprojectandworksforandemployee

-- 6. Create the following schema and transfer the following tables to it
--a. Company Schema
--i. Department table (Programmatically)
--ii. Project table (visually)
--b. Human Resource Schema
--i. Employee table (Programmatically)
create schema company
create table company.department
(dnum int primary key,
dname varchar(50),
mgrssn int,
mgrstartdate date
)

create schema HumanResource
create table HumanResource.department
(ssn int primary key,
	fname varchar(50),
	lname varchar(50),
	bdate date,
	address varchar(100),
	sex char(1),
	salary int,
	superssn int,
	dno int
)

--7 7. Create index on column (Hiredate) that allow u to cluster the data in
-- table Department. What will happen?
alter table company.department
add hiredate date

create clustered index idepartmenthiredate
on company.department(hiredate)

create nonclustered index idepartmenthiredate
on company.department(hiredate)

sp_helpindex 'company.department'

--8. Create index that allow u to enter unique ages in student table. What will
-- happen?
use ITI
create unique index idxstudentage
on student(st_age)

insert into student (st_id, st_fname, st_age)
values (1,'ahmed', 22)

insert into student (st_id, st_fname, st_age)
values (2,'ali', 22)

-- 9. Create a cursor for Employee table that increases Employee salary by
-- 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use
-- company DB
use Company_SD
declare salary cursor 
for
select salary from employee 
for update
declare @salary decimal(10,2)
open salary
fetch salary into @salary
while @@fetch_status = 0
begin
if @salary < 3000
update employee
set salary = salary * 1.10
where current of salary
else
update employee
set salary = salary * 1.20
where current of salary
fetch salary into @salary
end

close salary
deallocate salary

--10.Display Department name with its manager name using cursor. Use ITI
declare DeptDetails cursor
for select Dept_Name , Ins_Name 
from Department join instructor
on Department.Dept_Manager = instructor.Ins_Id
for read only
declare @deptName nvarchar(50), @managName nvarchar(50)
open DeptDetails
fetch DeptDetails into @deptName , @managName
while @@FETCH_STATUS = 0 
begin
select @deptName as 'Department Name' , @managName as 'Manager'
fetch DeptDetails into @deptName, @managName
end
close DeptDetails
deallocate DeptDetails

--11. Try to display all students first name in one cell separated by comma. 
--Using Cursor 

declare InsName cursor
for select Ins_Name from instructor
for read only
declare @Name varchar(20) , @allNames nvarchar(1000)
open InsName
fetch InsName into @Name
while @@FETCH_STATUS =0 
begin
set @allNames = CONCAT(@allNames,', ',@Name)
fetch InsName into @Name
end
select @allNames
close InsName
deallocate InsName



--12. Try to generate script from DB ITI that describes all tables and views in 
--this DB 



--13. Try Sql Profiler and track query executed 
	

