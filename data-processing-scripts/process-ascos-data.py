import pandas as pd
import numpy as np
import sys
import warnings

warnings.filterwarnings("ignore")

datapath = sys.argv[1]


########################
# Process Aerosol Data #
########################
print("Processing Aerosol Data")

bins = np.loadtxt(f'{datapath}/Dp05-11.txt')

times = pd.read_csv(f'{datapath}/StopTime05-11.txt', header=None)
times = pd.to_datetime(times.stack(), format="%d.%m.%Y %H:%M:%S").unstack()

data = pd.read_csv(f'{datapath}/InvertedMatrix30-03-2010.txt', delimiter=" ")
data.columns = bins
data['time'] = times
data = data.set_index('time')["2008-08-31"]

# Data is dN/dlogD, so calculate dlogD and multiply
dlogD = np.diff(np.log(bins)).mean()
data = data * dlogD

# Sum distribution
N = data.sum(axis=1)

N.to_csv(f'{datapath}/ascos_aerosol_N.csv', header=['N'])


####################
# Process Sounding #
####################
print("Processing Sounding")
sounding_columns = [
    'Height', 'Pressure', 'Time', 'Long', 'Lat', 'TempC', 'ThetaC', 'ThetaK', 'ThetaEC', 'Rhl',
    'Rhi', 'SpecHum', 'DewPt', 'Wspeed', 'Wdir', 'U', 'V'
]

sounding = pd.read_csv(f'{datapath}/Radiosonde_2008_08_31_0535.txt', 
    skiprows=3, sep="\s+|\t+|\s+\t+|\t+\s+", header=None, names=sounding_columns)

sounding.to_csv(f'{datapath}/Radiosonde_2008_08_31_0535.csv', index=False)