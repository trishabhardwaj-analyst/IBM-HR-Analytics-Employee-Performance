import pandas as pd
df=pd.read_csv("../data/ibm_hr_date_enabled.csv", parse_dates=["HireDate","ApproxExitDate","SnapshotDate"])
df["AttritionFlag"]=(df["Attrition"]=="Yes").astype(int)
print(df.groupby("Department")["AttritionFlag"].agg(["count","sum","mean"]))
print(df.groupby("OverTime")["AttritionFlag"].agg(["count","sum","mean"]))
print(df.groupby("JobRole")["AttritionFlag"].agg(["count","sum","mean"]).sort_values("mean",ascending=False))
