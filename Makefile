download: 
	ruby download.rb
produce:
	ruby process.rb | sh | \
	ruby reduce.rb | tippecanoe --maximum-zoom=12 -f -o docs/pop.pmtiles
style:
	pkl eval -f json style.pkl > docs/style.json
host:
	budo -d docs

