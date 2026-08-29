/* ================================================================
   IBM HR ANALYTICS – EMPLOYEE ATTRITION & PERFORMANCE
   VEDA TECHNOLOGY – DATA ANALYTICS TRACK – TASK 6

   Database  : MySQL 8.0+
   Dataset   : IBM HR Analytics Employee Attrition & Performance
   Rows      : 1,470
   Columns   : 35

   Objectives:
   1. Analyze employee attrition
   2. Identify major attrition drivers
   3. Analyze salary distribution
   4. Analyze department performance
   5. Analyze employee satisfaction
   6. Analyze overtime and workload
   7. Identify high-risk employee segments
   8. Support Power BI dashboard analysis

   ================================================================ */


/* ================================================================
   SECTION 1 – DATABASE SETUP
   ================================================================ */

CREATE DATABASE IF NOT EXISTS ibm_hr_analytics;

USE ibm_hr_analytics;


/* ================================================================
   SECTION 2 – CREATE EMPLOYEE TABLE
   ================================================================ */

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (

    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(10),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);


/* ================================================================
   SECTION 3 – LOAD DATA

   IMPORTANT:
   Change the file path according to your computer.

   Example:
   LOAD DATA LOCAL INFILE
   'C:/Users/YourName/Downloads/WA_Fn-UseC_-HR-Employee-Attrition.csv'
   ================================================================ */

/*
LOAD DATA LOCAL INFILE
'C:/path/to/WA_Fn-UseC_-HR-Employee-Attrition.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/


/* ================================================================
   SECTION 4 – DATA VALIDATION
   ================================================================ */


/* Total number of employees */

SELECT
    COUNT(*) AS total_employees
FROM employees;


/* Check duplicate EmployeeNumber */

SELECT
    EmployeeNumber,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


/* Check Attrition values */

SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;


/* Check departments */

SELECT
    Department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Department
ORDER BY employee_count DESC;


/* Check job roles */

SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM employees
GROUP BY JobRole
ORDER BY employee_count DESC;


/* ================================================================
   SECTION 5 – OVERALL HR KPIs
   ================================================================ */

SELECT

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS total_attrition,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent,

    ROUND(AVG(Age), 2) AS average_age,

    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income,

    ROUND(AVG(PerformanceRating), 2) AS average_performance_rating,

    ROUND(AVG(JobSatisfaction), 2) AS average_job_satisfaction,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company

FROM employees;


/* ================================================================
   SECTION 6 – ATTRITION ANALYSIS
   ================================================================ */


/* 6.1 Overall Attrition */

SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM employees),
        2
    ) AS percentage
FROM employees
GROUP BY Attrition;


/* ================================================================
   6.2 ATTRITION BY DEPARTMENT
   ================================================================ */

SELECT

    Department,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY Department

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   6.3 ATTRITION BY JOB ROLE
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY JobRole

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   6.4 ATTRITION BY GENDER
   ================================================================ */

SELECT

    Gender,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY Gender

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 7 – OVERTIME ANALYSIS
   ================================================================ */


/* Overtime versus attrition */

SELECT

    OverTime,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY OverTime

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 8 – TENURE ANALYSIS
   ================================================================ */


/* Create tenure groups */

SELECT

    CASE

        WHEN YearsAtCompany <= 1
            THEN '0-1 Years'

        WHEN YearsAtCompany <= 3
            THEN '2-3 Years'

        WHEN YearsAtCompany <= 5
            THEN '4-5 Years'

        WHEN YearsAtCompany <= 10
            THEN '6-10 Years'

        ELSE '10+ Years'

    END AS tenure_group,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY tenure_group

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 9 – AGE ANALYSIS
   ================================================================ */

SELECT

    CASE

        WHEN Age BETWEEN 18 AND 25
            THEN '18-25'

        WHEN Age BETWEEN 26 AND 35
            THEN '26-35'

        WHEN Age BETWEEN 36 AND 45
            THEN '36-45'

        WHEN Age BETWEEN 46 AND 55
            THEN '46-55'

        ELSE '56+'

    END AS age_group,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY age_group

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 10 – JOB SATISFACTION ANALYSIS
   ================================================================ */

SELECT

    JobSatisfaction,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY JobSatisfaction

ORDER BY JobSatisfaction;


/* ================================================================
   SECTION 11 – WORK-LIFE BALANCE
   ================================================================ */

SELECT

    WorkLifeBalance,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY WorkLifeBalance

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 12 – BUSINESS TRAVEL
   ================================================================ */

SELECT

    BusinessTravel,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY BusinessTravel

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 13 – SALARY ANALYSIS
   ================================================================ */


/* Average salary by department */

