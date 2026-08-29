# Power BI Dashboard Build Specification

## Page 1 — Executive Overview
KPI cards: Total Employees, Leavers, Attrition Rate, Avg Monthly Income, Avg Performance Rating.
Visuals: Attrition Rate by Department (clustered bar), Attrition by Job Role (horizontal bar), Attrition by Tenure Band (column), Attrition by OverTime (donut), Avg Income by Attrition (clustered column).
Slicers: Department, Job Role, OverTime, Age Group, Tenure Band.

## Page 2 — Attrition Drivers
Visuals: Attrition Rate by Age Group, Job Satisfaction, Work-Life Balance, Business Travel, Distance Band, Marital Status. Add a matrix of Department x Job Role with conditional formatting.

## Page 3 — Performance & Pay Equity
Visuals: Avg Income by Performance Rating and Attrition, Performance Rating distribution, Avg Income by Department, Salary Hike vs Performance, Performance x Job Satisfaction matrix.

## Page 4 — HR Action Center
Show the top 5 risk segments using a table with Department, Job Role, OverTime, Tenure Band, Job Satisfaction, Attrition Rate, Employees. Add a text box with recommended actions.

## Date-enabled model
Import DateDimension and EmployeeData. Relate DateDimension[Date] to EmployeeData[HireDate]. The original IBM dataset does not contain actual event dates; HireDate/ApproxExitDate/SnapshotDate in this project are derived analytical fields and must not be presented as historical source facts.
