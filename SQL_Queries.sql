-- ============================================
-- Sprint 3 Week 2 SQL - Epic 3.2: Employee Management System
-- ============================================

-- Make sure to use the company database
USE company;

-- ============================================
-- USER STORY 1: Highest Paid Employee
-- ============================================
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    e.job_id,
    d.department_name,
    l.city,
    c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE e.salary = (SELECT MAX(salary) FROM employees);

-- ============================================
-- USER STORY 2: Employees Still Listed as Consultants
-- ============================================
SELECT 
    e.first_name,
    e.last_name,
    e.job_id,
    e.salary,
    e.manager_id
FROM employees e
JOIN consultants c 
    ON e.first_name = c.first_name 
    AND e.last_name = c.last_name
ORDER BY e.last_name;

-- ============================================
-- USER STORY 3: Customer Sales Information
-- ============================================
SELECT 
    c.cust_id,
    c.cust_fname,
    c.cust_lname,
    c.cust_city,
    COALESCE(MAX(s.sales_amt), 0) AS largest_sale,
    COALESCE(SUM(s.sales_amt), 0) AS total_sales,
    CASE 
        WHEN SUM(s.sales_amt) > 0 
        THEN ROUND((MAX(s.sales_amt) / SUM(s.sales_amt)) * 100, 2)
        ELSE 0 
    END AS largest_sale_pct,
    COALESCE(ROUND(AVG(s.sales_amt), 2), 0) AS avg_sales,
    COUNT(s.sales_id) AS transaction_count
FROM customers c
LEFT JOIN sales s ON c.cust_id = s.sales_cust_id
GROUP BY c.cust_id, c.cust_fname, c.cust_lname, c.cust_city
ORDER BY c.cust_id;

-- ============================================
-- USER STORY 4: Managers Responsible for Departments
-- ============================================
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    l.street_address,
    l.city,
    l.state_province
FROM employees e
JOIN departments d ON e.employee_id = d.manager_id
JOIN locations l ON d.location_id = l.location_id
ORDER BY d.department_id;

-- ============================================
-- USER STORY 5: Employees Earning Same or More Than Their Managers
-- ============================================
SELECT 
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    e.job_id AS employee_job_id,
    e.salary AS employee_salary,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    m.job_id AS manager_job_id,
    m.salary AS manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary >= m.salary;

-- ============================================
-- USER STORY 6: Employees Who Returned to Original Job
-- ============================================
SELECT DISTINCT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_id,
    e.salary
FROM employees e
JOIN job_history jh 
    ON e.employee_id = jh.employee_id 
    AND e.job_id = jh.job_id;

-- ============================================
-- USER STORY 7: Non-Managers Earning More Than Any Manager
-- ============================================
SELECT 
    e.first_name,
    e.last_name,
    e.job_id,
    e.salary
FROM employees e
WHERE e.employee_id NOT IN (
    SELECT DISTINCT manager_id 
    FROM employees 
    WHERE manager_id IS NOT NULL
)
AND e.salary > ANY (
    SELECT salary 
    FROM employees 
    WHERE employee_id IN (
        SELECT DISTINCT manager_id 
        FROM employees 
        WHERE manager_id IS NOT NULL
    )
)
ORDER BY e.salary;

-- ============================================
-- USER STORY 8: Employee Count by Region
-- ============================================
SELECT 
    COALESCE(r.region_name, 'Unassigned') AS region_name,
    COUNT(e.employee_id) AS employee_count
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN countries c ON l.country_id = c.country_id
LEFT JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY region_name;

-- ============================================
-- USER STORY 9: Transaction Updates
-- ============================================
SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;

-- 9a: Update Kimberely Grant's department and first name
SET @sales_dept = (SELECT DISTINCT department_id FROM employees WHERE job_id = 'SA_REP' AND department_id IS NOT NULL LIMIT 1);

UPDATE employees
SET department_id = @sales_dept,
    first_name = 'Kimberly'
WHERE first_name = 'Kimberely' AND last_name = 'Grant';

