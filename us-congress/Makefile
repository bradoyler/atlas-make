# US Congressional Districts (scale:1m) http://nationalmap.gov/small_scale/mld/cgd114p.html
# Index: http://nationalmap.gov/small_scale/atlasftp.html

# 50 states + DC:
# al ak az ar ca co ct de dc fl
# ga hi id il in ia ks ky la me
# md ma mi mn ms mo mt ne nv nh
# nj nm ny nc nd oh ok or pa ri
# sc sd tn tx ut vt va wa wv wi
# wy

# territories with districts:
# pr vi

## DBase file info:
# src: ftp://rockyftp.cr.usgs.gov/vdelivery/Datasets/Staged/SmallScale/Data/Boundaries/cgd114p010g.shp.tar.gz
# STATE	Pennsylvania
# STATE_FIPS	42
# CONG_DIST	10
# CONG_REP	Tom Marino
# PARTY_AFF	Republican
# URL	http://marino.house.gov/
# SENATOR_1	Robert P.Casey Jr.
# SEN1_PARTY	Democrat
# SEN_1_URL	http://www.Casey.senate.gov/
# SENATOR_2	Patrick J. Toomey
# SEN2_PARTY	Republican
# SEN_2_URL	http://www.Toomey.senate.gov/
# Shape_Leng	14.6170283108
# Shape_Area	2.36918328648


all: topo/us/congress.json csv/us/congress.csv

.SECONDARY:

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'ftp://rockyftp.cr.usgs.gov/vdelivery/Datasets/Staged/SmallScale/Data/Boundaries/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/us/congress.shp: gz/cgd114p010g.shp.tar.gz

shp/us/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/us/congress-rep.shp: shp/us/congress.shp
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "PARTY_AFF LIKE 'Republican'" $@ $<

shp/us/congress-dem.shp: shp/us/congress.shp
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "PARTY_AFF LIKE 'Democrat'" $@ $<

csv/%/congress.csv: shp/%/congress.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

# * notice the handy ID-prop *
topo/%/congress.json: shp/%/congress.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-7 \
		-p CONG_DIST,CONG_REP,PARTY_AFF,STATE,STATE_FIPS \
		--id-property=STATE_FIPS+CONG_DIST \
		-- congress=$<

##### clean targets ##########
clean-all: clean/shp clean/csv clean/topo clean/geo

clean/%:
	rm -rf $(notdir $@)
