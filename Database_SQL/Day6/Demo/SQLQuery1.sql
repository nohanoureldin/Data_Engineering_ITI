-- lab day 6
Use AdventureWorks2012
-- Part 1
-- 1. Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales  schema)
-- to designate SalesOrders that occurred within the period  ‘7/28/2002’ and ‘7/29/2014’ 
select SalesOrderID, ShipDate from sales.SalesOrderHeader
where ModifiedDate between '7/28/2002' and '7/29/2014'

-- 2. Display only Products(Production schema) with a StandardCost below  $110.00 
-- (show ProductID, Name only) 
select ProductID, Name
from production.Product
where StandardCost < 110

-- 3. Display ProductID, Name if its weight is unknown 
select ProductId, Name
from Production.Product
where Weight is null

-- 4. Display all Products with a Silver, Black, or Red Color 
select Name, Color
from Production.Product
where Color = 'Silver'
    or color = 'Black'
    or Color = 'Red'

-- 5. Display any Product with a Name starting with the letter B 
select Name
from Production.Product
where Name like 'B%'

-- 6 6. Run the following Query 
UPDATE Production.ProductDescription 
SET Description = 'Chromoly steel_High of defects' 
WHERE ProductDescriptionID = 3 
-- Then write a query that displays any Product description with underscore value
-- in its description. 
select Description
from Production.ProductDescription 
where Description like '%\_%' ESCAPE '\'

-- 7. Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader
-- table for the period between '7/1/2001' and '7/31/2014'
select OrderDate, sum(totaldue) as [Sum Total Due]
from sales.SalesOrderHeader
where orderdate between '7/1/2001' and '7/31/2014'
group by OrderDate

-- 8. Display the Employees HireDate (note no repeated values are allowed) 
select Distinct HireDate
from HumanResources.Employee

-- 9 Calculate the average of the unique ListPrices in the Product table 
select avg(distinct ListPrice)
from Production.Product

-- 10.Display the Product Name and its ListPrice within the values of 100 and 120 
-- the list should has the following format "The [product name] is only! [List  price]" 
-- (the list will be sorted according to its ListPrice value) 

select Name as [Product Name], ListPrice as [List Price]
from Production.Product
where ListPrice between 100 and 129
order by [List Price]

-- /Part 2\ --
-- 11.Try to Create Login Named(ITIStud) who can access Only student and Course tables from 
-- ITI DB then allow him to select and insert data into tables and  deny Delete and update 

-- 12.Search how we can import database table into excell sheet 
Select Data > Get Data > From Database > From SQL Server Analysis Services Database (Import).

-- /Part 3\ --
Use ITI
 1. Create a scalar function that takes date and returns Month Name of that  date. 
create function getMonthName (@inputdate date)
returns varchar(20)
as
begin
    declare @monthname varchar(20)
    select @monthname = DATENAME(month, @inputdate)
    return @monthname
end

select dbo.getMonthName('2024-04-15')


-- 2. Create a multi-statements table-valued function that takes 2 integers 
-- and returns the values between them. 
create function getNumbersBetween (@start int , @end int)
returns @numbers table (number int)
as
begin
	declare @counter int
	set @counter = @start
	while @counter <= @end
	begin
		insert into @numbers
		values (@counter)
		set @counter = @counter + 1
	end
	return
end


-- 3. Create a tabled valued function that takes Student No and returns  Department Name 
-- with Student full name. 
create function getStudentDeptInfo (@studentNo int)
returns table
as
return(
	select concat(s.St_Fname ,' ', s.St_Lname) as FullName,d.Dept_Name
	from Student s join Department d
		on s.Dept_Id = d.Dept_Id
	where s.St_Id = @studentNo)

-- 4 Create a scalar function that takes Student ID and returns a message to  user  
create function checkStudNameStat(@studentId int)
returns varchar(100)
as
begin
	declare @fname varchar(50)
	declare @lname varchar(50)
	declare @message varchar(100)
	select @fname = St_Fname, @lname = St_Lname
	from Student
	where St_Id = @studentId

	if @fname is null and @lname is null
		set @message = 'First name & last name are null'
	if @fname is null
		set @message = 'first name is null'

	if @lname is null
		set @message = 'last name is null'

	else
		set @message = 'First name & last name are not null'

	return @message
end

select dbo.checkStudNameStat(5)

-- 5. Create a function that takes integer which represents manager ID and 
-- displays department name, Manager Name and hiring date  
create function getManagerDepartmentInfo (@managerId int)
returns table
as
return
(
	select 
		d.Dept_Name,
		e.Emp_Name as ManagerName,
		e.Hire_Date
	from Department d join Employee e
		on d.Manager_Id = e.Emp_Id
	where d.Manager_Id = @managerId
)

-- (6) Create multi-statements table-valued function that takes a string
create or alter function dbo.GetStudentNameByType(@Choice varchar(20))
returns @Result table(NameValue varchar(100))
as
begin
    if @Choice = 'first name'
    begin
        insert into @Result(NameValue)
        select isnull(St_Fname, 'NULL') from Student;
    end

    else if @Choice = 'last name'
    begin
        insert into @Result(NameValue)
        select isnull(St_Lname, 'NULL') from Student;
    end

    else if @Choice = 'full name'
    begin
        insert into @Result(NameValue)
        select concat(isnull(St_Fname, 'NULL'), ' ', isnull(St_Lname, 'NULL') )
        from Student;
    end

    return;
end;

select * from dbo.GetStudentNameByType('first name')