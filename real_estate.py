#import the necessary libraries 
import polars as pl 
import pandas as pd
#load the source parquet file into a dataframe
df = pl.read_parquet("Real Estate Sales 2001-2022.parquet")

#initial analysis to find out the range of data that is within the dataframe and see what will be needed 
df.describe()
df.shape

#filter out only the information that is going to be used in further analysis, making sure there are no missing values
df = df.select(['Serial Number','List Year','Town','Assessed Value','Sale Amount','Sales Ratio','Residential Type'])
df = df.filter(pl.col('List Year') >= 2015, pl.col('Residential Type').is_not_null())
df = df.with_columns(pl.col('Sales Ratio').round(2))

#create separate dataframes for specific columns to be turned into csv files for dimension tables 
town_df = df['Town'].value_counts().sort('Town')
town = town_df.with_columns(pl.Series("index", range(1, town_df.height + 1)))
town = town.select(["index"] + [col for col in town.columns if col != "index"])
town = town.drop("count")

year_df = df['List Year'].value_counts().sort('List Year')
year = year_df.with_columns(pl.Series("index", range(1, year_df.height + 1)))
year = year.select(["index"] + [col for col in year.columns if col != "index"])
year = year.drop("count")

res = df['Residential Type'].value_counts()
res_type = res.with_columns(pl.Series("index", range(1, res.height + 1)))
res_type = res_type.select(["index"] + [col for col in res_type.columns if col != "index"])
res_type = res_type.drop("count")

#load the cleaned and transformed dataframes into new files
df.write_parquet('real_estate.parquet')
town.write_csv('town.csv', include_header=False)
year.write_csv('list_year.csv', include_header=False)
res_type.write_csv('residential_type.csv', include_header=False)
df.write_csv('real_estate.csv')

