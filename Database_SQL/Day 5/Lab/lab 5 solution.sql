use ITI
-- 1. Retrieve number of students who have a value in their age.
select  count(*) as [Num Of Students With Age]
from Student
where St_Age is not null

--2 Get all instructors Names without repetition
select distinct Ins_Name
from Instructor

--3 Display student with the following Format (use isNull function)
select St_Id, concat(S.St_Fname ,  S.St_Lname) as [Full Name], D.Dept_Name
from Student S left outer join Department D
on S.Dept_Id = D.Dept_Id

-- 4. Display instructor Name and Department Name
-- Note: display all the instructors if they are attached to a department or not
select I.Ins_Name, D.Dept_Name
from Instructor I left outer join Department D
on I.Dept_Id = D.Dept_Id

-- 5. Display student full name and the name of the course he is taking
--- For only courses which have a grade
select concat(S.St_Fname, ' ',S.St_Lname) as [Full Name], C.Crs_Name as [Name Of The Course]
from Course C left outer join Stud_Course Stc
on C.Crs_Id = Stc.Crs_Id
join Student S
on Stc.St_Id = S.St_Id
where Stc.Grade is not null

--6. Display number of courses for each topic name
select count(c.Crs_Id) as 'Number of Courses', T.Top_Name
from Course C left join Topic T
on C.Top_Id = T.Top_Id
group by T.Top_Name

-- 7. Display max and min salary for instructors
select max(I.Salary) as [Max.salary], min(I.Salary) as [Min.salary]
from Instructor I

-- 8. Display instructors who have salaries less than the average salary of all
-- instructors.
select *
from Instructor 
where Salary < (select AVG(Salary) from Instructor)

-- 9.Display the Department name that contains the instructor who receives the
-- minimum salary.
select D.Dept_Name
from Instructor I left join Department D
on I.Dept_Id = D.Dept_Id
where I.Salary = (select min(Salary) from Instructor)

-- 10. Select max two salaries in instructor table.
select top 2 Salary
from Instructor 

-- 11.Select instructor name and his salary but if there is no salary display instructor
-- bonus. “use one of coalesce Function”
alter table Instructor 
add Bonus decimal(5,2)
select Ins_Name, coalesce(Salary, Bonus) as [Bonus]
from Instructor

-- 12.Select Student first name and the data of his supervisor.
select st.St_Fname, Supervisor.St_super
from Student St join Student Supervisor
on St.St_Id = Supervisor.St_super

-- 13.Write a query to select the highest two salaries in Each Department for
-- instructors who have salaries. “using one of Ranking Functions"
select *
from
(select *, row_number() over( partition by Dept_Id order by Salary desc) as rank
from Instructor) f
where rank <= 2

-- 14. Write a query to select a random student from each department. “using
-- one of Ranking Functions”
select *
from
(select *, ROW_NUMBER() over(partition by Dept_Id order by NEWID() ) as rank
from Student) t
where rank = 1

-- 15.Delete all grades for the students whose Located in SD Department
delete SC
from Stud_Course SC join Student S
on SC.St_Id = S.St_Id
join Department D
on S.Dept_Id = D.Dept_Id
where D.Dept_Name = 'SD'

--16. 
-- A- Transfer the rowguid ,Name, SalesPersonID, Demographics from
--Sales.Store table in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?

use AdventureWorks2012
select rowguid, Name, SalesPersonID, Demographics
into store_Archive
from Sales.Store

select count(*) from store_Archive -- 701

-- B- Try the previous query but without transferring the data?
--Search about RANK, Top with ties, and state an example of it?
select rowguid, Name, SalesPersonID, Demographics
into store_Archive_Empty
from Sales.Store
where 1 = 0
select count(*) from store_Archive_Empty -- 0
