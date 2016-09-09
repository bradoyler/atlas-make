# County boundaries (scale:1m) http://nationalmap.gov/small_scale/mld/1statep.html
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

## File info:
# http://dds.cr.usgs.gov/pub/data/nationalatlas/countyp010_nt00795.tar.gz
#  AREA        0.00239414646
#  COUNTY      'Jefferson Parish'
#  COUNTYP010  1
#  FIPS        '22051'
#  PERIMETER   0.57037166542
#  SQUARE_MIL  9.932
#  STATE       'LA'
#  STATE_FIPS  '22'

STATES=al ak az ar ca co ct de dc fl \
ga hi id il in ia ks ky la me \
md ma mi mn ms mo mt ne nv nh \
nj nm ny nc nd oh ok or pa ri \
sc sd tn tx ut vt va wa wv wi \
wy pr vi

all:
	for i in ${STATES} ; do make topo/$$i/counties.json csv/$$i/counties.csv ; done
	make topo/us/counties.json csv/us/counties.csv

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/us/counties-raw.shp: gz/countyp010_nt00795.tar.gz

shp/%/counties-raw.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

csv/%/counties.csv: shp/%/counties.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

shp/us/counties.shp: shp/us/counties-raw.shp
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "FIPS NOT LIKE '%000'" $@ $<

shp/%/counties.shp: shp/us/counties.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE = '`echo $* | tr a-z A-Z`'" $@ $<

geo/%/counties.json: shp/%/counties.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -progress $@ $<

topo/%/counties.json: shp/%/counties.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-7 \
		-p COUNTY,FIPS,STATE,STATE_FIPS \
		--id-property=FIPS \
		-- counties=$<

## added to keep shp file from getting deleted for these states...
topo/mi/counties.json: shp/mi/counties.shp
topo/pa/counties.json: shp/pa/counties.shp
topo/ny/counties.json: shp/ny/counties.shp
topo/wi/counties.json: shp/wi/counties.shp

##### clean targets ##########
clean-all: clean/shp clean/csv clean/topo clean/geo

clean/%:
	rm -rf $(notdir $@)
