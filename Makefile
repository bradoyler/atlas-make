# National Atlas
# http://www.nationalatlas.gov/atlasftp-1m.html

# DE, ME, VT, WV & WY do not have cities with populations over 100k

# territories:
# pr vi as fm gu mh mp pw um

all: topo/us-cities.json svg/us-cities.svg all-states

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


shp/us/cities-over-150k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 150000" $@ $<

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

### each state ###
shp/al/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '01'" $@ $<

shp/ak/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '02'" $@ $<

shp/az/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '04'" $@ $<

shp/ar/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '05'" $@ $<

shp/ca/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '06'" $@ $<

shp/co/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '08'" $@ $<

shp/ct/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '09'" $@ $<

shp/de/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '10'" $@ $<

shp/dc/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '11'" $@ $<

shp/fl/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '12'" $@ $<

shp/ga/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '13'" $@ $<

shp/hi/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '15'" $@ $<

shp/id/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '16'" $@ $<

shp/il/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '17'" $@ $<

shp/in/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '18'" $@ $<

shp/ia/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '19'" $@ $<

shp/ks/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '20'" $@ $<

shp/ky/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '21'" $@ $<

shp/la/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '22'" $@ $<

shp/me/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '23'" $@ $<

shp/md/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '24'" $@ $<

shp/ma/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '25'" $@ $<

shp/mi/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '26'" $@ $<

shp/mn/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '27'" $@ $<

shp/ms/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '28'" $@ $<

shp/mo/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '29'" $@ $<

shp/mt/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '30'" $@ $<

shp/ne/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '31'" $@ $<

shp/nv/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '32'" $@ $<

shp/nh/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '33'" $@ $<

shp/nj/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '34'" $@ $<

shp/nm/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '35'" $@ $<

shp/ny/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '36'" $@ $<

shp/nc/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '37'" $@ $<

shp/nd/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '38'" $@ $<

shp/oh/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '39'" $@ $<

shp/ok/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '40'" $@ $<

shp/or/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '41'" $@ $<

shp/pa/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '42'" $@ $<

shp/ri/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '44'" $@ $<

shp/sc/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '45'" $@ $<

shp/sd/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '46'" $@ $<

shp/tn/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '47'" $@ $<

shp/tx/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '48'" $@ $<

shp/ut/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '49'" $@ $<

shp/vt/cities.shp: shp/us/cities-over-30k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '50'" $@ $<

shp/va/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '51'" $@ $<

shp/wa/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '53'" $@ $<

shp/wv/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '54'" $@ $<

shp/wi/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '55'" $@ $<

shp/wy/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '56'" $@ $<

shp/as/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '60'" $@ $<

shp/fm/cities.shp: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '64'" $@ $<

shp/gu/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '66'" $@ $<

shp/mh/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '68'" $@ $<

shp/mp/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '69'" $@ $<

shp/pw/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '70'" $@ $<

shp/pr/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '72'" $@ $<

shp/um/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '74'" $@ $<

shp/vi/cities.shp: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '78'" $@ $<


topo/us-cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE \
		-- cities=$<

topo/%/cities.json: shp/%/cities.shp
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

svg/us-cities.svg: topo/us-cities-projected.json
	mkdir -p $(dir $@)
	node_modules/.bin/topojson-svg -o $@ $<

cleanup-all: cleanup/shp cleanup/topo cleanup/svg

cleanup/%:
	rm -rf $(notdir $@)