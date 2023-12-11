""" clean.py
The raw .csv file on this folder are directly download from DVL
When it's run, this .py file :
- remove the blank space to easy the manipulation
- remove the miliseconds at the end of the date to let sql convert to Datetime and not String
- store the clean .csv file on the data folder
"""

import pandas as pd

def initialisation(csv_file):
    df = pd.read_csv(fr'raw/{csv_file}', delimiter=';')
    df.columns = df.columns.str.strip()
    df = df.apply(lambda x: x.str.strip() if x.dtype == 'object' else x)
    return df
  
def del_millisec(df, date):
    #df[date] = pd.to_datetime(df[date]).dt.floor('s')
    return df

def convert_bool(df, bool):
    df[bool] = df[bool].replace('true', 'T')
    df[bool] = df[bool].replace('false', 'F')
    return df

def update(df, csv_file):
    df = df.dropna()
    df = df.reset_index(drop=True)
    df.to_csv(csv_file, index=False, sep=';',decimal='.')

csv_file = 'productvendor.csv'
df = initialisation(csv_file)
df = del_millisec(df, 'lastreceiptdate')
df = del_millisec(df, 'modifieddate')
update(df, csv_file)

csv_file = 'purchaseorderdetail.csv'
df = initialisation(csv_file)
df = del_millisec(df, 'duedate')
df = del_millisec(df, 'modifieddate')
update(df, csv_file)

csv_file = 'purchaseorderheader.csv'
df = initialisation(csv_file)
df = del_millisec(df, 'orderdate')
df = del_millisec(df, 'shipdate')
df = del_millisec(df, 'modifieddate')
update(df, csv_file)

csv_file = 'vendor.csv'
df = initialisation(csv_file)
df = del_millisec(df, 'modifieddate')
df = convert_bool(df, 'preferredvendorstatus')
df = convert_bool(df, 'activeflag')
update(df, csv_file)