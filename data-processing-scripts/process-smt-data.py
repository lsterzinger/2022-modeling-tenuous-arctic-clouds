from netCDF4 import Dataset
import xarray as xr
import numpy as np
import sys

import warnings
warnings.filterwarnings('ignore')

datadir = sys.argv[1]

files = [
    datadir + '/smtmmcrmomX1.b1.20190701.000000.cdf',
    datadir + '/smtmmcrmomX1.b1.20190702.000000.cdf',
]

datasets = []

for fpath in files:
    smt_rad = Dataset(fpath)


    t = np.datetime64('1970-01-01T00:00:00') + np.timedelta64(int(smt_rad['base_time'][:]), 's')

    smt_time = []
    for dt in smt_rad['time_offset'][:]:
    #     print(dt)
        smt_time.append(t + np.timedelta64(int(dt), 's'))
        
    mode = smt_rad['ModeNum'][:]
    refl = smt_rad["Reflectivity"][:]

    refl_mode1 = np.zeros((np.count_nonzero(mode == 1), refl.shape[1]), np.float32)
    time_mode1 = []

    j=0
    for i,m in enumerate(mode):
        if m == 1:
            refl_mode1[j, :] = refl[i,:]
            time_mode1.append(smt_time[i])
            j+=1
            
    refl_mode1[refl_mode1 == 9.96921e+36] = np.nan

    heights = smt_rad['heights'][1,:]

    outdata = xr.Dataset(
        data_vars = dict(
            refl_mode1 = (['time', 'height'], refl_mode1[:,:135]),
        ),
        coords = dict(
            time = (['time'], time_mode1),
            height = (['height'], heights[:135])
        )
    )
    datasets.append(outdata)

print("Writing to NC")
ds = xr.concat(datasets, dim='time')
ds.to_netcdf(datadir + "/summit_radar.nc")
