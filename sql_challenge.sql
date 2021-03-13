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

-- List first name, last name, and hire date for employees who were hired in 1986
select first_name, last_name, hire_date
from employees
where right(hire_date, 4) = '1986';

-- List the manager of each dept and: department number, department name, 
--     the manager's employee number, last name, first name
select m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
from dept_manager as m
inner join employees as e
on e.emp_no = m.emp_no
inner join departments as d
on d.dept_no = m.dept_no;

-- List the department of each employee with the following information:
--     employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
inner join dept_emp as j
on j.emp_no = e.emp_no
inner join departments as d
on d.dept_no = j.dept_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name = 'Hercules'
	and last_name like 'B%';