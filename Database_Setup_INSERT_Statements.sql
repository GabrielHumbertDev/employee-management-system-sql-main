-- ============================================
-- DATABASE SETUP - INSERT STATEMENTS
-- Sprint 3 Week 2 SQL - Epic 3.2: Employee Management System
-- ============================================

-- Make sure to use the company database
USE company;

-- ============================================
-- 1. INSERT INTO REGIONS
-- Purpose: Create sample geographic regions
-- Records: 4 rows
-- ============================================
INSERT INTO regions (region_id, region_name) VALUES
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

-- ============================================
-- 2. INSERT INTO COUNTRIES
-- Purpose: Create sample countries with region references
-- Records: 10 rows
-- ============================================
INSERT INTO countries (country_id, country_name, region_id) VALUES
('US', 'United States of America', 2),
('CA', 'Canada', 2),
('UK', 'United Kingdom', 1),
('DE', 'Germany', 1),
('IN', 'India', 3),
('AU', 'Australia', 3),
('SG', 'Singapore', 3),
('EG', 'Egypt', 4),
('IL', 'Israel', 4),
('NG', 'Nigeria', 4);

-- ============================================
-- 3. INSERT INTO LOCATIONS
-- Purpose: Create sample office locations with addresses
-- Records: 10 rows
-- ============================================
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1100, '93 King Street', 'M5V 2N7', 'Toronto', 'Ontario', 'CA'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40 Oxford Street', 'WC1A 1AB', 'London', 'Greater London', 'UK'),
(2100, '12 Alexanderplatz', '10178', 'Berlin', 'Berlin', 'DE'),
(2200, '100 MG Road', '560001', 'Bangalore', 'Karnataka', 'IN');

-- ============================================
-- 4. INSERT INTO JOBS
-- Purpose: Create sample job titles with salary ranges
-- Records: 10 rows
-- ============================================
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('IT_PROG', 'Programmer', 4000, 10000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('HR_REP', 'Human Resources Representative', 4000, 9000);

-- ============================================
-- 5. INSERT INTO DEPARTMENTS
-- Purpose: Create sample company departments
-- Note: manager_id is NULL initially, updated later
-- Records: 10 rows
-- ============================================
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
(10, 'Administration', NULL, 1700),
(20, 'Marketing', NULL, 1800),
(30, 'Purchasing', NULL, 1700),
(40, 'Human Resources', NULL, 2000),
(50, 'Shipping', NULL, 1500),
(60, 'IT', NULL, 1400),
(70, 'Public Relations', NULL, 2100),
(80, 'Sales', NULL, 1700),
(90, 'Executive', NULL, 1700),
(100, 'Finance', NULL, 1700);

-- ============================================
-- 6. INSERT INTO EMPLOYEES (Batch 1)
-- Purpose: Create executives, IT staff, and finance employees
-- Records: 10 rows
-- ============================================
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000.00, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000.00, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000.00, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000.00, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800.00, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800.00, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200.00, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12000.00, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000.00, NULL, 108, 100);

