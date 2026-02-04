use Company_SD
--1 Display all the employees Data.
select * 
from Employee
--2 Display the employee First name, last name, Salary and Department number.
select Fname, lname, Salary, Dno
from Employee
--3 Display all the projects names, locations and the department which is responsible about it.
select pname, plocation, Dnum
from project
--4 
select Fname + ' ' + Lname as [Full Name],
Salary * 12 * 0.1 as [Annual Salary]
from Employee
--5 Display the employees Id, name who earns more than 1000 LE monthly.
select SSN,Fname + ' ' + Lname as [Full Name] 
from Employee
where Salary > 1000
--6 Display the employees Id, name who earns more than 10000 LE annually.
select SSN, Fname + ' ' + Lname as [Full Name] 
from Employee
where salary * 12 > 10000
--7 Display the names and salaries of the female employees
Select Fname + ' ' + Lname as [Full Name], Sex
from Employee
where Sex = 'F'
--8 Display each department id, name which managed by a manager with id equals 968574.
select Dnum, Dname
from Departments
where MGRSSN = 968574

-- Display the ids, names and locations of the projects which controled with department 10.
select Pnumber, Pname, Plocation
from Project
where Dnum = 10

--10 Display the Department id, name and id and the name of its manager.
select Dnum, Dname, E.SSN as [Manager ID], E.Fname + ' ' + E.Lname aS [Manager Name]
from Employee E inner join Departments as D
on E.SSN = D.MGRSSN

--11 Display the name of the departments and the name of the projects under its control.
select D.dname , P.pname
from Departments D inner join Project P
on D.Dnum = P.Dnum
--12 Display the full data about all the dependence associated with the name of the employee they depend on him/her. 
select D.*, E.Fname +' ' + E.Lname as [Employee Name]
from Dependent D left outer join Employee E
on D.ESSN = E.SSN
-- 13 Display the Id, name and location of the projects in Cairo or Alex city.
select Pnumber, Pname, Plocation
from Project
where City ='Cairo' or City = 'Alex'

select Pnumber, Pname, Plocation
from Project
where city in ('cairo', 'Alex')
-- 14 display full data of projects with name starting with a
select *
from Project
where Pname like 'a%'
--15 Display all employees in department 30 with salary from 1000 to 2000 LE
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000

--16 Retrieve the names of all employees in department 10 who works more than or equal 10 hours 
--per week on "AL Rabwah" project.
select E.Fname +' ' + E.Lname as [Employee Name]
from Employee E inner join Works_for W
on E.SSN = W.ESSn
inner join Project P
on P.Pnumber = W.Pno
where E.Dno = 10
and W.Hours >= 10
and P.Pname = 'AL Rabwah'

-- 17 Retrieve the names of all employees and the names of the projects they are working on,
-- sorted by the project name.
select E.Fname +' ' + E.Lname as [Employee Name], P.Pname
from Employee E inner join Works_for W
on E.SSN = W.ESSn
inner join Project P
on P.Pnumber = W.Pno
order by Pname
-- 18 For each project located in Cairo City , find the project number, the controlling
-- department name ,the department manager last name ,address and birthdate.
select E.Fname +' '+ E.Lname as [Employee Name], P.pname
from Project P inner join Departments D
on P.Dnum = D.Dnum 
join Employee E
on  D.MGRSSN = E.SSN
where P.City = 'Cairo'

-- 19 Display All Data of the managers
select *
from Employee E left outer join Departments D
on E.SSN = D.MGRSSN

-- 20 Display All Employees data and the data of their dependents even if they have no dependents
select E.*, D.* 
from Employee E right outer join Dependent D
on E.SSN = D.ESSN

--21 Insert your personal data to the employee table as a new employee in department
-- number 30, SSN = 102673, Superssn = 112233, salary=3000.
insert into Employee
(Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values
('Noha', 'Nour-Eldean', 102673, '2003-04-24', 'Sharqia', 'F', 3000, 112233, 30)


--22 Insert another employee with personal data your friend as new employee in
-- department number 30, SSN = 102660, but don’t enter any value for salary or
-- supervisor number to him.

insert into Employee 
(Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values
('Ahmed', 'Ali', 102660, '2002-06-15', 'Cairo', 'M', NULL, NULL, 30)


select *
from Employee
where Dno = 30


--23 Upgrade your salary by 20 % of its last value.
update Employee
set Salary = Salary * 1.2

select *
from Employee

--24 Display data using getDate in different formats (try convert , format)
select
convert(varchar, getdate(), 103) as [Today Date]
format(getdate(), 'HH:MM:SS TT') as [Current Time]