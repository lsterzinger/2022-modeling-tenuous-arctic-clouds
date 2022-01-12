#!/bin/bash

basedir=$(pwd)

echo "===================="
echo "Downloading OLI data"
echo "===================="

oli_path="$basedir/data/obs/OLI"
[ ! -d $oli_path ] && mkdir -p $oli_path

cd $oli_path

olifiles=(
    "e5.oper.an.sfc.128_151_msl.ll025sc.2017050100_2017053123.nc"
    "olikazrgeM1.a1.20170512.000001.nc"
    "e5.oper.an.sfc.128_167_2t.ll025sc.2017050100_2017053123.nc"
    "olimwrret2turnM1.c1.20170511.000001.nc"
    "oliaoscpcuM1.b1.20170511.000000.nc"
    "olimwrret2turnM1.c1.20170512.000002.nc"
    "oliaoscpcuM1.b1.20170512.000000.nc"
    "olisondewnpnM1.b1.20170511.232900.cdf"
    "olikazrgeM1.a1.20170511.000000.nc"
)

for f in ${olifiles[@]}; do
    wget -nc "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/OLI/$f"
done

cd $basedir

echo "======================"
echo "Downloading ASCOS data"
echo "======================"
echo "\n\nDownloading Radar Data\n\n"

ascos_path="$basedir/data/obs/ASCOS"
[ ! -d $ascos_path ] && mkdir -p $ascos_path
cd $ascos_path

wget "ftp://ftp1.esrl.noaa.gov/psd3/cruises/ASCOS_2008/ODEN/radar/mmcr/DAMOCLES/ascos_mmcrmerge.C1.c1.20080831.000000.nc" 

# Temp dir to download zips
tempdir="$basedir/temp"
[ ! -d $tempdir ] && mkdir $tempdir

echo "\n\nDownloading Microwave Radiometer Data\n\n"
curl -C - -A "Mozilla/4.0" "https://bolin.su.se/data/ascos/files/ascmwrlosC1.b1.zip" -o $tempdir/ascmwrlosC1.b1.zip
unzip -p $tempdir/ascmwrlosC1.b1.zip ascmwrlosC1.b1.20080831.000207.cdf > $ascos_path/ascmwrlosC1.b1.20080831.000207.cdf

echo "\n\nDownloading Soundings\n\n"
curl -C - "https://bolin.su.se/data/ascos/files/OdenSoundings.zip" -o "${tempdir}/OdenSoundings.zip"
unzip -p "${tempdir}/OdenSoundings.zip" Radiosonde_2008_08_31_0535.txt > $ascos_path/Radiosonde_2008_08_31_0535.txt

echo "\n\nDownloading Aerosol Data\n\n"
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/Dp05-11.txt" -o $ascos_path/Dp05-11.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/StopTime05-11.txt" -o $ascos_path/StopTime05-11.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/InvertedMatrix30-03-2010.txt" -o $ascos_path/InvertedMatrix30-03-2010.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/DmpsTechFlag.txt" -o $ascos_path/DmpsTechFlag.txt

echo "\n\nProcessing ASCOS aerosol data\n\n"
python data-processing-scripts/process-ascos-aerosol-data.py $ascos_path

echo "\n\nDownloading ASCOS ERA5 Data\n\n"
curl -C - "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/ASCOS/e5.oper.an.sfc.128_151_msl.ll025sc.2008080100_2008083123.nc" -o $ascos_path/e5.oper.an.sfc.128_151_msl.ll025sc.2008080100_2008083123.nc
curl -C - "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/ASCOS/e5.oper.an.sfc.128_167_2t.ll025sc.2008080100_2008083123.nc" -o $ascos_path/e5.oper.an.sfc.128_167_2t.ll025sc.2008080100_2008083123.nc

# [ -d $tempdir ] && rm -rf $tempdir

cd $basedir
echo "===================="
echo "Downloading SMT data"
echo "===================="

