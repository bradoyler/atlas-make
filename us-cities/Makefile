# National Atlas
# http://www.nationalatlas.gov/atlasftp-1m.html

# DE, ME, VT, WV & WY do not have cities with populations over 100k

# territories:
# pr vi as fm gu mh mp pw um

all: all-states topo/us-cities.json geo/us/capitals.json svg/us-cities.svg

STATES=al ak az ar ca co ct de dc fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy
all-states:
	for i in ${STATES} ; do make topo/$$i/cities.json ; done

STATES_OVER_50k=hi me nh nd sc vt wv wy vi pr

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
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 150000 OR FEATURE2 Like '%Capital%'" $@ $<

shp/us/cities-over-100k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 100000 OR FEATURE2 Like '%Capital%'" $@ $<

shp/us/cities-over-50k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 50000 OR FEATURE2 Like '%Capital%'" $@ $<

shp/us/cities-over-30k.shp: shp/us/cities.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "POP_2010 > 30000 OR FEATURE2 Like '%Capital%'" $@ $<

geo/us/cities.json: shp/us/cities-over-150k.shp
	@rm -f -- $@ $(basename $@).json
	ogr2ogr -f 'GeoJSON' $(basename $@).json $<

##############################
### GeoJSON for each state ###

.SECONDARY:
geo/%/cities.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE '$*'" $@ $<

geo/hi/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'HI'" $@ $<

geo/me/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'ME'" $@ $<

geo/nh/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'NH'" $@ $<

geo/nd/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'ND'" $@ $<

geo/sc/cities.json: shp/us/cities-over-100k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'SC'" $@ $<

geo/vt/cities.json: shp/us/cities-over-30k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'VT'" $@ $<

geo/wv/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'WV'" $@ $<

geo/wy/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'WY'" $@ $<

geo/gu/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'GU'" $@ $<

geo/mh/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'MH'" $@ $<

geo/mp/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'MP'" $@ $<

geo/pw/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'PW'" $@ $<

geo/pr/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'PR'" $@ $<

geo/um/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'UM'" $@ $<

geo/vi/cities.json: shp/us/cities-over-50k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "STATE LIKE 'VI'" $@ $<

geo/us/capitals.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -where "FEATURE2 Like '%Capital%' " $@ $<

geo/cities-all.json: all-states
	node geo-combine

### Topojson ###

topo/us-cities-100k.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

topo/%/cities.json: geo/%/cities.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

topo/us-cities-projected.json: shp/us/cities-over-150k.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--projection 'd3.geo.albersUsa()' \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE \
		--id-property=+FIPS \
		-- cities=$<

topo/us-cities.json: geo/cities-all.json
	../node_modules/.bin/topojson \
		-o $@ \
		--no-pre-quantization \
		--post-quantization=1e6 \
		--simplify=7e-7 \
		-p NAME,STATE,LATITUDE,LONGITUDE,POP_2010 \
		-- cities=$<

### misc target ###

svg/us-cities.svg: topo/us-cities-projected.json
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson-svg -o $@ $<

clean-all: clean/shp clean/topo clean/svg clean/geo

clean/%:
	rm -rf $(notdir $@)
