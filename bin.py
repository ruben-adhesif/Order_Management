import pandas as pd
import numpy as np

df = pd.read_csv('data/productvendor.csv', sep=';', decimal=',')
lastreceiptcost = df['lastreceiptcost'].values
lastreceiptcost = np.sort(lastreceiptcost)