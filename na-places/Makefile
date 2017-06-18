# Populated places in North America via National Atlas
# http://www.nationalatlas.gov/atlasftp-1m.html

all: csv/na-places.csv csv/us-places.csv geo/us-places.json svg/us-places.svg

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl -L 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/na-places.shp: gz/pop000x_shp_nt00304.tar.gz

shp/na-places-class3.shp: shp/na-places.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POPCLASS > 2 OR CAPITAL = 1" $@ $<

geo/us-places.json: shp/na-places-class3.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "COUNTRY = 'USA'" $@ $<

topo/us-places-projected.json: geo/us-places.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--projection 'd3.geo.albersUsa()' \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,COUNTRY \
		-- places=$<

svg/us-places.svg: topo/us-places-projected.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson-svg -o $@ $<

csv/na-places.csv: shp/na-places.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

csv/us-places.csv: geo/us-places.json
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

clean-all: clean/shp clean/topo clean/svg clean/geo clean/csv

clean/%:
	rm -rf $(notdir $@)
