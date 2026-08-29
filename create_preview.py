import pandas as pd, matplotlib.pyplot as plt
from pathlib import Path
ROOT=Path('/mnt/data/IBM_HR_Analytics_Project')
df=pd.read_csv(ROOT/'data/ibm_hr_date_enabled.csv')
df['AttritionFlag']=(df.Attrition=='Yes').astype(int)
fig=plt.figure(figsize=(16,9))
fig.suptitle('IBM HR Analytics — Employee Attrition & Performance',fontsize=22,weight='bold')
# KPI text
kpis=[('Employees',f"{len(df):,}"),('Leavers',f"{df.AttritionFlag.sum():,}"),('Attrition Rate',f"{df.AttritionFlag.mean():.1%}"),('Avg Income',f"{df.MonthlyIncome.mean():,.0f}"),('Avg Performance',f"{df.PerformanceRating.mean():.2f}")]
for i,(a,b) in enumerate(kpis):
    ax=fig.add_axes([0.04+i*0.19,0.80,0.17,0.11]); ax.axis('off'); ax.text(.5,.62,b,ha='center',va='center',fontsize=22,weight='bold'); ax.text(.5,.18,a,ha='center',va='center',fontsize=10)
# charts
ax1=fig.add_axes([0.07,0.48,0.40,0.25]); s=df.groupby('Department').AttritionFlag.mean().sort_values(); ax1.barh(s.index,s.values*100); ax1.set_title('Attrition Rate by Department'); ax1.set_xlabel('%')
ax2=fig.add_axes([0.55,0.48,0.38,0.25]); s=df.groupby('OverTime').AttritionFlag.mean(); ax2.bar(s.index,s.values*100); ax2.set_title('Overtime vs Attrition'); ax2.set_ylabel('%')
ax3=fig.add_axes([0.07,0.10,0.40,0.25]); s=df.groupby('AgeGroup',observed=True).AttritionFlag.mean(); ax3.bar(s.index.astype(str),s.values*100); ax3.set_title('Attrition by Age Group'); ax3.set_ylabel('%'); ax3.tick_params(axis='x',rotation=20)
ax4=fig.add_axes([0.55,0.10,0.38,0.25]); s=df.groupby('TenureBand',observed=True).AttritionFlag.mean(); ax4.bar(s.index.astype(str),s.values*100); ax4.set_title('Attrition by Tenure Band'); ax4.set_ylabel('%'); ax4.tick_params(axis='x',rotation=20)
fig.savefig(ROOT/'screenshots/00_powerbi_dashboard_preview.png',bbox_inches='tight')
