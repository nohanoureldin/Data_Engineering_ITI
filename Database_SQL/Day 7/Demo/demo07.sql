-- index 
-- cursor 
-- view 
-------------------------------------------
create table emp 
(
ID int primary key,   -- create indexer clustered indexer
name varchar(50) 
)


--clustered -- sort in data page 
create clustered index ICrsName
on Course (crs_name)


-- B Tree names (names pages ranges pointers)
create nonclustered index ICrsName
on Course (crs_name)

-- 
-- try constaint unique on st_Age 
-- create index label unique
create unique index I4
on student (st_Age)


-- Azure service (fine tuning ) insights sql 
---------------------------------------------------------
-- cursor 
declare pointer cursor
for
	select St_Id,  st_fname from student 
for read only          -- detect behaviour 
declare @id int , @name varchar(50)    -- declare variables hold row datra 
open pointer
fetch pointer into @id , @name
while @@fetch_status = 0 
begin 
	select @id , @name 

	-- move forward 
	fetch pointer into @id , @name
end
close pointer 
deallocate pointer


-- loop result on instruccors
-- salary < 5000   raise  50%
-- salary > 5000   raise  30%
-- salary > 10000   raise   20%


declare pointer cursor
for 
	select I.Salary
	from Instructor I
for update 
declare @salary int 
open pointer 
fetch pointer into @salary
while @@FETCH_STATUS = 0 
begin
	-- code 
	if @salary <= 5000
	update Instructor
	set Salary = Salary * 1.50
	where current of pointer

	else if @salary > 5000  and @salary < 10000
	update 
	Instructor
	set Salary = Salary * 1.30
	where current of pointer

	else 
	update Instructor
	set Salary = Salary * 1.20
	where current of pointer

	-- move next row 
	fetch pointer into @salary


end
close pointer 
deallocate pointer


declare pointer cursor
for 
	select I.Ins_Name
	from Instructor I
for update 
declare @name varchar(50) 
open pointer 
fetch pointer into @name
while @@FETCH_STATUS = 0 
begin
	
	select @name

	-- move next row 
	fetch pointer into @name
	fetch pointer into @name

end
close pointer 
deallocate pointer
---------------------------------------
--view
-- hide meta data of applicatoin 

create view VStudents
as
	select * from Student

select * from VStudents

-- virtual table 
-- do not affect on origingal table
drop view VStudents


-- change original columns names to new names 
create view VStudentInCairo (ID , FullName , Address)
as 
	select s.St_Id , s.St_Fname , s.St_Address
	from Student s
	where s.St_Address = 'Cairo'

-- issue 
select s.St_Fname from VStudentInCairo

create view VStudentInAlex (ID , FullName , Address)
as 
	select s.St_Id , s.St_Fname , s.St_Address
	from Student s
	where s.St_Address = 'Alex'

	-- create view over view 
create view VAllStudents (ID , FullName , Address)
as 
	select * from VStudentInCairo
	union all
	select * from VStudentInAlex

select * from VAllStudents

-- decrease charactiers 
create view VStudentWithDepartment (ID , Name , DepartmentID, DpartmentName)
as
	select s.St_Id , s.St_Fname , d.Dept_Id , d.Dept_Name
	from Student s join Department d on s.Dept_Id = d.Dept_Id

select * from VStudentWithDepartment



-- join between table + view 

create view VStudentWithDepartmentWithGrades
as
select sc.Crs_Id , ds.Name , ds.DpartmentName
from Stud_Course SC inner join VStudentWithDepartment DS
on SC.St_Id = DS.ID


-- edit on view 
alter view VStudentWithDepartmentWithGrades
with encryption
as
select sc.Crs_Id , ds.Name , ds.DpartmentName
from Stud_Course SC inner join VStudentWithDepartment DS
on SC.St_Id = DS.ID

select * from VStudentWithDepartmentWithGrades

sp_helptext 'VStudentWithDepartmentWithGrades'

-- no allow of dml 
create view Vupdae
as
update Student
set St_Age += 3



-- insert into view 
-- update into view 
-- delete from view 
insert into VStudentInCairo values (30 , 'ahmed' , 'Cairo')
insert into VStudentInCairo values (30 , 'ahmed' , 'Cairo')

-- DML view tables (1tables) + operation vaild (Required , not all null , identity )

create view VStudentInCairo2 (name , age)
as 
	select s.St_Fname , s.st_Age
	from Student s


--condiotns : update , insert
-- affect one table 
alter view VStudentCourseGrades (ID, name , courseID , CourseName , Grade)
as 
	select s.St_Id , s.St_Fname , c.Crs_Id, c.Crs_Name , Sc.Grade
	from
	Student s join Stud_course Sc on s.St_Id = sc.St_Id
	join Course C on C.Crs_Id = sc.Crs_Id


-- affect (change ) more than one table
insert into VStudentCourseGrades values (40 , 'fatama', 600 , 'Python' , 40)

-- no error
-- one table 
insert into VStudentCourseGrades (ID, Name) values (40 , 'fatama')

insert into VStudentCourseGrades (courseID , CourseName) values (13000 , 'GenAI')




alter view VStudentInCairo (ID , FullName , Address)
as 
	select s.St_Id , s.St_Fname , s.St_Address
	from Student s
	where s.St_Address = 'Cairo'
with check option   -- before any dml check values applicalble to where

insert into VStudentInCairo values (46 , 'mounir' , 'Alex')

insert into VStudentInCairo values (48 , 'mounir' , 'Cairo')