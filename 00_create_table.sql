-- SQLite DDL for the enriched IBM HR analytics table
DROP TABLE IF EXISTS employee_data;
CREATE TABLE employee_data (
  Age INTEGER, Attrition TEXT, BusinessTravel TEXT, DailyRate INTEGER, Department TEXT,
  DistanceFromHome INTEGER, Education INTEGER, EducationField TEXT, EmployeeCount INTEGER,
  EmployeeNumber INTEGER PRIMARY KEY, EnvironmentSatisfaction INTEGER, Gender TEXT, HourlyRate INTEGER,
  JobInvolvement INTEGER, JobLevel INTEGER, JobRole TEXT, JobSatisfaction INTEGER, MaritalStatus TEXT,
  MonthlyIncome INTEGER, MonthlyRate INTEGER, NumCompaniesWorked INTEGER, Over18 TEXT, OverTime TEXT,
  PercentSalaryHike INTEGER, PerformanceRating INTEGER, RelationshipSatisfaction INTEGER, StandardHours INTEGER,
  StockOptionLevel INTEGER, TotalWorkingYears INTEGER, TrainingTimesLastYear INTEGER, WorkLifeBalance INTEGER,
  YearsAtCompany INTEGER, YearsInCurrentRole INTEGER, YearsSinceLastPromotion INTEGER, YearsWithCurrManager INTEGER,
  HireDate TEXT, ApproxExitDate TEXT, SnapshotDate TEXT, AttritionFlag INTEGER, AgeGroup TEXT, TenureBand TEXT,
  IncomeBand TEXT, SalaryPerYearAtCompany REAL
);
-- Load the CSV using your SQL client. For SQLite CLI:
-- .mode csv
-- .import data/ibm_hr_date_enabled.csv employee_data
