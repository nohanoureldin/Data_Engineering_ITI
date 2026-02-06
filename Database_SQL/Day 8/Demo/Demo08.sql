-- proc 
-- built in 
sp_bindrule 

sp_helptext 

-- user defined 
create proc sp_GetStudents
as 
	select * from Student

---- first call
---- query cycle 
--	-- parsing 
--	-- optimization 
--	-- query tree (steps 1] get table student from mem 
--	                     2] select * 
--						    save steps 
--	-- execution 
----second call 
----query tree -------> execute 
sp_GetStudents

create proc sp_GetStudentsByID @id int 
as
	-- select by id 
	select st_id , st_fname , st_address
	from Student
	where St_Id = @id

sp_GetStudentsByID 6
Execute sp_GetStudentsByID 6
Exec sp_GetStudentsByID 6


-- dmls 
alter proc sp_InsertStudents @id int , @name varchar(30)
as
begin try
	insert into Student (St_Id , St_Fname) 
	values (@id , @name)
end try 
begin catch 
	select 'error'
end catch 

sp_InsertStudents 16 , 'nour'

create proc sp_sum @x int , @y int
as
	select @x , @y 
	select @x + @y 


-- deffault by pos 
sp_sum 3 , 6 

-- call by name 
sp_sum @y = 5, @x = 4 


create proc sp_getStudentbyAge @age1 int , @age2 int
as
	select st_id , St_Fname
	from Student
	where St_Age between @age1 and @age2


--insert into @t 
--select * from student

--insert based on exec
declare @t table (id int , name varchar(30))

insert into @t 
exec sp_getStudentByAge 20 , 30

select * from @t 


create proc sp_getStudentName @id int
as
	declare @name varchar(40)
	select @name = st_fname from Student where st_id = @id

	--return @name           -- int only 0   failed 
	--                                   1   update 
	--								     4   error dublicate key


declare @x varchar(40)
exec @x = sp_getStudentName 8

select @x



-- output paramter who hold return 
alter proc sp_getStudentName @id int , @name varchar(50) output
as
	select @name = st_fname from Student where st_id = @id

	return 0




declare @y varchar(40)
exec sp_getStudentName 5 , @y output
select @y 


-- return age , name 

create proc sp_getAgeName @id int , @age int output , @name varchar(30) output
with encryption
as
	select @age = st_age from Student where st_id = @id
	select @name = st_fname from Student where st_id = @id
	return 1  -- detect status of proc 


declare @x int , @y varchar(30) 
exec sp_getAgeName 5 , @x output , @y output
select @x , @y 


---------------------------------------
--proc 
--	- dml 
--	- performance 
--	- security 

---------------------------------------------------
--Trigger 
-- no pramamters 
-- no call 

--on tables 
action done on table (insert , update(st_fanme) ,delete)
--execute ------> code 


-- insert table --- hello 

create trigger T1
on student
for insert 
as
	select 'hello'


insert into Student (St_Id , St_Fname)
values (20, 'ahmed')


-- show time of update 
create trigger t2
on student
after update 
as
	select GETDATE()

	update Student
	set St_Age =+ 1


-- prevent action on table 
create trigger T3
on student
instead of delete
as
	select 'not allowed to be deleted on table student'

delete from 
Student
where St_Id = 8


-- update column name select 'hi'
create trigger T6
on student 
for update 
as 
		if UPDATE(st_fname)
			select 'hi'

update Student
set St_Age += 3

update Student
set St_Fname = 'mohamed'
where st_id = 3


alter table student
disable trigger t2


-- auditing 

-- inserted   , deleted 
-- same structure of tables of (update , insert , delete)

alter trigger T8 
on course 
for insert 
as 
		select * from inserted  -- new data insert 
		select * from deleted

insert into Course (Crs_Id , Crs_Name)
values (1500 , 'Python')


create trigger T10
on course 
for delete
as 
		select * from inserted  -- new data insert 
		select * from deleted

delete from Course
where Course.Crs_Id = 1900


create trigger T11
on course 
for update
as 
		select * from inserted  -- new data insert  , update
		select * from deleted    -- old data delete , update


-- inserted : 800  Nativejava 60  1 
-- deleted:   800 Java     60   1  
update Course
set Crs_Name = 'Native java'
where Crs_Id = 800


-- trigger audit for each update 
create table TopicHistory 
(
 _user varchar(50),
 _data date,
 _oldName varchar(50),  -- deleted
 _newName varchar(50)    -- inserted

)

create trigger t12
on topic 
for update
as
	-- get old data --old name 
	-- new data   -- new name 
	declare @oldName varchar(50) , @newName varchar(50)
	if UPDATE(Top_Name)
	begin 
		select @oldName = Top_name from deleted;
		select @newName = Top_name from inserted;

		insert into TopicHistory values (SUSER_NAME(), GETDATE(), @oldName , @newName)
	end 

update Topic
set Top_Name = 'WebDesign'
where Top_Id = 3

select * from topicHistory

-- friday ----> prevent delete course 
-- any other data ----> allow delete 
alter trigger t15
on Course 
for delete 
as
    -- deleted (any try to delete)
	-- anyother day except friday -- allow delete 
	if format(getdate() , 'dddd') = 'Wednesday'
	begin
		-- get data from deleted 
		-- insert 
		insert into Course
		select * from deleted
	end


delete from Course
where Crs_Id = 1500

select format(getdate() , 'dddd')

--1300	UI design 	60	NULL  -- deleted 

create trigger t16
on Course 
instead of delete
with encryption
as
    -- deleted (any try to delete)
	-- anyother day except friday -- allow delete 
	if format(getdate() , 'dddd') != 'Friday'
	begin
		-- delete row 
		delete from Course
		where Course.Crs_Id = (select Crs_Id from deleted)
	end


--delete from 	Course 
--where id = 400
--deleted : 400	Unix	50	4


