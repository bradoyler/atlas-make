# US Congressional Districts (scale:1m) http://nationalmap.gov/small_scale/mld/cgd114p.html
# Index: http://nationalmap.gov/small_scale/atlasftp.html

STATES=al ak az ar ca co ct de dc fl \
ga hi id il in ia ks ky la me \
md ma mi mn ms mo mt ne nv nh \
nj nm ny nc nd oh ok or pa ri \
sc sd tn tx ut vt va wa wv wi \
wy pr vi as gu mp

# 50 states + DC, PR & VI: closest thing to KeyValue pairs
al_fips=01
ak_fips=02
az_fips=04
ar_fips=05
ca_fips=06
co_fips=08
ct_fips=09
de_fips=10
dc_fips=11
fl_fips=12
ga_fips=13
hi_fips=15
id_fips=16
il_fips=17
in_fips=18
ia_fips=19
ks_fips=20
ky_fips=21
la_fips=22
me_fips=23
md_fips=24
ma_fips=25
mi_fips=26
mn_fips=27
ms_fips=28
mo_fips=29
mt_fips=30
ne_fips=31
nv_fips=32
nh_fips=33
nj_fips=34
nm_fips=35
ny_fips=36
nc_fips=37
nd_fips=38
oh_fips=39
ok_fips=40
or_fips=41
pa_fips=42
ri_fips=44
sc_fips=45
sd_fips=46
tn_fips=47
tx_fips=48
ut_fips=49
vt_fips=50
va_fips=51
wa_fips=53
wv_fips=54
wi_fips=55
wy_fips=56
pr_fips=72
vi_fips=78
as_fips=60
gu_fips=66
mp_fips=69

all: topo/us/congress.json csv/us/congress.csv

all-states:
	for i in ${STATES} ; do make topo/$$i/congress.json ; done

.SECONDARY:

gz/%.tar.gz:
	mkdir -p $(dir $@)
	curl 'ftp://rockyftp.cr.usgs.gov/vdelivery/Datasets/Staged/SmallScale/Data/Boundaries/$(notdir $@)' -o $@.download
	mv $@.download $@


gz/us_congressional_districts.zip:
	mkdir -p $(dir $@)
	curl 'https://gist.githubusercontent.com/rveciana/fe6b452c853146e674dd6dd09c1cc6e3/raw/8cbc12c12738f098cc36a8c72cb5596c74bd9206/$(notdir $@)' -o $@.download
	mv $@.download $@

## shp/us/congress.shp: gz/cgd114p010g.shp.tar.gz ## shape file from USGS that doesn't include GU, AS & MS

shp/us/congress.shp: gz/us_congressional_districts.zip

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

shp/%/congress.shp: shp/us/congress.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATE_FIPS = '${$*_fips}'" $@ $<

csv/%/congress.csv: shp/%/congress.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

# * notice the handy ID-prop *
topo/us/congress.json: shp/us/congress.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-7 \
		-p CONG_DIST,CONG_REP,PARTY_AFF,STATE,STATE_FIPS \
		--id-property=STATE_FIPS+CONG_DIST \
		-- congress=$<

topo/ak/congress.json: shp/ak/congress.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-7 \
		-p CONG_DIST,CONG_REP,PARTY_AFF,STATE,STATE_FIPS \
		--id-property=+CONG_DIST \
		-- congress=$<

topo/%/congress.json: shp/%/congress.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-8 \
		-p CONG_DIST,CONG_REP,PARTY_AFF,STATE,STATE_FIPS \
		--id-property=+CONG_DIST \
		-- congress=$<

##### clean targets ##########
clean-all: clean/shp clean/csv clean/topo clean/geo

clean/%:
	rm -rf $(notdir $@)
