let
    Source = Csv.Document(File.Contents("data/ibm_hr_date_enabled.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders,{{"Age",Int64.Type},{"Attrition",type text},{"Department",type text},{"MonthlyIncome",Int64.Type},{"PerformanceRating",Int64.Type},{"JobSatisfaction",Int64.Type},{"YearsAtCompany",Int64.Type},{"HireDate",type date},{"ApproxExitDate",type date},{"SnapshotDate",type date}}),
    AddAttritionFlag = Table.AddColumn(ChangedTypes,"Attrition Flag",each if [Attrition]="Yes" then 1 else 0,Int64.Type),
    AddAgeGroup = Table.AddColumn(AddAttritionFlag,"Age Group",each if [Age]<=25 then "18-25" else if [Age]<=34 then "26-34" else if [Age]<=44 then "35-44" else "45+",type text),
    AddTenureBand = Table.AddColumn(AddAgeGroup,"Tenure Band",each if [YearsAtCompany]<=1 then "0-1 years" else if [YearsAtCompany]<=3 then "2-3 years" else if [YearsAtCompany]<=5 then "4-5 years" else if [YearsAtCompany]<=10 then "6-10 years" else "11+ years",type text)
in
    AddTenureBand