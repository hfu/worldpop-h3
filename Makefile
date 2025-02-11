download: 
	curl -o src/2000.tif -L https://data.worldpop.org/GIS/Population/Global_2000_2020/2000/0_Mosaicked/ppp_2000_1km_Aggregated.tif
produce:
	ruby process.rb | sh
dev:
	ruby process.rb | grep tls | sh | \
	ruby reduce.rb | tippecanoe --maximum-zoom=14 -f -o docs/pop.pmtiles

