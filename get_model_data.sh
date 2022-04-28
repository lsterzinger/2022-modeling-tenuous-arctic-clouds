BASE_URL="http://farm.cse.ucdavis.edu/~lsterzin/modeling_tenuous_arctic_clouds_data/model"

echo "Downloading RAMS model data from ${BASE_URL}"

curl -C - "${BASE_URL}/ascos.nc" -o data/model/ascos.nc
curl -C - "${BASE_URL}/oliktok.nc" -o data/model/oliktok.nc
curl -C - "${BASE_URL}/summit.nc" -o data/model/summit.nc

curl -C - "${BASE_URL}/ascos_cin0.nc" -o data/model/ascos_cin0.nc
curl -C - "${BASE_URL}/oliktok_cin0.nc" -o data/model/oliktok_cin0.nc
curl -C - "${BASE_URL}/summit_cin0.nc" -o data/model/summit_cin0.nc

curl -C - "${BASE_URL}/oli_vert_momentum_flux.nc" -o data/model/oli_vert_momentum_flux.nc
curl -C - "${BASE_URL}/ascos_vert_momentum_flux.nc" -o data/model/ascos_vert_momentum_flux.nc
curl -C - "${BASE_URL}/smt_vert_momentum_flux.nc" -o data/model/smt_vert_momentum_flux.nc
