# IBM HR Analytics – Employee Attrition & Performance Analysis

![HR Analytics](https://img.shields.io/badge/Project-HR%20Analytics-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Excel](https://img.shields.io/badge/Excel-Analysis-green)
![SQL](https://img.shields.io/badge/SQL-Analysis-orange)
![Python](https://img.shields.io/badge/Python-Data%20Analysis-blue)

## 📌 Project Overview

This project analyzes employee workforce data to understand:

- Employee attrition and retention
- Department-level workforce trends
- Salary and compensation distribution
- Employee performance
- Job satisfaction
- Overtime and workload
- Tenure-related attrition
- Job-role-level attrition
- Factors associated with employee turnover

The project was completed as part of the **Veda Technology – Data Analytics Track, Level 2, Day 6 – Task 6: HR Analytics & Employee Performance**.

The analysis uses the standard **IBM HR Analytics Employee Attrition & Performance** dataset and presents the results through Excel, SQL and Power BI.

---

# 🎯 Business Objective

The primary objective is to investigate:

1. What factors are associated with employee attrition?
2. How does attrition vary across departments?
3. How does salary vary across departments and employee groups?
4. How does employee performance relate to compensation and attrition?
5. Which employee segments should HR prioritize for retention initiatives?

---

# 🧩 Business Questions

The analysis answers the following questions:

- What is the overall employee attrition rate?
- Which departments have the highest attrition?
- Which job roles have the highest attrition?
- Does overtime increase attrition risk?
- How does employee tenure affect attrition?
- Does age influence employee turnover?
- Is lower job satisfaction associated with higher attrition?
- How does salary vary across departments?
- Is compensation associated with employee retention?
- Does performance rating explain employee attrition?
- Which employee segments represent the highest retention risk?
- What actions can HR take to improve employee retention?

---

# 📊 Dataset

## IBM HR Analytics Employee Attrition & Performance

The standard IBM HR Analytics dataset contains:

- **1,470 employees**
- **35 employee-related attributes**

Important variables include:

| Category | Variables |
|---|---|
| Employee | EmployeeNumber, EmployeeCount, StandardHours |
| Demographics | Age, Gender, MaritalStatus, Education |
| Work | Department, JobRole, JobLevel |
| Compensation | MonthlyIncome, DailyRate, HourlyRate, MonthlyRate |
| Career | TotalWorkingYears, YearsAtCompany, YearsInCurrentRole |
| Satisfaction | JobSatisfaction, EnvironmentSatisfaction, RelationshipSatisfaction |
| Performance | PerformanceRating, JobInvolvement |
| Workload | OverTime, BusinessTravel, DistanceFromHome |
| Retention | Attrition |
| Benefits | StockOptionLevel, TrainingTimesLastYear |

---

# ⚠️ Dataset & Date-Enabled Methodology

The standard IBM HR Analytics dataset is a static employee-level dataset and does not contain a genuine historical employee event date suitable for time-series analysis.

To support date-enabled dashboard analysis, this project includes a separate analytical date layer.

The following fields are derived analytical fields:

- HireDate
- SnapshotDate
- ApproxExitDate
- TenureBand
- AgeGroup
- IncomeBand
- AttritionFlag

These derived dates are **not represented as original historical dates from IBM**.

They are used only to enable time-oriented analytical views and should not be interpreted as actual employee event records.

---

# 🛠️ Tools & Technologies

The project uses:

### Microsoft Excel

Used for:

- Data inspection
- Data cleaning
- Pivot-style analysis
- Department analysis
- Attrition analysis
- Salary analysis
- Summary tables

### SQL

Used for:

- Aggregation
- Grouping
- Filtering
- Attrition analysis
- Department analysis
- Salary analysis
- Employee segmentation
- Business-question analysis

### Power BI

Used for:

- Interactive dashboard
- KPI cards
- Attrition analysis
- Department analysis
- Job-role analysis
- Salary analysis
- Performance analysis
- HR action dashboard

### Python

Used for:

- Data preparation
- Analytical calculations
- Dataset validation
- Chart generation
- Supporting project automation

---

# 📁 Project Structure

```text
IBM-HR-Analytics-Employee-Performance/
│
├── README.md
├── LICENSE
├── requirements.txt
├── .gitignore
│
├── data/
│   ├── ibm_hr_standard_schema.csv
│   ├── ibm_hr_date_enabled.csv
│   └── date_dimension.csv
│
├── excel/
│   └── IBM_HR_Analytics_Analysis.xlsx
│
├── sql/
│   ├── 00_create_table.sql
│   └── hr_attrition_analysis.sql
│
├── python/
│   ├── analysis.py
│   ├── build_project.py
│   └── create_preview.py
│
├── powerbi/
│   ├── DAX_Measures.txt
│   ├── Dashboard_Specification.md
│   ├── IBM_HR_Theme.json
│   ├── PowerQuery_EmployeeData.m
│   └── README_POWER_BI.md
│
├── screenshots/
│   ├── 00_powerbi_dashboard_preview.png
│   ├── 01_attrition_by_department.png
│   ├── 02_attrition_by_role.png
│   ├── 03_attrition_by_tenure.png
│   └── 04_overtime_attrition.png
│
├── reports/
│   └── IBM_HR_Analytics_Complete_Report.pdf
│
└── docs/
    ├── GitHub_Steps.md
    ├── Interview_QA.md
    ├── PowerBI_Build_Steps.md
    └── Submission_Checklist.md
