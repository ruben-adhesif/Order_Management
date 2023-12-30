""" clean.py
The raw .csv file on this folder are directly download from DVL
When it's run, this .py file :
- remove the blank space to easy the manipulation
- convert some float in int to have coherant foreign key
- convert True/False in T/F to easy sqlldr
- store the clean .csv file on the data folder
"""

import pandas as pd

def initialisation(csv_file):
    df = pd.read_csv(fr'raw/{csv_file}', delimiter=';')
    df.columns = df.columns.str.strip()
    df = df.apply(lambda x: x.str.strip() if x.dtype == 'object' else x)
    return df

def update(df, csv_file):
    df = df.dropna()
    df = df.reset_index(drop=True)
    df.to_csv(csv_file, index=False, sep=';', decimal='.')

csv_file = 'productvendor.csv'
df = initialisation(csv_file)
update(df, csv_file)

csv_file = 'purchaseorderdetail.csv'
df = initialisation(csv_file)
# convert some float in int to have coherent foreign key
for column_name in ["purchaseorderid", "purchaseorderdetailid", "orderqty", "productid", "receivedqty", "rejectedqty"]:
    # no null value but force to add .fillna(-1)
    df[column_name] = df[column_name].fillna(-1).astype(int)
update(df, csv_file)

csv_file = 'purchaseorderheader.csv'
df = initialisation(csv_file)
update(df, csv_file)

csv_file = 'vendor.csv'
df = initialisation(csv_file)
# convert True/False in T/F to easy sqlldr
for column_name in ["preferredvendorstatus", "activeflag"]:
    df[column_name] = df[column_name].replace('true', 'T')
    df[column_name] = df[column_name].replace('false', 'F')
update(df, csv_file)