-- IBM HR Analytics & Employee Performance | SQL Analysis
-- Designed for SQLite / PostgreSQL-style SQL with minor date syntax adjustments.
-- Source table: employee_data

-- 1. Overall KPIs
SELECT COUNT(*) AS employees, SUM(AttritionFlag) AS leavers, ROUND(100.0*AVG(AttritionFlag),2) AS attrition_rate_pct, ROUND(AVG(MonthlyIncome),2) AS avg_monthly_income FROM employee_data;

-- 2. Attrition by department
SELECT Department, COUNT(*) employees, SUM(AttritionFlag) leavers, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct, ROUND(AVG(MonthlyIncome),2) avg_income, ROUND(AVG(PerformanceRating),2) avg_performance FROM employee_data GROUP BY Department ORDER BY attrition_rate_pct DESC;

-- 3. Attrition by tenure
SELECT TenureBand, COUNT(*) employees, SUM(AttritionFlag) leavers, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct FROM employee_data GROUP BY TenureBand ORDER BY CASE TenureBand WHEN '0-1 years' THEN 1 WHEN '2-3 years' THEN 2 WHEN '4-5 years' THEN 3 WHEN '6-10 years' THEN 4 ELSE 5 END;

-- 4. Overtime effect
SELECT OverTime, COUNT(*) employees, SUM(AttritionFlag) leavers, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct, ROUND(AVG(MonthlyIncome),2) avg_income FROM employee_data GROUP BY OverTime;

-- 5. Job role risk
SELECT JobRole, COUNT(*) employees, SUM(AttritionFlag) leavers, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct, ROUND(AVG(JobSatisfaction),2) avg_job_satisfaction FROM employee_data GROUP BY JobRole HAVING COUNT(*) >= 20 ORDER BY attrition_rate_pct DESC;

-- 6. Salary vs attrition
SELECT Attrition, COUNT(*) employees, ROUND(AVG(MonthlyIncome),2) avg_monthly_income, ROUND(AVG(PercentSalaryHike),2) avg_salary_hike FROM employee_data GROUP BY Attrition;

-- 7. Performance vs attrition (diagnostic, not causal)
SELECT PerformanceRating, COUNT(*) employees, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct, ROUND(AVG(MonthlyIncome),2) avg_income FROM employee_data GROUP BY PerformanceRating ORDER BY PerformanceRating;

-- 8. Job satisfaction vs attrition
SELECT JobSatisfaction, COUNT(*) employees, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct FROM employee_data GROUP BY JobSatisfaction ORDER BY JobSatisfaction;

-- 9. Department x job satisfaction
SELECT Department, JobSatisfaction, COUNT(*) employees, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct FROM employee_data GROUP BY Department, JobSatisfaction ORDER BY Department, JobSatisfaction;

-- 10. High-risk segment: overtime + low satisfaction + short tenure
SELECT COUNT(*) employees, SUM(AttritionFlag) leavers, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct FROM employee_data WHERE OverTime='Yes' AND JobSatisfaction <= 2 AND YearsAtCompany <= 3;

-- 11. Pay-equity diagnostic: income by performance rating and attrition
SELECT PerformanceRating, Attrition, COUNT(*) employees, ROUND(AVG(MonthlyIncome),2) avg_income FROM employee_data GROUP BY PerformanceRating, Attrition ORDER BY PerformanceRating, Attrition;

-- 12. Distance-from-home risk bands
SELECT CASE WHEN DistanceFromHome <=5 THEN '0-5' WHEN DistanceFromHome <=15 THEN '6-15' ELSE '16+' END distance_band, COUNT(*) employees, ROUND(100.0*AVG(AttritionFlag),2) attrition_rate_pct FROM employee_data GROUP BY distance_band ORDER BY distance_band;
