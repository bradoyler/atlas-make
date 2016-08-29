# National Atlas
# http://www.nationalatlas.gov/atlasftp-1m.html

# DE, ME, VT, WV & WY do not have cities with populations over 100k

# territories:
# pr vi as fm gu mh mp pw um

all: all-states topo/us-cities.json svg/us-cities.svg

STATES=al ak az ar ca co ct de dc fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy
all-states:
	for i in ${STATES} ; do make topo/$$i/cities.json ; done

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)' -o $@.download
	mv $@.download $@


shp/us/cities-raw.shp: gz/citiesx020_nt00007.tar.gz

shp/us/cities.shp: gz/citiesx010g_shp_nt00962.tar.gz

shp/us/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/us/cities-over-230k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 230000" $@ $<

shp/us/cities-over-200k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 200000" $@ $<

shp/us/cities-over-150k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 150000" $@ $<

shp/us/cities-over-100k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 100000" $@ $<

shp/us/cities-over-50k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 50000" $@ $<

shp/us/cities-over-30k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 30000" $@ $<

shp/us/cities.json: shp/us/cities-over-150k.shp
	@rm -f -- $@ $(basename $@).json
	ogr2ogr -f 'GeoJSON' $(basename $@).json $<

##############################
### GeoJSON for each state ###
geo/al/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '01'" $@ $<

geo/ak/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '02'" $@ $<

geo/az/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '04'" $@ $<

geo/ar/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '05'" $@ $<

geo/ca/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '06'" $@ $<

geo/co/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '08'" $@ $<

geo/ct/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '09'" $@ $<

geo/de/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '10'" $@ $<

geo/dc/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '11'" $@ $<

geo/fl/cities.json: shp/us/cities-over-230k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '12'" $@ $<

geo/ga/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '13'" $@ $<

geo/hi/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '15'" $@ $<

geo/id/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '16'" $@ $<

geo/il/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '17'" $@ $<

geo/in/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '18'" $@ $<

geo/ia/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '19'" $@ $<

geo/ks/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '20'" $@ $<

geo/ky/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '21'" $@ $<

geo/la/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '22'" $@ $<

geo/me/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '23'" $@ $<

geo/md/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '24'" $@ $<

geo/ma/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '25'" $@ $<

geo/mi/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '26'" $@ $<

geo/mn/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '27'" $@ $<

geo/ms/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '28'" $@ $<

geo/mo/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '29'" $@ $<

geo/mt/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '30'" $@ $<

geo/ne/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '31'" $@ $<

geo/nv/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '32'" $@ $<

geo/nh/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '33'" $@ $<

geo/nj/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '34'" $@ $<

geo/nm/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '35'" $@ $<

geo/ny/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '36'" $@ $<

geo/nc/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '37'" $@ $<

geo/nd/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '38'" $@ $<

geo/oh/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '39'" $@ $<

geo/ok/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '40'" $@ $<

geo/or/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '41'" $@ $<

geo/pa/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '42'" $@ $<

geo/ri/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '44'" $@ $<

geo/sc/cities.json: shp/us/cities-over-100k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '45'" $@ $<

geo/sd/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '46'" $@ $<

geo/tn/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '47'" $@ $<

geo/tx/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '48'" $@ $<

geo/ut/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '49'" $@ $<

geo/vt/cities.json: shp/us/cities-over-30k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '50'" $@ $<

geo/va/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '51'" $@ $<

geo/wa/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '53'" $@ $<

geo/wv/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '54'" $@ $<

geo/wi/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '55'" $@ $<

geo/wy/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '56'" $@ $<

geo/as/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '60'" $@ $<

geo/fm/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '64'" $@ $<

geo/gu/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '66'" $@ $<

geo/mh/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '68'" $@ $<

geo/mp/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '69'" $@ $<

geo/pw/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '70'" $@ $<

geo/pr/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '72'" $@ $<

geo/um/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '74'" $@ $<

geo/vi/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE_FIPS = '78'" $@ $<


topo/us-cities-100k.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

topo/%/cities.json: geo/%/cities.json
	mkdir -p $(dir $@)
	node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

topo/us-cities-projected.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--projection 'd3.geo.albersUsa()' \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE \
		--id-property=+FIPS \
		-- cities=$<


topo/us-cities.json: geo/cities-all.json
	node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

geo/cities-all.json: all-states
	node geo-combine

svg/us-cities.svg: topo/us-cities-projected.json
	mkdir -p $(dir $@)
	node_modules/.bin/topojson-svg -o $@ $<

cleanup-all: cleanup/shp cleanup/topo cleanup/svg cleanup/geo

cleanup/%:
	rm -rf $(notdir $@)