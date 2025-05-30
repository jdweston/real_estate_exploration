import pandas as pd
import polars as pl
#Read in the dimension csv files as dataframes and create column names
year_file = pd.read_csv('list_year.csv', header=None)
year_file.columns = ['year_id', 'list_year']

town_file = pd.read_csv('town.csv', header=None)
town_file.columns = ['town_id', 'town_name']

type_file = pd.read_csv('residential_type.csv', header=None)
type_file.columns = ['type_id', 'type_name']

#Read in the facts csv file and join the other dataframes to it
real_estate_df = pd.read_csv('real_estate.csv')

real_estate_merged = real_estate_df.merge(year_file,left_on='List Year',right_on='list_year',how='left')

real_estate_merge = real_estate_merged.merge(town_file,left_on='Town',right_on='town_name',how='left')

real_estate_merg = real_estate_merge.merge(type_file,left_on='Residential Type',right_on='type_name',how='left')

#Drop extra columns from merge
real_estate = real_estate_merg.drop(columns=['List Year', 'list_year', 'Town', 'town_name', 'Residential Type', 'type_name'])

#Convert to polars dataframe for export to a csv file for import
real_estate = pl.from_pandas(real_estate)

real_estate.write_csv('estate_facts.csv', include_header=False)