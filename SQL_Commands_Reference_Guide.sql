-- ============================================
-- SQL COMMANDS REFERENCE GUIDE
-- Sprint 3 Week 2 SQL - Epic 3.2: Employee Management System
-- ============================================

-- ============================================
-- DDL - DATA DEFINITION LANGUAGE
-- Commands that define/modify database structure
-- ============================================

-- --------------------------------------------
-- 1. CREATE DATABASE
-- Purpose: Creates a new database (schema)
-- Syntax: CREATE DATABASE database_name;
-- --------------------------------------------
CREATE DATABASE company;

-- --------------------------------------------
-- 2. USE
-- Purpose: Selects which database to work with
-- Syntax: USE database_name;
-- --------------------------------------------
USE company;

-- --------------------------------------------
-- 3. CREATE TABLE
-- Purpose: Creates a new table with columns and constraints
-- Syntax: CREATE TABLE table_name (
--             column_name DATA_TYPE CONSTRAINTS,
--             ...
--         );
-- --------------------------------------------

-- Example with PRIMARY KEY:
CREATE TABLE regions (
    region_id INT PRIMARY KEY,      -- PRIMARY KEY: Unique identifier for each row
    region_name VARCHAR(50)          -- VARCHAR(50): Variable-length text up to 50 characters
);

-- Example with FOREIGN KEY:
CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,  -- CHAR(2): Fixed-length text of 2 characters
    country_name VARCHAR(50),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)  -- Links to regions table
);

-- Example with multiple FOREIGN KEYS:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,                  -- DATE: Stores date values (YYYY-MM-DD)
    job_id VARCHAR(20),
    salary DECIMAL(10,2),            -- DECIMAL(10,2): Number with 10 digits, 2 after decimal
    commission_pct DECIMAL(4,2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)  -- Self-referencing FK
);

-- Example with COMPOSITE PRIMARY KEY:
CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(20),
    department_id INT,
    PRIMARY KEY (employee_id, start_date),  -- Two columns together form the PK
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


-- ============================================
-- DML - DATA MANIPULATION LANGUAGE
-- Commands that manipulate data in tables
-- ============================================

-- --------------------------------------------
-- 4. INSERT INTO
-- Purpose: Adds new rows of data into a table
-- Syntax: INSERT INTO table_name (columns) VALUES (values);
-- --------------------------------------------

-- Single row insert:
INSERT INTO regions (region_id, region_name) VALUES (1, 'Europe');

-- Multiple rows insert:
INSERT INTO regions (region_id, region_name) VALUES
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

-- --------------------------------------------
-- 5. UPDATE
-- Purpose: Modifies existing data in a table
-- Syntax: UPDATE table_name SET column = value WHERE condition;
-- --------------------------------------------

-- Simple UPDATE:
UPDATE departments 
SET manager_id = 100 
WHERE department_id = 90;

-- UPDATE with multiple columns:
UPDATE employees
SET department_id = 80,
    first_name = 'Kimberly'
WHERE first_name = 'Kimberely' AND last_name = 'Grant';

-- UPDATE using a variable (to avoid hard-coding):
SET @taylor_salary = (SELECT salary FROM consultants WHERE last_name = 'Taylor');
UPDATE employees
SET salary = @taylor_salary
WHERE last_name IN ('Weiss', 'Fripp');

-- --------------------------------------------
-- 6. DELETE
-- Purpose: Removes rows from a table
-- Syntax: DELETE FROM table_name WHERE condition;
-- --------------------------------------------

-- DELETE with subquery (no hard-coding):
DELETE FROM consultants
WHERE (first_name, last_name) IN (
    SELECT first_name, last_name FROM employees
);

-- --------------------------------------------
-- 7. SELECT
-- Purpose: Retrieves data from one or more tables
-- Syntax: SELECT columns FROM table WHERE condition;
-- --------------------------------------------

-- Basic SELECT:
SELECT first_name, last_name, salary
FROM employees;

-- SELECT with WHERE clause:
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 10000;

