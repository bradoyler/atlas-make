# Map layers for US transportation.
# Index: http://nationalmap.gov/small_scale/atlasftp.html

all: csv/us-airports-major.csv svg/us-airports.svg csv/us-railroads-50mi.csv geo/us-roads-interstate.json topo/us-airports-major.json

.SECONDARY:

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

shp/us-airports.shp: gz/airprtx010g.shp_nt00822.tar.gz
shp/us-railroads.shp: gz/railrdl010g.shp_nt00917.tar.gz
shp/us-roads.shp: gz/roadtrl010g.shp_nt00920.tar.gz

shp/%.shp: shp/%.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' $@ $<

geo/%.json: shp/%.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' $@ $<

geo/us-airports-major.json: geo/us-airports.json
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "TOT_ENP > 999" $@ $<

geo/us-railroads-50mi.json: geo/us-railroads.json
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "MILES > 50" $@ $<

geo/us-roads-interstate.json: shp/us-roads.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -simplify 0.1 -progress \
	-select NAME,STATE \
	-lco COORDINATE_PRECISION=1 \
	-where "FCODE = '10'" $@ $<

topo/us-airports-major.json: geo/us-airports-major.json
		mkdir -p $(dir $@)
		../node_modules/.bin/topojson \
			-o $@ \
			--no-pre-quantization \
			--post-quantization=1e6 \
			--simplify=7e-7 \
			--id-property=IATA \
			-- airports=$<

topo/us-airports-projected.json: geo/us-airports.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--projection 'd3.geo.albersUsa()' \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p IATA,NAME \
		-- airports=$<

svg/us-airports.svg: topo/us-airports-projected.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson-svg -o $@ $<

csv/%.csv: geo/%.json
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

csv/us-railroads.csv: geo/us-railroads.json
csv/us-railroads-50mi.csv: geo/us-railroads-50mi.json
csv/us-airports.csv: geo/us-airports.json
csv/us-airports-major.csv: geo/us-airports-major.json
# csv/us-roads-interstate.csv: geo/us-roads-interstate.json # useless data

clean-all: clean/shp clean/topo clean/svg clean/geo clean/csv

clean/%:
	rm -rf $(notdir $@)