SELECT

    Department,

    COUNT(*) AS employees,

    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income,

    ROUND(MIN(MonthlyIncome), 2) AS minimum_income,

    ROUND(MAX(MonthlyIncome), 2) AS maximum_income

FROM employees

GROUP BY Department

ORDER BY average_monthly_income DESC;


/* ================================================================
   Salary versus Attrition
   ================================================================ */

SELECT

    Attrition,

    COUNT(*) AS employees,

    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income,

    ROUND(MIN(MonthlyIncome), 2) AS minimum_income,

    ROUND(MAX(MonthlyIncome), 2) AS maximum_income

FROM employees

GROUP BY Attrition;


/* ================================================================
   Salary Bands
   ================================================================ */

SELECT

    CASE

        WHEN MonthlyIncome < 3000
            THEN 'Below 3000'

        WHEN MonthlyIncome < 6000
            THEN '3000-5999'

        WHEN MonthlyIncome < 10000
            THEN '6000-9999'

        WHEN MonthlyIncome < 15000
            THEN '10000-14999'

        ELSE '15000+'

    END AS salary_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY salary_band

ORDER BY attrition_rate_percent DESC;


/* ================================================================
   SECTION 14 – PERFORMANCE ANALYSIS
   ================================================================ */


/* Performance rating versus attrition */

SELECT

    PerformanceRating,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_monthly_income

FROM employees

GROUP BY PerformanceRating

ORDER BY PerformanceRating;


/* ================================================================
   Performance versus salary
   ================================================================ */

SELECT

    PerformanceRating,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_monthly_income,

    ROUND(
        AVG(PercentSalaryHike),
        2
    ) AS average_salary_hike,

    COUNT(*) AS employee_count

FROM employees

GROUP BY PerformanceRating

ORDER BY PerformanceRating;


/* ================================================================
   SECTION 15 – JOB LEVEL ANALYSIS
   ================================================================ */

SELECT

    JobLevel,

    COUNT(*) AS employees,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_monthly_income,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY JobLevel

ORDER BY JobLevel;


/* ================================================================
   SECTION 16 – DEPARTMENT PERFORMANCE SUMMARY
   ================================================================ */

SELECT

    Department,

    COUNT(*) AS employee_count,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS attrition_count,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_salary,

    ROUND(
        AVG(PerformanceRating),
        2
    ) AS average_performance,

    ROUND(
        AVG(JobSatisfaction),
        2
    ) AS average_job_satisfaction,

    ROUND(
        AVG(WorkLifeBalance),
        2
    ) AS average_work_life_balance

FROM employees

GROUP BY Department

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 17 – DEPARTMENT × JOB ROLE
   ================================================================ */

SELECT

    Department,

    JobRole,

    COUNT(*) AS employee_count,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_income

FROM employees

GROUP BY
    Department,
    JobRole

ORDER BY
    attrition_rate DESC;


/* ================================================================
   SECTION 18 – DISTANCE FROM HOME
   ================================================================ */

SELECT

    CASE

        WHEN DistanceFromHome <= 5
            THEN '0-5 Miles'

        WHEN DistanceFromHome <= 10
            THEN '6-10 Miles'

        WHEN DistanceFromHome <= 20
            THEN '11-20 Miles'

        ELSE '20+ Miles'

    END AS distance_group,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY distance_group

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 19 – ENVIRONMENT SATISFACTION
   ================================================================ */

SELECT

    EnvironmentSatisfaction,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY EnvironmentSatisfaction

ORDER BY EnvironmentSatisfaction;


/* ================================================================
   SECTION 20 – RELATIONSHIP SATISFACTION
   ================================================================ */

SELECT

    RelationshipSatisfaction,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY RelationshipSatisfaction

ORDER BY RelationshipSatisfaction;


/* ================================================================
   SECTION 21 – TRAINING & DEVELOPMENT
   ================================================================ */

SELECT

    TrainingTimesLastYear,

    COUNT(*) AS employees,

    ROUND(
        AVG(PerformanceRating),
        2
    ) AS average_performance,

    ROUND(
        AVG(JobSatisfaction),
        2
    ) AS average_satisfaction,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY TrainingTimesLastYear

ORDER BY TrainingTimesLastYear;


/* ================================================================
   SECTION 22 – HIGH-RISK EMPLOYEE SEGMENT
   ================================================================

   Definition used for analytical segmentation:

   - Overtime = Yes
   - Job Satisfaction <= 2
   - Years at Company <= 3

   This is a risk segment, NOT a prediction model.
   ================================================================ */

SELECT

    COUNT(*) AS high_risk_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

WHERE
    OverTime = 'Yes'
    AND JobSatisfaction <= 2
    AND YearsAtCompany <= 3;


