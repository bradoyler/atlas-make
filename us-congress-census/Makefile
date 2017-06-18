# US Congressional Districts via TIGERLINE (http://www.census.gov/geo/maps-data/data/tiger-line.html)
# more @ https://catalog.data.gov/dataset/tiger-line-shapefile-2016-nation-u-s-115th-congressional-district-national

STATES=al ak az ar ca co ct de dc fl \
ga hi id il in ia ks ky la me \
md ma mi mn ms mo mt ne nv nh \
nj nm ny nc nd oh ok or pa ri \
sc sd tn tx ut vt va wa wv wi \
wy pr vi

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

all: topo/us-congress-115.json

all-states:
	for i in ${STATES} ; do make topo/$$i/congress-115.json ; done

.SECONDARY:

# 114th Congress
gz/tl_2015_us_cd114.zip:
	mkdir -p $(dir $@)
	curl -L 'ftp://ftp2.census.gov/geo/tiger/TIGER2015/CD/tl_2015_us_cd114.zip' -o $@.download
	mv $@.download $@

# 115th Congress
gz/tl_2016_us_cd115.zip:
	mkdir -p $(dir $@)
	curl -L 'ftp://ftp2.census.gov/geo/tiger/TIGER2016/CD/tl_2016_us_cd115.zip' -o $@.download
	mv $@.download $@

shp/us/congress-114.shp: gz/tl_2015_us_cd114.zip
shp/us/congress-115.shp: gz/tl_2016_us_cd115.zip

shp/us/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/%/congress-114.shp: shp/us/congress-114.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATEFP = '${$*_fips}'" $@ $<

shp/%/congress-115.shp: shp/us/congress-115.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "STATEFP = '${$*_fips}'" $@ $<

topo/us-congress-115.json: shp/us/congress-115.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 2000000 \
		-s 0.0000009 \
		-p GEOID,STATEFP \
		--id-property=GEOID \
		-- districts=$<

topo/%/congress-115.json: shp/%/congress-115.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-8 \
		-p GEOID,STATEFP \
		--id-property=GEOID \
		-- districts=$<

topo/us-congress-114.json: shp/us/congress-114.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 2000000 \
		-s 0.0000009 \
		-p GEOID,STATEFP \
		--id-property=GEOID \
		-- districts=$<

topo/%/congress-114.json: shp/%/congress-114.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-8 \
		-p GEOID,STATEFP \
		--id-property=GEOID \
		-- districts=$<

topo/us-congress-115-states.json:
	../node_modules/.bin/topojson \
		-o $@ -p \
		-- districts=topo/us-congress-115.json states=../us-states/topo/us-states.json

##### clean targets ##########
clean-all: clean/shp clean/topo

clean/%:
	rm -rf $(notdir $@)
