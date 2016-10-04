# State boundaries (scale:1m) http://nationalmap.gov/small_scale/mld/1statep.html
# Index: http://nationalmap.gov/small_scale/atlasftp.html?openChapters=chpbound#chpbound

# 50 states + DC:
# al ak az ar ca co ct de dc fl
# ga hi id il in ia ks ky la me
# md ma mi mn ms mo mt ne nv nh
# nj nm ny nc nd oh ok or pa ri
# sc sd tn tx ut vt va wa wv wi
# wy

# territories with counties:
# pr vi

# territories without counties:
# as fm gu mh mp pw um

## ----
# v1: http://dds.cr.usgs.gov/pub/data/nationalatlas/statep010_nt00798.tar.gz
# 62 polygons
# Geometry properties sample:
#  AREA         279.462
#  DAY_ADM        3
#  MONTH_ADM   'January'
#  ORDER_ADM     49
#  PERIMETER    802.665
#  STATE       'Alaska'
#  STATE_FIPS  '02'
#  YEAR_ADM    1959
## ----

## --------
# v2: http://dds.cr.usgs.gov/pub/data/nationalatlas/statesp010g.shp_nt00938.tar.gz
# not used due to issue with removing water bodies
## --------

all: topo/us-states.json csv/us-states.csv

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)' -o $@.download
	mv $@.download $@

# shp/us-states-raw.shp: gz/statesp010g.shp_nt00938.tar.gz
shp/us-states-raw.shp: gz/statep010_nt00798.tar.gz


shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

csv/us-states.csv: shp/us-states-raw.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

shp/us-states.shp: shp/us-states-raw.shp
	@rm -f -- $@ $(basename $@)-raw.json
	ogr2ogr -f 'GeoJSON' $(basename $@)-raw.json $<
	node ../bin/geouniq STATE_FIPS < $(basename $@)-raw.json > $(basename $@).json
	ogr2ogr -f 'ESRI Shapefile' $@ $(basename $@).json
	rm -f -- $(basename $@).json $(basename $@).json

geo/us-states.json: shp/us-states-raw.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -simplify 0.005 -progress $@ $<

topo/us-states.json: shp/us-states.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-7 \
		-p STATE,STATE_FIPS \
		-- states=$<

topo/us-states-simplified.json: shp/us-states.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-6 \
		-p STATE,STATE_FIPS \
		-- states=$<

##### clean targets ##########
clean-all: clean/shp clean/csv clean/topo clean/geo

clean/%:
	rm -rf $(notdir $@)