-- SELECT with ORDER BY (sorting):
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary;          -- ASC (ascending) is default
-- ORDER BY salary DESC;  -- DESC for descending order

-- SELECT with column aliases (AS):
SELECT 
    first_name AS employee_first_name,
    last_name AS employee_last_name,
    salary AS employee_salary
FROM employees;

-- SELECT DISTINCT (removes duplicates):
SELECT DISTINCT department_id 
FROM employees;


-- ============================================
-- JOINS
-- Combining data from multiple tables
-- ============================================

-- --------------------------------------------
-- 8. INNER JOIN (or just JOIN)
-- Purpose: Returns rows that have matching values in both tables
-- Syntax: SELECT columns FROM table1 JOIN table2 ON condition;
-- --------------------------------------------
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- --------------------------------------------
-- 9. LEFT JOIN (or LEFT OUTER JOIN)
-- Purpose: Returns ALL rows from left table, and matching rows from right table
--          Returns NULL for non-matching rows from right table
-- Syntax: SELECT columns FROM table1 LEFT JOIN table2 ON condition;
-- --------------------------------------------
SELECT 
    c.cust_fname,
    c.cust_lname,
    s.sales_amt
FROM customers c
LEFT JOIN sales s ON c.cust_id = s.sales_cust_id;
-- This includes customers even if they have no sales (sales columns will be NULL)

-- --------------------------------------------
-- 10. SELF JOIN
-- Purpose: Joins a table to itself
-- Used when: Comparing rows within the same table (e.g., employee to manager)
-- --------------------------------------------
SELECT 
    e.first_name AS employee_name,
    m.first_name AS manager_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

-- --------------------------------------------
-- 11. Multiple JOINs (Chaining)
-- Purpose: Connects multiple tables in one query
-- --------------------------------------------
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    l.city,
    c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id;


-- ============================================
-- SUBQUERIES
-- A query nested inside another query
-- ============================================

-- --------------------------------------------
-- 12. Subquery in WHERE clause
-- Purpose: Use result of inner query to filter outer query
-- --------------------------------------------

-- Find highest paid employee (without hard-coding salary):
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Find employees earning more than average:
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- --------------------------------------------
-- 13. Subquery with IN
-- Purpose: Check if value exists in a list returned by subquery
-- --------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location_id = 1700
);

-- --------------------------------------------
-- 14. Subquery with NOT IN
-- Purpose: Check if value does NOT exist in list returned by subquery
-- --------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id 
    FROM employees 
    WHERE manager_id IS NOT NULL
);

-- --------------------------------------------
-- 15. Subquery with ANY
-- Purpose: Compare to ANY value in the subquery result
-- > ANY means greater than at least one value
-- --------------------------------------------
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE job_id = 'SA_MAN'
);

-- --------------------------------------------
-- 16. Correlated Subquery
-- Purpose: Subquery that references the outer query
-- Executes once for each row in outer query
-- --------------------------------------------
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id  -- References outer query
);


-- ============================================
-- AGGREGATE FUNCTIONS
-- Functions that perform calculations on sets of rows
-- ============================================

-- --------------------------------------------
-- 17. COUNT()
-- Purpose: Counts the number of rows
-- --------------------------------------------
SELECT COUNT(*) AS total_employees FROM employees;
SELECT COUNT(commission_pct) AS employees_with_commission FROM employees;  -- Only counts non-NULL

-- --------------------------------------------
-- 18. SUM()
-- Purpose: Adds up all values in a column
-- --------------------------------------------
SELECT SUM(salary) AS total_salary FROM employees;

-- --------------------------------------------
-- 19. AVG()
-- Purpose: Calculates the average of values
-- --------------------------------------------
SELECT AVG(salary) AS average_salary FROM employees;

-- --------------------------------------------
-- 20. MAX()
-- Purpose: Returns the highest value
-- --------------------------------------------
SELECT MAX(salary) AS highest_salary FROM employees;

-- --------------------------------------------
-- 21. MIN()
-- Purpose: Returns the lowest value
-- --------------------------------------------
SELECT MIN(salary) AS lowest_salary FROM employees;

