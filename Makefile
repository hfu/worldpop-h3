COUNTRIES = fin
MAXZOOM = 12

download: 
	@for COUNTRY in ${COUNTRIES}; do \
		COUNTRY=$${COUNTRY} ruby download.rb ; \
	done
produce:
	@for COUNTRY in ${COUNTRIES}; do \
		COUNTRY=$${COUNTRY} ruby process.rb | sh | \
		ruby reduce.rb | tippecanoe --maximum-zoom=${MAXZOOM} -f -o dst/$${COUNTRY}.pmtiles ;\
	done
style:
	pkl eval -f json style.pkl > docs/style.json
host:
	budo -d docs
upload:
	AWS_REQUEST_CHECKSUM_CALCULATION=WHEN_REQUIRED aws s3 sync \
	--exclude "*.pmtiles-journal" dst \
	s3://smartmaps/h3ys-worldpop/ --endpoint-url=https://data.source.coop
