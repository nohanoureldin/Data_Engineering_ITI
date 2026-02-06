--Lab 8
-- 1. Create a stored procedure to show the number of students per
-- department.[use ITI DB]
use ITI
create proc getstudents
as
select d.Dept_Name, COUNT(s.st_Id) as StudentCount
from Student s right join Department d
on s.Dept_Id = d.Dept_Id
group by d.Dept_Name
execute getstudents

-- 2. Create a stored procedure that will check for the # of employees in the
-- project p1 if they are more than 3 print message to the user “'The number
-- of employees in the project p1 is 3 or more'” if they are less display a
-- message to the user “'The following employees work for the project p1'” in
-- addition to the first name and last name of each one. [Company DB]
use Company_SD
go
create proc checkemployeeinp1
as
begin
declare @empcount int

select @empcount = COUNT(*)
from Works_for w inner join Project p
on w.Pno = p.Pnumber
where p.Pname = 'p1'

if @empcount >= 3
begin
select 'The number of employees in the project p1 is 3 or more'
end
else
begin
select 'The following employees work for the project p1'

select e.Fname, e.Lname
from Employee e inner join Works_for w
on e.SSN = w.ESSn 
inner join Project p
on w.Pno = p.Pnumber
where p.Pname = 'p1'
end
end


exec checkemployeeinp1 1000

select * 
from Works_for
where Pno = 200

-- 3. Create a stored procedure that will be used in case there is an old
--employee has left the project and a new one become instead of him. The
--procedure should take 3 parameters (old Emp. number, new Emp. number
--and the project number) and it will be used to update works_on table.
-- [Company DB]

use Company_SD
go
create proc replaceEmpInProject
@OldEmp_N int,
@NewEmp_N int,
@Project_N int
as
begin
	update Works_for 
	set ESSn =@NewEmp_N
	where ESSn = @OldEmp_N
	and Pno = @Project_N
end
execute replaceEmpInProject 112233,55897 , 200

-- 4. Create an Audit table with
use Company_SD
-- If a user updated the budget column then the project number, user name
-- that made that update, the date of the modification and the value of the
-- old and the new budget will be inserted into the Audit table
-- Note: This process will take place only if the user updated the budget
-- column
create or alter table Project
add Budjet 
create table ProjectAudit
(
    ProjectNo int,
    UserName varchar(50),
    ModifiedDate datetime,
    Budget_Old money,
    Budget_New money
)

create trigger trg_ProjectBudgetAudit
on Project
after update
as
begin
if update(Budget)
begin
insert into ProjectAudit (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
select d.pnumber,suser_name(),getdate(),d.Budget,i.Budget               
from inserted i
join deleted d on i.pnumber = d.pnumber;
end
end


update Project
set Budget = 200000
where pnumber = 100
select * from ProjectAudit


--Q5.create trigger trg_PreventInsertDepartment
use ITI
create trigger trg_PreventInsertDepartment
on Department
instead of insert
as
begin
    print 'you can''t insert a new record in the Department table';
end


insert into Department (Dept_Id, Dept_Name)
values (1000, 'NewDept')


--Q6. Create a trigger that prevents the insertion Process for Employee table in March [Company DB]
use Company_SD
create trigger trg_preventinsertemployee_march
on Employee
instead of insert
as
begin
  
if month(getdate()) = 3
begin
print 'you can''t insert a new record in the Employee table during March';
end
else
begin
insert into Employee (SSN, fname, lname)
select SSN, fname, lname
from inserted
end
end


insert into Employee (SSN, fname, lname)
values (50002, 'magdy', 'mohamed')

/*Q7. Create a trigger on student table after insert to add Row in Student Audit 
table (Server User Name , Date, Note) where note will be “[username] 
Insert New Row with Key=[Key Value] in table [table name]” */

use ITI
create table StudentAudit
(
ServerUserName varchar(50),
AuditDate datetime,
Note varchar(200)
)

create trigger trg_StudentAudit
on Student
after insert
as
begin
insert into StudentAudit (ServerUserName, AuditDate, Note)
select 
suser_name(),                         
getdate(),                           
suser_name() + ' Insert New Row with Key=' 
+ cast(st_id as varchar(10))          
+ ' in table Student'
from inserted
end

insert into Student (st_id, st_fname, st_address)
values (5000, 'Ali', 'Cairo');

select * from StudentAudit


/*Q8.Create a trigger on student table instead of delete to add Row in Student 
Audit table (Server User Name, Date, Note) where note will be“ try to 
delete Row with Key=[Key Value]”*/

create trigger trg_StudentPreventDelete
on Student
instead of delete
as
begin
insert into StudentAudit (ServerUserName, AuditDate, Note)
select
suser_name(), getdate(),'try to delete Row with Key=' + cast(st_id as varchar(10))  
from deleted
end

