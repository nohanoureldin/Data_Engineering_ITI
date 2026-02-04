use Company_SD

--  1. Display (Using Union Function)
--a. The name and the gender of the dependence that's gender is Female and
--depending on Female Employee.
--b. And the male dependence that depends on Male Employee.
select D.Dependent_name, D.Sex, E.Sex as [The Depending Employee]
from Dependent D left outer join Employee E
on D.ESSN = E.SSN
where D.Sex = 'F'
and E.Sex = 'F'
UNION
select D.Dependent_name, D.Sex, E.Sex as [The Depending Employee]
from Dependent D join Employee E
on D.ESSN = E.SSN
where D.Sex = 'M'
and E.Sex = 'M'

--2 For each project, list the project name and the total hours per week (for all
-- employees) spent on that project.
select P.Pname, sum(W.Hours) as [total hours per week]
from Project P join Works_for W
on P.Pnumber = W.Pno
group by P.Pname


-- 3 Find the names of the employees who directly supervised with Kamel Mohamed.
select E.Fname +' '+ E.lname as [Full Name]
from Employee E inner join Employee S
on E.SSN = S.Superssn
where S.Fname = 'Kamel'
and S.lname = 'Mohamed'

-- 4- Display the data of the department which has the smallest employee ID over all
-- employees' ID.
select E.SSN
from Employee E join Departments D
on E.Dno = D.Dnum
where E.SSN = (select min(SSN) from Employee)

-- 5- For each department, retrieve the department name and the maximum, minimum and
-- average salary of its employees.

select D.Dname, max(E.salary) as [Max Salary], min(E.salary) as [Min Salary],
avg(E.salary) as[Avg Salary]
from Departments D join Employee E
on D.Dnum = E.Dno
group by D.Dname

-- 6 List the full name of all managers who have no dependents.

select concat(E.fname, E.lname) as [Full Name]
from Employee E join Departments Dep
on E.SSN = Dep.MGRSSN
where not exists (select * from Dependent D where D.ESSN = E.SSN)

--7 For each department-- if its average salary is less than the average salary of all
-- employees-- display its number, name and number of its employees.

select D.Dnum, D.Dname , count(E.SSN) AS [Num Employees]
from Departments D join Employee E
on D.Dnum = E.Dno
group by D.Dnum, D.Dname
having avg(E.Salary) < (select avg(Salary) from Employee)

--8 Retrieve a list of employee’s names and the projects names they are working on
--ordered by department number and within each department, ordered alphabetically by
--last name, first name.
select E.fname+' '+E.lname as [Full Name], P.Pname
from Employee E join Works_for W
on E.SSN = W.ESSN
join Project P
on W.Pno = P.Pnumber
order by [Full Name], E.Dno

--9 Try to get the max 2 salaries using sub query
select E.Salary
from Employee E
where E.Salary in (select distinct top 2 Salary from Employee)
order by E.Salary

-- 10 Get the full name of employees that is similar to any dependent name
select E.Fname + ' ' + E.Lname as [Full Name]
from Employee E join Dependent D
on E.Fname +' '+ E.Lname like '%' + D.Dependent_name + '%'

-- 11 Display the employee number and name if at least one of them have dependents (use
-- exists keyword) self-study.
select E.SSn, E.Fname + ' ' + E.Lname as [Full Name]
from Employee E
where exists (select * from Dependent D where D.ESSN = E.SSN)

-- 12- In the department table insert new department called "DEPT IT”, with id 100,
-- employee with SSN = 112233 as a manager for this department. The start date for this
-- manager is '1-11-2006'
insert into Departments values('DEPT IT', 120, 112233, '2006-1-1')

-- 13- Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574) moved to
-- be the manager of the new department (id = 100), and they give you(your SSN
-- =102672) her position (Dept. 20 manager)
-- a. First try to update her record in the department table
-- b. Update your record to be department 20 manager.
-- c. Update the data of employee number=102660 to be in your teamwork (he will
-- be supervised by you) (your SSN =102672)

-- a --
update Departments
set MGRSSN = 968574,
[MGRStart Date] = '2006-11-01'
where Dnum = 100
-- b --
update Departments
set MGRSSN = 102672, [MGRStart Date] = getdate()   
where Dnum = 20
-- c --
update Employee
set Superssn = 102672
where SSN = 102660

-- 14- Unfortunately the company ended the contract with Mr. Kamel Mohamed
--(SSN=223344) so try to delete his data from your database in case you know that you
--will be temporarily in his position.
-- Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises
-- any employees or works in any projects and handle these cases).
delete from  Dependent 
WHERE ESSN = 223344

update Departments
set MGRSSN = 102672, [MGRStart Date] = GETDATE()
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

delete from Works_for
where ESSN = 223344

delete from Employee
where SSN = 223344

-- 15- Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update E
set E.Salary = E.Salary * 1.30
from Employee E
join Works_for W
on E.SSN = W.ESSn
join Project P
on W.Pno = P.Pnumber
where P.Pname = 'Al Rabwah'

--subquery

