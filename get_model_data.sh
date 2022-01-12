BASE_URL="http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/model/"

echo "Downloading RAMS model data from ${BASE_URL}"

curl -C - "${BASE_URL}ascos.nc" -o data/model/ascos.nc
curl -C - "${BASE_URL}oliktok.nc" -o data/model/oliktok.nc
curl -C - "${BASE_URL}summit.nc" -o data/model/summit.nc