-- --------------------------------------------
-- 22. GROUP BY
-- Purpose: Groups rows that have the same values
-- Used with: Aggregate functions to calculate per group
-- --------------------------------------------
SELECT 
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- --------------------------------------------
-- 23. HAVING
-- Purpose: Filters groups (like WHERE but for groups)
-- Used with: GROUP BY
-- --------------------------------------------
SELECT 
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;  -- Only departments with more than 5 employees


-- ============================================
-- CONDITIONAL FUNCTIONS
-- ============================================

-- --------------------------------------------
-- 24. CASE WHEN
-- Purpose: Adds conditional logic (like IF-THEN-ELSE)
-- --------------------------------------------
SELECT 
    first_name,
    last_name,
    salary,
    CASE 
        WHEN salary >= 15000 THEN 'High'
        WHEN salary >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;

-- Used in calculations:
SELECT 
    cust_id,
    CASE 
        WHEN SUM(sales_amt) > 0 
        THEN ROUND((MAX(sales_amt) / SUM(sales_amt)) * 100, 2)
        ELSE 0 
    END AS largest_sale_pct
FROM customers c
LEFT JOIN sales s ON c.cust_id = s.sales_cust_id
GROUP BY c.cust_id;

-- --------------------------------------------
-- 25. COALESCE()
-- Purpose: Returns first non-NULL value
-- Used for: Replacing NULL with a default value
-- --------------------------------------------
SELECT 
    first_name,
    COALESCE(commission_pct, 0) AS commission  -- If NULL, show 0
FROM employees;

SELECT 
    COALESCE(r.region_name, 'Unassigned') AS region_name
FROM employees e
LEFT JOIN regions r ON ...;  -- 'Unassigned' if region is NULL

-- --------------------------------------------
-- 26. ROUND()
-- Purpose: Rounds a number to specified decimal places
-- --------------------------------------------
SELECT ROUND(AVG(salary), 2) AS avg_salary FROM employees;  -- 2 decimal places
SELECT ROUND(1234.5678, 2);  -- Returns 1234.57


-- ============================================
-- TCL - TRANSACTION CONTROL LANGUAGE
-- Commands that control transactions
-- ============================================

-- --------------------------------------------
-- 27. START TRANSACTION
-- Purpose: Begins a new transaction
-- Changes are temporary until COMMIT or ROLLBACK
-- --------------------------------------------
START TRANSACTION;

-- --------------------------------------------
-- 28. COMMIT
-- Purpose: Saves all changes made in the transaction permanently
-- --------------------------------------------
COMMIT;

-- --------------------------------------------
-- 29. ROLLBACK
-- Purpose: Undoes all changes made in the transaction
-- Note: Not used in this project, but important to know
-- --------------------------------------------
ROLLBACK;

-- Example of full transaction:
START TRANSACTION;
UPDATE employees SET salary = salary * 1.10 WHERE department_id = 80;
UPDATE employees SET salary = salary * 1.05 WHERE department_id = 60;
COMMIT;  -- Both changes saved permanently
-- If something went wrong, we could use ROLLBACK instead


-- ============================================
-- VARIABLES
-- Storing values for later use
-- ============================================

-- --------------------------------------------
-- 30. SET @variable
-- Purpose: Creates a user-defined variable
-- Used for: Avoiding hard-coded values
-- --------------------------------------------
SET @sales_dept = (SELECT department_id FROM employees WHERE job_id = 'SA_REP' LIMIT 1);
UPDATE employees SET department_id = @sales_dept WHERE last_name = 'Grant';

SET @taylor_salary = (SELECT salary FROM consultants WHERE last_name = 'Taylor');
UPDATE employees SET salary = @taylor_salary WHERE last_name IN ('Weiss', 'Fripp');


-- ============================================
-- SAFETY SETTINGS
-- ============================================

-- --------------------------------------------
-- 31. SET SQL_SAFE_UPDATES
-- Purpose: Enables/disables safe update mode in MySQL Workbench
-- 0 = OFF (allows updates without key in WHERE)
-- 1 = ON (requires key in WHERE clause)
-- --------------------------------------------
SET SQL_SAFE_UPDATES = 0;  -- Turn off safe mode
-- Now you can run UPDATE/DELETE without primary key in WHERE
SET SQL_SAFE_UPDATES = 1;  -- Turn back on (recommended for safety)


