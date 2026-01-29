
-- Task 9: Writing Subqueries (Nested Queries)
-- Database: MySQL


-- Drop table if exists
DROP TABLE IF EXISTS employees;

-- Create employees table with salary
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT
);

-- Insert employee data
INSERT INTO employees VALUES
(101, 'Alice', 1, 60000),
(102, 'Bob', 2, 50000),
(103, 'Charlie', 2, 40000),
(104, 'David', 3, 70000),
(105, 'Eva', 1, 45000);


-- 1. Subquery in WHERE clause
-- Employees earning more than average salary

SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
);


-- 2. Subquery in SELECT clause

SELECT emp_name,
       salary,
       (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;


-- 3. Subquery in FROM clause

SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) AS dept_avg;

-- 4. Correlated Subquery
-- Employees earning more than department average

SELECT e1.emp_name, e1.salary, e1.dept_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e1.dept_id
);

