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
echo
echo "Downloading Radar Data"
echo

ascos_path="$basedir/data/obs/ASCOS"
[ ! -d $ascos_path ] && mkdir -p $ascos_path
cd $ascos_path

wget -nc "ftp://ftp1.esrl.noaa.gov/psd3/cruises/ASCOS_2008/ODEN/radar/mmcr/DAMOCLES/ascos_mmcrmerge.C1.c1.20080831.000000.nc" 

# Temp dir to download zips
tempdir="$basedir/temp"
[ ! -d $tempdir ] && mkdir $tempdir

echo
echo "Downloading Microwave Radiometer Data"
echo

curl -C - -A "Mozilla/4.0" "https://bolin.su.se/data/ascos/files/ascmwrlosC1.b1.zip" -o $tempdir/ascmwrlosC1.b1.zip
unzip -p $tempdir/ascmwrlosC1.b1.zip ascmwrlosC1.b1.20080831.000207.cdf > $ascos_path/ascmwrlosC1.b1.20080831.000207.cdf

echo
echo "Downloading Soundings"
echo

curl -C - "https://bolin.su.se/data/ascos/files/OdenSoundings.zip" -o "${tempdir}/OdenSoundings.zip"
unzip -p "${tempdir}/OdenSoundings.zip" Radiosonde_2008_08_31_0535.txt > $ascos_path/Radiosonde_2008_08_31_0535.txt

echo
echo "Downloading Aerosol Data"
echo

curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/Dp05-11.txt" -o $ascos_path/Dp05-11.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/StopTime05-11.txt" -o $ascos_path/StopTime05-11.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/InvertedMatrix30-03-2010.txt" -o $ascos_path/InvertedMatrix30-03-2010.txt
curl -C - -A "Mozilla/4.0" "http://www.ascos.se/files/DmpsTechFlag.txt" -o $ascos_path/DmpsTechFlag.txt

echo
echo "Processing ASCOS aerosol data"
echo

python data-processing-scripts/process-ascos-aerosol-data.py $ascos_path

echo
echo "Downloading ASCOS ERA5 Data"
echo

curl -C - "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/ASCOS/e5.oper.an.sfc.128_151_msl.ll025sc.2008080100_2008083123.nc" -o $ascos_path/e5.oper.an.sfc.128_151_msl.ll025sc.2008080100_2008083123.nc
curl -C - "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/ASCOS/e5.oper.an.sfc.128_167_2t.ll025sc.2008080100_2008083123.nc" -o $ascos_path/e5.oper.an.sfc.128_167_2t.ll025sc.2008080100_2008083123.nc

[ -d $tempdir ] && rm -rf $tempdir

cd $basedir
echo "===================="
echo "Downloading SMT data"
echo "===================="

smt_path=$basedir/data/obs/SMT

[ ! -d $smt_path ] && mkdir -p $smt_path

cd $smt_path

smtfiles=(
    "ace-cpc_summit_201907_aerosol-concentration_v1.nc"
    "smtmwrlosX1.a1.20190702.011127.cdf.nc"
    "smtmmcrmomX1.b1.20190701.000000.cdf"
    "smtsondewnpnX1.b1.20190701.231609.cdf.nc"
    "smtmmcrmomX1.b1.20190702.000000.cdf"
    "e5.oper.an.sfc.128_151_msl.ll025sc.2019070100_2019073123.nc"
    "e5.oper.an.sfc.128_167_2t.ll025sc.2019070100_2019073123.nc"
)

for f in ${smtfiles[@]}; do
    wget -nc "http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/obs/SMT/$f"
done

cd $basedir

echo
echo "Processing SMT radar data"
echo

python data-processing-scripts/process-smt-data.py $smt_path

echo 
echo "======"
echo "Done!!"
echo "======"