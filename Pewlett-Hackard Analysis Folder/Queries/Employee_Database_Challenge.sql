CREATE TABLE Employees(
	emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);
CREATE TABLE Titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
    PRIMARY KEY (emp_no,title,from_date )
	
	
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

SELECT * FROM dept_emp
SELECT Employees.emp_no,
	Employees.first_name,
	Employees.last_name,
	Titles.title,
	Titles.from_date,
	Titles.to_date
	INTO retirement_titles
FROM Employees
INNER JOIN Titles
ON (Employees.emp_no = Titles.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;
SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

SELECT COUNT(unique_titles.emp_no),
unique_titles.title
INTO retiring_titles
FROM unique_titles 
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles

--Deliverable 2

SELECT DISTINCT ON(employees.emp_no) employees.emp_no, 
    employees.first_name, 
    employees.last_name, 
    employees.birth_date,
    dept_emp.from_date,
    dept_emp.to_date,
    titles.title
INTO mentorship_eligibilty
FROM employees 
inner Join dept_emp 
ON (employees.emp_no = dept_emp.emp_no)
inner Join titles 
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')AND (dept_emp.to_date = ('9999-01-01'))
ORDER BY employees.emp_no;
SELECT * FROM mentorship_eligibilty


