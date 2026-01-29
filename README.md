#  Employee Management System SQL


## Project Overview
This project demonstrates SQL skills for managing an Employee Management System database. It includes database creation, table design, data manipulation, and complex queries.

## Database Structure
The `company` database contains 11 tables:

| Table | Description |
|-------|-------------|
| regions | Geographic regions |
| countries | Countries with region references |
| locations | Office locations with addresses |
| departments | Company departments |
| employees | Employee information |
| jobs | Job titles and salary ranges |
| job_history | Employee job change history |
| sal_grades | Salary grade levels |
| consultants | Consultant information |
| customers | Customer information |
| sales | Sales transactions |

## Entity Relationship Diagram
![Company ERD](ERD.png)

## Files Included
| File | Description |
|------|-------------|
| Sprint3_Week2_SQL_Queries.sql | All SQL queries for user stories |
| Company_ERD.png | Entity Relationship Diagram |
| README.md | Project documentation |

## User Stories Completed

### Main Stories (9/9)
1. **Highest Paid Employee** - Query to display details of the highest paid employee including name, salary, job ID, department, city, and country
2. **Employees Still Listed as Consultants** - Find employees who appear in both employees and consultants tables
3. **Customer Sales Information** - Comprehensive customer report with sales aggregations
4. **Department Managers** - Display managers responsible for departments with location details
5. **Employees Earning >= Managers** - Find employees earning same or more than their managers
6. **Employees Returned to Original Job** - Identify employees who returned to a previous job
7. **Non-Managers Earning More Than Managers** - Find non-managers with higher salaries than some managers
8. **Employee Count by Region** - Count employees per geographic region
9. **Transaction Updates** - Multiple UPDATE/DELETE/INSERT operations in a transaction

### Bonus Stories (4/4)
1. **Biggest Sale by Sales Rep** - Show each sales representative's largest sale with details
2. **Commissioned Employees Above Average** - Find commissioned employees with above-average total pay
3. **Sales Manager Compensation** - Calculate total compensation for sales managers
4. **Customer Largest Sale Details** - Show largest sale for each customer with full details

## SQL Concepts Demonstrated
- **DDL**: CREATE DATABASE, CREATE TABLE
- **DML**: INSERT, UPDATE, DELETE
- **Queries**: SELECT with multiple JOINs
- **Joins**: INNER JOIN, LEFT JOIN, Self-joins
- **Subqueries**: Correlated and non-correlated subqueries
- **Aggregations**: SUM, AVG, MAX, COUNT
- **Grouping**: GROUP BY, HAVING
- **Transactions**: START TRANSACTION, COMMIT
- **Variables**: Using @ variables to avoid hard-coding

## How to Run
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. Open the file `SQL_Queries.sql`
4. Execute the queries using the lightning bolt icon (⚡)



***
## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Authors
- Gabriel Humbert

  - GitHub: [GabrielHumbertDev](https://github.com/GabrielHumbertDev)  
  - Email: gabrielhumbert@outlook.com

---


## Support

For questions or support:
- Create an issue in the GitHub repository
- Contact the development team
- Review documentation in the `docs/` folder

---


