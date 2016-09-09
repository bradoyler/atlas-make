# Map layers for US transportation.
# Index: http://nationalmap.gov/small_scale/atlasftp.html

all: csv/us-airports-major.csv csv/us-airports.csv svg/us-airports.svg

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/us-airports.shp: gz/airprtx010g.shp_nt00822.tar.gz

shp/%.shp: shp/%.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' $@ $<

geo/us-airports-major.json: shp/us-airports.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "TOT_ENP > 999" $@ $<

geo/us-airports.json: shp/us-airports.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' $@ $<

topo/us-airports-projected.json: geo/us-airports.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--projection 'd3.geo.albersUsa()' \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,COUNTRY \
		-- places=$<

svg/us-airports.svg: topo/us-airports-projected.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson-svg -o $@ $<

csv/%.csv: geo/%.json
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

csv/us-airports.csv: geo/us-airports.json
csv/us-airports-major.csv: geo/us-airports-major.json

clean-all: clean/shp clean/topo clean/svg clean/geo clean/csv

clean/%:
	rm -rf $(notdir $@)
