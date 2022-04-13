use 20200128db;

  
create table departmentnew
(
dnumber int(5) primary key,
dname varchar(20));

create table employee
(
id int(5) primary key,
name varchar(20),
superid int(5),
salary int(10),
bdate date,
dno int(5),
foreign key(dno) references departmentnew(dnumber));

insert into departmentnew values (1, "Payroll");
insert into departmentnew values (2, "TechSupport");
insert into departmentnew values (3, "Research");

insert into employee values (1, "john",3,100000,'1960-01-01',1);
insert into employee values (2, "mary",3,50000,'1964-12-01',3);
insert into employee values (3, "bob",NULL,80000,'1974-02-07',3);
insert into employee values (4, "tom",1,50000,'1976-01-17',2);
insert into employee values (5, "bill",NULL,NULL,'1985-01-20',1);

select * from employee;
select * from departmentnew;

create table depsal as
select dnumber, 0 as totalsalary from departmentnew;

select * from depsal;

delimiter //
create procedure updateSalary(IN param1 int)
begin
update depsal 
set totalsalary = (select sum(salary) from employee where dno = param1)
where dnumber = param1;
end; //

delimiter ;

call updateSalary(1);
call updateSalary(2);
call updateSalary(3);

select * from depsal;

delimiter |
create function giveRaise (oldval int, amount double)
returns int
deterministic 
begin
declare newval int;
set newval = oldval * (1 + amount);
return newval;
end|

delimiter ;

select name, salary, giveRaise(salary, 0.1) as newsal
from employee;