-- ============================================
-- OTHER USEFUL CLAUSES
-- ============================================

-- --------------------------------------------
-- 32. DISTINCT
-- Purpose: Removes duplicate rows from results
-- --------------------------------------------
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT department_id, job_id FROM employees;

-- --------------------------------------------
-- 33. ORDER BY
-- Purpose: Sorts the result set
-- ASC = Ascending (default)
-- DESC = Descending
-- --------------------------------------------
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;  -- Highest to lowest

SELECT first_name, last_name, salary
FROM employees
ORDER BY last_name ASC, first_name ASC;  -- Sort by multiple columns

-- --------------------------------------------
-- 34. LIMIT
-- Purpose: Restricts the number of rows returned
-- --------------------------------------------
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;  -- Top 5 highest paid

SELECT first_name, last_name, salary
FROM employees
LIMIT 1;  -- Only first row

-- --------------------------------------------
-- 35. NULL Handling
-- Purpose: Working with NULL values
-- NULL = Unknown/missing value (not zero, not empty string)
-- --------------------------------------------

-- Check for NULL:
SELECT first_name, last_name
FROM employees
WHERE commission_pct IS NULL;

-- Check for NOT NULL:
SELECT first_name, last_name
FROM employees
WHERE commission_pct IS NOT NULL;

-- Note: Cannot use = NULL or != NULL, must use IS NULL / IS NOT NULL

-- --------------------------------------------
-- 36. IN
-- Purpose: Checks if value is in a list
-- --------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE department_id IN (60, 80, 100);  -- Same as: dept = 60 OR dept = 80 OR dept = 100

SELECT first_name, last_name
FROM employees
WHERE last_name IN ('Weiss', 'Fripp', 'King');

-- --------------------------------------------
-- 37. BETWEEN
-- Purpose: Checks if value is within a range (inclusive)
-- --------------------------------------------
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 10000;  -- Same as: salary >= 5000 AND salary <= 10000

-- --------------------------------------------
-- 38. LIKE
-- Purpose: Pattern matching for text
-- % = Any characters (zero or more)
-- _ = Single character
-- --------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'K%';  -- Starts with K

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%a';  -- Ends with a

SELECT first_name, last_name
FROM employees
WHERE email LIKE '%@%';  -- Contains @

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '_a%';  -- Second letter is 'a'


-- ============================================
-- TABLE ALIASES
-- ============================================

-- --------------------------------------------
-- 39. Table Aliases
-- Purpose: Shortens table names in queries
-- Makes JOINs more readable
-- --------------------------------------------
SELECT 
    e.first_name,      -- e refers to employees
    e.last_name,
    d.department_name  -- d refers to departments
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Without aliases (more verbose):
SELECT 
    employees.first_name,
    employees.last_name,
    departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;


-- ============================================
-- DATA TYPES USED IN THIS PROJECT
-- ============================================

-- INT          - Whole numbers (e.g., employee_id, department_id)
-- VARCHAR(n)   - Variable-length text up to n characters (e.g., first_name VARCHAR(50))
-- CHAR(n)      - Fixed-length text of n characters (e.g., country_id CHAR(2))
-- DECIMAL(p,s) - Exact numeric with p total digits, s after decimal (e.g., salary DECIMAL(10,2))
-- DATE         - Date values in YYYY-MM-DD format (e.g., hire_date)
-- DATETIME     - Date and time in YYYY-MM-DD HH:MM:SS format (e.g., sales_timestamp)


-- ============================================
-- CONSTRAINTS USED IN THIS PROJECT
-- ============================================

-- PRIMARY KEY  - Uniquely identifies each row, cannot be NULL
-- FOREIGN KEY  - Links to primary key in another table, enforces referential integrity
-- NOT NULL     - Column cannot have NULL values (not explicitly used but implied for PKs)
-- UNIQUE       - All values in column must be different (not used but good to know)
-- DEFAULT      - Sets default value if none provided (not used but good to know)