-- ============================================
-- 7. INSERT INTO EMPLOYEES (Batch 2)
-- Purpose: Create sales managers and sales representatives with commissions
-- Records: 10 rows
-- ============================================
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'ST_MAN', 11000.00, NULL, 100, 30),
(120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000.00, NULL, 100, 50),
(121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200.00, NULL, 100, 50),
(145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000.00, 0.40, 100, 80),
(146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500.00, 0.30, 100, 80),
(147, 'Alberto', 'Errazuriz', 'AERMDupriz', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000.00, 0.30, 100, 80),
(150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000.00, 0.30, 145, 80),
(151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500.00, 0.25, 145, 80),
(152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478268', '2005-08-20', 'SA_REP', 9000.00, 0.25, 145, 80),
(153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498268', '2006-03-30', 'SA_REP', 8000.00, 0.20, 145, 80);

-- ============================================
-- 8. INSERT INTO EMPLOYEES (Batch 3)
-- Purpose: Create more sales representatives including Kimberely Grant
-- Note: Kimberely Grant has NULL department_id (needed for User Story 9)
-- Records: 10 rows
-- ============================================
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(154, 'Nanette', 'Cambrault', 'NCAMBRA', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500.00, 0.20, 145, 80),
(155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000.00, 0.15, 145, 80),
(156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000.00, 0.35, 146, 80),
(157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500.00, 0.35, 146, 80),
(158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000.00, 0.35, 146, 80),
(159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000.00, 0.30, 146, 80),
(160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500.00, 0.30, 146, 80),
(161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000.00, 0.25, 146, 80),
(162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500.00, 0.25, 147, 80),
(178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000.00, 0.15, 145, NULL);

-- ============================================
-- 9. UPDATE DEPARTMENTS - Set Manager IDs
-- Purpose: Assign managers to departments after employees are created
-- Note: This must run AFTER employees are inserted
-- Records: 6 rows updated
-- ============================================
UPDATE departments SET manager_id = 100 WHERE department_id = 90;
UPDATE departments SET manager_id = 108 WHERE department_id = 100;
UPDATE departments SET manager_id = 103 WHERE department_id = 60;
UPDATE departments SET manager_id = 114 WHERE department_id = 30;
UPDATE departments SET manager_id = 120 WHERE department_id = 50;
UPDATE departments SET manager_id = 145 WHERE department_id = 80;

-- ============================================
-- 10. INSERT INTO CONSULTANTS
-- Purpose: Create sample consultants data
-- Note: Peter Tucker and David Bernstein exist in both employees and consultants
--       (needed for User Story 2 and User Story 9d)
-- Note: Susan Taylor's salary is used in User Story 9b
-- Records: 5 rows
-- ============================================
INSERT INTO consultants (consultant_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(1, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000.00, 0.30, 145, 80),
(2, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500.00, 0.25, 145, 80),
(3, 'Susan', 'Taylor', 'STAYLOR', '011.44.1349.123456', '2006-05-15', 'IT_PROG', 6500.00, NULL, 103, 60),
(4, 'James', 'Walker', 'JWALKER', '011.44.1349.654321', '2007-02-20', 'FI_ACCOUNT', 5500.00, NULL, 108, 100),
(5, 'Emily', 'Roberts', 'EROBERTS', '011.44.1349.987654', '2008-08-10', 'HR_REP', 4500.00, NULL, 101, 40);

-- ============================================
-- 11. INSERT INTO CUSTOMERS
-- Purpose: Create sample customer data for sales queries
-- Records: 10 rows
-- ============================================
INSERT INTO customers (cust_id, cust_email, cust_fname, cust_lname, cust_address, cust_city, cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit) VALUES
(1, 'john.doe@email.com', 'John', 'Doe', '123 Main St', 'Seattle', 'Washington', '98101', 'US', '206-555-0101', 5000.00),
(2, 'jane.smith@email.com', 'Jane', 'Smith', '456 Oak Ave', 'Toronto', 'Ontario', 'M5V 2N7', 'CA', '416-555-0102', 7500.00),
(3, 'bob.wilson@email.com', 'Bob', 'Wilson', '789 Pine Rd', 'London', 'Greater London', 'WC1A 1AB', 'UK', '020-555-0103', 10000.00),
(4, 'alice.brown@email.com', 'Alice', 'Brown', '321 Elm St', 'Berlin', 'Berlin', '10178', 'DE', '030-555-0104', 6000.00),
(5, 'charlie.davis@email.com', 'Charlie', 'Davis', '654 Maple Dr', 'Bangalore', 'Karnataka', '560001', 'IN', '080-555-0105', 4000.00),
(6, 'emma.johnson@email.com', 'Emma', 'Johnson', '987 Cedar Ln', 'Seattle', 'Washington', '98102', 'US', '206-555-0106', 8000.00),
(7, 'frank.miller@email.com', 'Frank', 'Miller', '147 Birch Way', 'Toronto', 'Ontario', 'M5V 3K7', 'CA', '416-555-0107', 5500.00),
(8, 'grace.lee@email.com', 'Grace', 'Lee', '258 Walnut St', 'London', 'Greater London', 'WC2B 4AB', 'UK', '020-555-0108', 9000.00),
(9, 'henry.taylor@email.com', 'Henry', 'Taylor', '369 Cherry Ave', 'Seattle', 'Washington', '98103', 'US', '206-555-0109', 3500.00),
(10, 'ivy.anderson@email.com', 'Ivy', 'Anderson', '480 Spruce Rd', 'Berlin', 'Berlin', '10179', 'DE', '030-555-0110', 7000.00);

-- ============================================
-- 12. INSERT INTO SALES (Batch 1)
-- Purpose: Create sample sales transactions
-- Records: 10 rows
-- ============================================
INSERT INTO sales (sales_id, sales_timestamp, sales_amt, sales_cust_id, sales_rep_id) VALUES
(1, '2024-01-15 10:30:00', 1500.00, 1, 150),
(2, '2024-01-16 14:45:00', 2300.00, 2, 150),
(3, '2024-01-17 09:15:00', 3200.00, 3, 151),
(4, '2024-01-18 16:00:00', 1800.00, 4, 151),
(5, '2024-01-19 11:30:00', 4500.00, 5, 152),
(6, '2024-01-20 13:00:00', 2100.00, 6, 152),
(7, '2024-01-21 15:30:00', 3800.00, 7, 153),
(8, '2024-01-22 10:00:00', 2900.00, 8, 153),
(9, '2024-01-23 14:15:00', 1200.00, 1, 150),
(10, '2024-01-24 09:45:00', 5600.00, 2, 156);

-- ============================================
-- 13. INSERT INTO SALES (Batch 2)
-- Purpose: Create more sample sales transactions
-- Records: 10 rows
-- Total Sales: 20 rows
-- ============================================
INSERT INTO sales (sales_id, sales_timestamp, sales_amt, sales_cust_id, sales_rep_id) VALUES
(11, '2024-01-25 11:00:00', 3100.00, 3, 156),
(12, '2024-01-26 14:30:00', 2400.00, 4, 157),
(13, '2024-01-27 10:15:00', 4200.00, 5, 157),
(14, '2024-01-28 16:45:00', 1900.00, 6, 158),
(15, '2024-01-29 09:00:00', 3500.00, 7, 158),
(16, '2024-01-30 13:30:00', 2800.00, 8, 159),
(17, '2024-01-31 15:00:00', 4100.00, 9, 159),
(18, '2024-02-01 10:45:00', 1700.00, 10, 160),
(19, '2024-02-02 14:00:00', 3300.00, 1, 160),
(20, '2024-02-03 11:30:00', 2600.00, 2, 162);

-- ============================================
-- 14. INSERT INTO JOB_HISTORY
-- Purpose: Create sample job history data for employees
-- Note: Needed for User Story 6 (employees who returned to original job)
-- Records: 6 rows
-- ============================================
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES
(101, '1997-09-21', '2001-10-27', 'FI_ACCOUNT', 100),
(101, '2001-10-28', '2005-03-15', 'FI_MGR', 100),
(102, '2001-01-13', '2006-07-24', 'IT_PROG', 60),
(104, '2003-01-01', '2007-05-20', 'ST_CLERK', 50),
(150, '2002-03-15', '2005-01-29', 'IT_PROG', 60),
(152, '2003-06-01', '2005-08-19', 'ST_CLERK', 50);

-- ============================================
-- 15. INSERT INTO SAL_GRADES
-- Purpose: Create salary grade levels
-- Records: 6 rows
-- ============================================
INSERT INTO sal_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000.00, 2999.00),
('B', 3000.00, 5999.00),
('C', 6000.00, 9999.00),
('D', 10000.00, 14999.00),
('E', 15000.00, 24999.00),
('F', 25000.00, 40000.00);

-- ============================================
-- ============================================
-- USER STORY 9e - INSERT INTO REGIONS
-- Purpose: Add new regions (South America and Africa)
-- Note: This is part of User Story 9 Transaction
-- Records: 2 rows
-- ============================================
-- ============================================

-- This INSERT is part of User Story 9 Transaction:
-- INSERT INTO regions (region_id, region_name) VALUES
-- (5, 'South America'),
-- (6, 'Africa');

-- ============================================
-- SUMMARY OF ALL INSERT STATEMENTS
-- ============================================
-- Table          | Records | Purpose
-- ---------------|---------|----------------------------------
-- regions        | 4       | Setup - Geographic regions
-- countries      | 10      | Setup - Countries with region FK
-- locations      | 10      | Setup - Office locations
-- jobs           | 10      | Setup - Job titles and salaries
-- departments    | 10      | Setup - Company departments
-- employees      | 30      | Setup - All employees (3 batches)
-- consultants    | 5       | Setup - Consultants data
-- customers      | 10      | Setup - Customer data
-- sales          | 20      | Setup - Sales transactions (2 batches)
-- job_history    | 6       | Setup - Employee job history
-- sal_grades     | 6       | Setup - Salary grade levels
-- regions (9e)   | 2       | User Story 9 - Add new regions
-- ---------------|---------|----------------------------------
-- TOTAL          | 123     | All setup data for User Stories
-- ============================================