-- Drop tables if needed
drop table if exists departments cascade;
drop table if exists titles cascade;
drop table if exists employees cascade;
drop table if exists dept_emp cascade;
drop table if exists dept_manager cascade;
drop table if exists salaries cascade;

-- Creating tables to hold data
create table if not exists departments(
	dept_no varchar(32) not null primary key,
	dept_name varchar(64) not null
);

create table if not exists titles(
	title_id varchar(32) not null primary key,
	title varchar(64) not null
);

create table if not exists employees(
	emp_no varchar(32) not null primary key,
	emp_title_id varchar(64) not null,
	birth_date varchar(32) not null,
	first_name varchar(64) not null,
	last_name varchar(64) not null,
	sex varchar(32),
	hire_date varchar(32) not null,
	foreign key (emp_title_id) references titles(title_id)
);
	
create table if not exists dept_emp(
	emp_no varchar(32) not null,
	dept_no varchar(32) not null,
	primary key (emp_no, dept_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table if not exists dept_manager(
	dept_no varchar(32) not null,
	emp_no varchar(32) not null,
	primary key (dept_no, emp_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table if not exists salaries(
	emp_no varchar(32) not null primary key,
	salary int not null,
	foreign key (emp_no) references employees(emp_no)
);

-- Some simple data analysis queries
-- List for each employee: employee number, last name, first name, sex, and salary
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s
on e.emp_no=s.emp_no;