/* ================================================================
   SECTION 23 – HIGH-RISK GROUP BY DEPARTMENT
   ================================================================ */

SELECT

    Department,

    JobRole,

    COUNT(*) AS high_risk_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

WHERE
    OverTime = 'Yes'
    AND JobSatisfaction <= 2
    AND YearsAtCompany <= 3

GROUP BY
    Department,
    JobRole

HAVING COUNT(*) >= 5

ORDER BY
    attrition_rate DESC;


/* ================================================================
   SECTION 24 – LOW-SATISFACTION + OVERTIME
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

WHERE
    OverTime = 'Yes'
    AND JobSatisfaction <= 2

GROUP BY JobRole

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 25 – ATTRITION BY MARITAL STATUS
   ================================================================ */

SELECT

    MaritalStatus,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY MaritalStatus

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 26 – STOCK OPTION ANALYSIS
   ================================================================ */

SELECT

    StockOptionLevel,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY StockOptionLevel

ORDER BY StockOptionLevel;


/* ================================================================
   SECTION 27 – CAREER PROGRESSION
   ================================================================ */

SELECT

    JobRole,

    ROUND(
        AVG(YearsAtCompany),
        2
    ) AS average_years_at_company,

    ROUND(
        AVG(YearsInCurrentRole),
        2
    ) AS average_years_current_role,

    ROUND(
        AVG(YearsSinceLastPromotion),
        2
    ) AS average_years_since_promotion,

    ROUND(
        AVG(YearsWithCurrManager),
        2
    ) AS average_years_with_manager,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY JobRole

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 28 – EMPLOYEES WITH LONG PROMOTION WAIT
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS employees,

    ROUND(
        AVG(YearsSinceLastPromotion),
        2
    ) AS average_years_since_promotion,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

WHERE YearsSinceLastPromotion >= 5

GROUP BY JobRole

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 29 – COMPENSATION & PERFORMANCE
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS employees,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_income,

    ROUND(
        AVG(PercentSalaryHike),
        2
    ) AS average_salary_hike,

    ROUND(
        AVG(PerformanceRating),
        2
    ) AS average_performance,

    ROUND(
        AVG(JobSatisfaction),
        2
    ) AS average_satisfaction

FROM employees

GROUP BY JobRole

ORDER BY average_income DESC;


/* ================================================================
   SECTION 30 – HIGH PERFORMERS WHO LEFT
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS high_performer_leavers

FROM employees

WHERE
    Attrition = 'Yes'
    AND PerformanceRating >= 4

GROUP BY JobRole

ORDER BY high_performer_leavers DESC;


/* ================================================================
   SECTION 31 – LOW SALARY HIGH PERFORMERS
   ================================================================ */

SELECT

    JobRole,

    COUNT(*) AS employees,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS average_income,

    ROUND(
        AVG(PerformanceRating),
        2
    ) AS average_performance,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

WHERE
    PerformanceRating >= 4
    AND MonthlyIncome <
        (
            SELECT AVG(MonthlyIncome)
            FROM employees
        )

GROUP BY JobRole

ORDER BY attrition_rate DESC;


/* ================================================================
   SECTION 32 – DEPARTMENT × OVERTIME
   ================================================================ */

SELECT

    Department,

    OverTime,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    Department,
    OverTime

ORDER BY
    Department,
    attrition_rate DESC;


/* ================================================================
   SECTION 33 – DEPARTMENT × SATISFACTION
   ================================================================ */

SELECT

    Department,

    JobSatisfaction,

    COUNT(*) AS employees,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    Department,
    JobSatisfaction

ORDER BY
    Department,
    JobSatisfaction;


/* ================================================================
   SECTION 34 – JOB LEVEL × OVERTIME
   ================================================================ */

SELECT

    JobLevel,

    OverTime,

    COUNT(*) AS employees,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    JobLevel,
    OverTime

ORDER BY
    JobLevel,
    OverTime;


/* ================================================================
   SECTION 35 – FINAL MANAGEMENT SUMMARY
   ================================================================ */

SELECT

    Department,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes'
                THEN 1
            ELSE 0
        END
    ) AS leavers,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(
        AVG(MonthlyIncome),
        2
    ) AS avg_monthly_income,

    ROUND(
        AVG(PerformanceRating),
        2
    ) AS avg_performance,

    ROUND(
        AVG(JobSatisfaction),
        2
    ) AS avg_job_satisfaction,

    ROUND(
        AVG(YearsAtCompany),
        2
    ) AS avg_tenure,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN OverTime = 'Yes'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS overtime_percentage

FROM employees

GROUP BY Department

ORDER BY attrition_rate DESC;


/* ================================================================
   END
   ================================================================ */