-- 9b: Update Weiss and Fripp salaries to match consultant Taylor
SET @taylor_salary = (SELECT salary FROM consultants WHERE last_name = 'Taylor');

UPDATE employees
SET salary = @taylor_salary
WHERE last_name IN ('Weiss', 'Fripp');

-- 9c: Update region names
UPDATE regions
SET region_name = 'North America'
WHERE region_name = 'Americas';

UPDATE regions
SET region_name = 'Middle East'
WHERE region_name = 'Middle East and Africa';

-- 9d: Remove consultants who are now full-time employees
DELETE FROM consultants
WHERE (first_name, last_name) IN (
    SELECT first_name, last_name FROM employees
);

-- 9e: Add new regions
INSERT INTO regions (region_id, region_name) VALUES
(5, 'South America'),
(6, 'Africa');

COMMIT;

-- ============================================
-- BONUS STORY 1: Biggest Sale by Each Sales Rep
-- ============================================
SELECT 
    e.employee_id AS sales_rep_id,
    e.first_name,
    e.last_name,
    s.sales_amt AS largest_sale,
    s.sales_timestamp,
    c.cust_id AS customer_id,
    c.cust_lname AS customer_last_name
FROM employees e
JOIN sales s ON e.employee_id = s.sales_rep_id
JOIN customers c ON s.sales_cust_id = c.cust_id
WHERE s.sales_amt = (
    SELECT MAX(s2.sales_amt)
    FROM sales s2
    WHERE s2.sales_rep_id = e.employee_id
)
ORDER BY e.employee_id;

-- ============================================
-- BONUS STORY 2: Commissioned Employees Above Average Total Pay
-- ============================================
SELECT 
    e.first_name,
    e.last_name,
    (e.salary + (e.commission_pct * COALESCE(SUM(s.sales_amt), 0))) AS total_pay
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.sales_rep_id
WHERE e.commission_pct IS NOT NULL
GROUP BY e.employee_id, e.first_name, e.last_name, e.salary, e.commission_pct
HAVING (e.salary + (e.commission_pct * COALESCE(SUM(s.sales_amt), 0))) > (
    SELECT AVG(emp_total_pay)
    FROM (
        SELECT (e2.salary + (e2.commission_pct * COALESCE(SUM(s2.sales_amt), 0))) AS emp_total_pay
        FROM employees e2
        LEFT JOIN sales s2 ON e2.employee_id = s2.sales_rep_id
        WHERE e2.commission_pct IS NOT NULL
        GROUP BY e2.employee_id, e2.salary, e2.commission_pct
    ) AS avg_calc
)
ORDER BY total_pay;

-- ============================================
-- BONUS STORY 3: Total Compensation for Sales Managers
-- ============================================
SELECT 
    m.employee_id AS manager_employee_id,
    m.last_name AS manager_last_name,
    (m.salary + (m.commission_pct * COALESCE(SUM(s.sales_amt), 0))) AS total_compensation
FROM employees m
JOIN employees e ON m.employee_id = e.manager_id
LEFT JOIN sales s ON e.employee_id = s.sales_rep_id
WHERE m.commission_pct IS NOT NULL
GROUP BY m.employee_id, m.last_name, m.salary, m.commission_pct
ORDER BY m.employee_id;

-- ============================================
-- BONUS STORY 4: Largest Sale for Every Customer with Details
-- ============================================
SELECT 
    e.last_name AS sales_rep_last_name,
    m.last_name AS manager_last_name,
    c.cust_fname AS customer_first_name,
    c.cust_lname AS customer_last_name,
    c.cust_city AS customer_city,
    c.cust_country AS customer_country,
    s.sales_amt AS largest_sale
FROM sales s
JOIN customers c ON s.sales_cust_id = c.cust_id
JOIN employees e ON s.sales_rep_id = e.employee_id
LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE s.sales_amt = (
    SELECT MAX(s2.sales_amt)
    FROM sales s2
    WHERE s2.sales_cust_id = s.sales_cust_id
)
ORDER BY e.last_name;