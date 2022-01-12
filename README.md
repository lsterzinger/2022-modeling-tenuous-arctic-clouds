# Plotting scripts for Sterzinger et al. (2022)

*Link to paper will be provided here when available*

Plotting notebooks to reproduce all figures in the paper are located in [./plotting_scripts](./plotting_scripts).

NOTE: Data is not included in this repository. To download required data, run `./get_model_data.sh` and `./get_obs_data.sh`.

A Conda environment is included. If you do not have conda installed, I recommend [miniconda](https://docs.conda.io/en/latest/miniconda.html). Create the environment and launch a Jupyter Lab instance with:
```
conda create env -f environment.yml
conda activate arctic-clouds-plots

jupyter lab
```

This repository is fully citeable with a DOI:

[![DOI](https://zenodo.org/badge/446681579.svg)](https://zenodo.org/badge/latestdoi/446681579)

## External Data
No data is included in this repo. Data must be downloaded by running the two bash scripts in the base directory of this repo.

```
./get_model_data.sh
./get_obs_data.sh
```
*Note: the `get_obs_data.sh` script will download approximately 8 Gb of data*

### Oliktok Pt Data
All observation data from oliktok point is from the Department of Energy (DOE) Atmospheric Radiation Measurement (ARM) user facility at Oliktok Pt, Alaska. Data from the download script are hosted on a UC Davis compute cluster, and can also be found at https://adc.arm.gov/discovery/#/results/site_code::oli

### ASCOS Data
All data from ASCOS downloaded by the script comes directly from ASCOS data sources: either https://bolin.su.se/data/ascos, http://www.ascos.se, or ftp://ftp1.esrl.noaa.gov/psd3/cruises/ASCOS_2008/ODEN/radar/mmcr/DAMOCLES

### SMT Data
All data from summit downloaded also comes from https://www.arm.gov, but has been re-hosted on a UC Davis compute cluster for easier access and can also be found at https://adc.arm.gov/discovery/#/results/site_code::smt