-- ============================================
-- SUMMARY TABLE - SQL COMMANDS REFERENCE
-- ============================================
-- Category                        | Command            | Purpose
-- --------------------------------|--------------------|-----------------------------------------
-- DDL (Data Definition Language)  | CREATE DATABASE    | Create a new database
-- DDL (Data Definition Language)  | USE                | Select database to work with
-- DDL (Data Definition Language)  | CREATE TABLE       | Create a new table
-- DDL (Data Definition Language)  | ALTER TABLE        | Modify an existing table
-- DDL (Data Definition Language)  | DROP TABLE         | Delete a table
-- DDL (Data Definition Language)  | DROP DATABASE      | Delete a database
-- DDL (Data Definition Language)  | TRUNCATE           | Remove all data from table
-- --------------------------------|--------------------|-----------------------------------------
-- DML (Data Manipulation Language)| INSERT INTO        | Add new rows to a table
-- DML (Data Manipulation Language)| UPDATE             | Modify existing rows
-- DML (Data Manipulation Language)| DELETE             | Remove rows from a table
-- DML (Data Manipulation Language)| SELECT             | Retrieve data from tables
-- --------------------------------|--------------------|-----------------------------------------
-- TCL (Transaction Control Lang.) | START TRANSACTION  | Begin a transaction
-- TCL (Transaction Control Lang.) | COMMIT             | Save transaction permanently
-- TCL (Transaction Control Lang.) | ROLLBACK           | Undo transaction
-- TCL (Transaction Control Lang.) | SAVEPOINT          | Create a checkpoint in transaction
-- --------------------------------|--------------------|-----------------------------------------
-- DCL (Data Control Language)     | GRANT              | Give permissions to users
-- DCL (Data Control Language)     | REVOKE             | Remove permissions from users
-- --------------------------------|--------------------|-----------------------------------------
-- JOIN                            | JOIN / INNER JOIN  | Combine tables (matching rows only)
-- JOIN                            | LEFT JOIN          | Combine tables (all from left table)
-- JOIN                            | RIGHT JOIN         | Combine tables (all from right table)
-- JOIN                            | Self Join          | Join table to itself
-- --------------------------------|--------------------|-----------------------------------------
-- Subquery                        | Subquery           | Nested query inside another query
-- Subquery                        | Correlated         | Subquery referencing outer query
-- Subquery                        | IN / NOT IN        | Check if value exists in subquery
-- Subquery                        | ANY / ALL          | Compare to subquery results
-- --------------------------------|--------------------|-----------------------------------------
-- Aggregate Functions             | COUNT()            | Count the number of rows
-- Aggregate Functions             | SUM()              | Add up all values
-- Aggregate Functions             | AVG()              | Calculate the average
-- Aggregate Functions             | MAX()              | Find the highest value
-- Aggregate Functions             | MIN()              | Find the lowest value
-- Aggregate Functions             | GROUP BY           | Group rows for aggregation
-- Aggregate Functions             | HAVING             | Filter groups (like WHERE for groups)
-- --------------------------------|--------------------|-----------------------------------------
-- Conditional Functions           | CASE WHEN          | Conditional logic (IF-THEN-ELSE)
-- Conditional Functions           | COALESCE()         | Return first non-NULL value
-- Conditional Functions           | IFNULL()           | Replace NULL with specified value
-- Conditional Functions           | NULLIF()           | Return NULL if two values are equal
-- --------------------------------|--------------------|-----------------------------------------
-- Numeric Functions               | ROUND()            | Round numbers to decimal places
-- Numeric Functions               | CEIL()             | Round up to nearest integer
-- Numeric Functions               | FLOOR()            | Round down to nearest integer
-- Numeric Functions               | ABS()              | Absolute value
-- --------------------------------|--------------------|-----------------------------------------
-- Clauses                         | WHERE              | Filter rows based on condition
-- Clauses                         | ORDER BY           | Sort results (ASC or DESC)
-- Clauses                         | DISTINCT           | Remove duplicate rows
-- Clauses                         | LIMIT              | Restrict number of rows returned
-- Clauses                         | AS                 | Create column or table alias
-- --------------------------------|--------------------|-----------------------------------------
-- Comparison Operators            | =                  | Equal to
-- Comparison Operators            | <> or !=           | Not equal to
-- Comparison Operators            | >                  | Greater than
-- Comparison Operators            | <                  | Less than
-- Comparison Operators            | >=                 | Greater than or equal to
-- Comparison Operators            | <=                 | Less than or equal to
-- --------------------------------|--------------------|-----------------------------------------
-- Logical Operators               | AND                | Both conditions must be true
-- Logical Operators               | OR                 | At least one condition must be true
-- Logical Operators               | NOT                | Negates a condition
-- --------------------------------|--------------------|-----------------------------------------
-- Special Operators               | IN                 | Check if value is in a list
-- Special Operators               | NOT IN             | Check if value is NOT in a list
-- Special Operators               | BETWEEN            | Check if value is within a range
-- Special Operators               | LIKE               | Pattern matching with wildcards
-- Special Operators               | IS NULL            | Check if value is NULL
-- Special Operators               | IS NOT NULL        | Check if value is NOT NULL
-- --------------------------------|--------------------|-----------------------------------------
-- Wildcards (used with LIKE)      | %                  | Matches any characters (zero or more)
-- Wildcards (used with LIKE)      | _                  | Matches single character
-- --------------------------------|--------------------|-----------------------------------------
-- Variables                       | SET @variable      | Create user-defined variable
-- Variables                       | SELECT @variable   | Use variable in query
-- --------------------------------|--------------------|-----------------------------------------
-- Constraints                     | PRIMARY KEY        | Unique identifier for each row
-- Constraints                     | FOREIGN KEY        | Links to primary key in another table
-- Constraints                     | NOT NULL           | Column cannot have NULL values
-- Constraints                     | UNIQUE             | All values must be different
-- Constraints                     | DEFAULT            | Sets default value if none provided
-- Constraints                     | CHECK              | Validates data based on condition
-- --------------------------------|--------------------|-----------------------------------------
-- Data Types                      | INT                | Whole numbers
-- Data Types                      | VARCHAR(n)         | Variable-length text up to n chars
-- Data Types                      | CHAR(n)            | Fixed-length text of n characters
-- Data Types                      | DECIMAL(p,s)       | Exact numeric (p digits, s decimals)
-- Data Types                      | DATE               | Date (YYYY-MM-DD)
-- Data Types                      | DATETIME           | Date and time (YYYY-MM-DD HH:MM:SS)
-- Data Types                      | BOOLEAN            | True or False values
-- Data Types                      | TEXT               | Large text data
-- ============================================
```

---

## Visual Summary
```
┌─────────────────────────────────────────────────────────────────┐
│                    SQL COMMAND CATEGORIES                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌──────────────┐ │
│  │      DDL        │    │      DML        │    │     TCL      │ │
│  │ Data Definition │    │ Data Manipulate │    │ Transaction  │ │
│  ├─────────────────┤    ├─────────────────┤    ├──────────────┤ │
│  │ CREATE DATABASE │    │ INSERT          │    │ START TRANS. │ │
│  │ CREATE TABLE    │    │ UPDATE          │    │ COMMIT       │ │
│  │ ALTER TABLE     │    │ DELETE          │    │ ROLLBACK     │ │
│  │ DROP TABLE      │    │ SELECT          │    │ SAVEPOINT    │ │
│  │ TRUNCATE        │    │                 │    │              │ │
│  └─────────────────┘    └─────────────────┘    └──────────────┘ │
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐                     │
│  │      DCL        │    │     DQL         │                     │
│  │ Data Control    │    │ Data Query      │                     │
│  ├─────────────────┤    ├─────────────────┤                     │
│  │ GRANT           │    │ SELECT          │                     │
│  │ REVOKE          │    │                 │                     │
│  └─────────────────┘    └─────────────────┘                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