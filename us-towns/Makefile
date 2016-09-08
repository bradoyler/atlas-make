# County subdivisions (Towns): https://www.census.gov/geo/maps-data/data/cbf/cbf_cousub.html

# http://wsgw.mass.gov/data/gispub/shape/census2010/CENSUS2010TOWNS_SHP.zip

STATES=al ak az ar ca co ct de dc fl \
ga hi id il in ia ks ky la me \
md ma mi mn ms mo mt ne nv nh \
nj nm ny nc nd oh ok or pa ri \
sc sd tn tx ut vt va wa wv wi \
wy

# NewEnglandStates=ct me ma nh ri vt

all:
	for i in ${STATES} ; do make topo/$$i/countysubs.json csv/$$i/countysubs.csv ; done

gz/tl_2013_%_cousub.zip:
	mkdir -p $(dir $@)
	curl 'http://www2.census.gov/geo/tiger/TIGER2013/COUSUB/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/%/countysubs.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/al/countysubs.shp: gz/tl_2013_01_cousub.zip
shp/ak/countysubs.shp: gz/tl_2013_02_cousub.zip
shp/az/countysubs.shp: gz/tl_2013_04_cousub.zip
shp/ar/countysubs.shp: gz/tl_2013_05_cousub.zip
shp/ca/countysubs.shp: gz/tl_2013_06_cousub.zip
shp/co/countysubs.shp: gz/tl_2013_08_cousub.zip
shp/ct/countysubs.shp: gz/tl_2013_09_cousub.zip
shp/de/countysubs.shp: gz/tl_2013_10_cousub.zip
shp/dc/countysubs.shp: gz/tl_2013_11_cousub.zip
shp/fl/countysubs.shp: gz/tl_2013_12_cousub.zip
shp/ga/countysubs.shp: gz/tl_2013_13_cousub.zip
shp/hi/countysubs.shp: gz/tl_2013_15_cousub.zip
shp/id/countysubs.shp: gz/tl_2013_16_cousub.zip
shp/il/countysubs.shp: gz/tl_2013_17_cousub.zip
shp/in/countysubs.shp: gz/tl_2013_18_cousub.zip
shp/ka/countysubs.shp: gz/tl_2013_19_cousub.zip
shp/ks/countysubs.shp: gz/tl_2013_20_cousub.zip
shp/ky/countysubs.shp: gz/tl_2013_21_cousub.zip
shp/la/countysubs.shp: gz/tl_2013_22_cousub.zip
shp/me/countysubs.shp: gz/tl_2013_23_cousub.zip
shp/md/countysubs.shp: gz/tl_2013_24_cousub.zip
shp/ma/countysubs.shp: gz/tl_2013_25_cousub.zip
shp/mi/countysubs.shp: gz/tl_2013_26_cousub.zip
shp/mn/countysubs.shp: gz/tl_2013_27_cousub.zip
shp/ms/countysubs.shp: gz/tl_2013_28_cousub.zip
shp/mo/countysubs.shp: gz/tl_2013_29_cousub.zip
shp/mt/countysubs.shp: gz/tl_2013_30_cousub.zip
shp/ne/countysubs.shp: gz/tl_2013_31_cousub.zip
shp/nv/countysubs.shp: gz/tl_2013_32_cousub.zip
shp/nh/countysubs.shp: gz/tl_2013_33_cousub.zip
shp/nj/countysubs.shp: gz/tl_2013_34_cousub.zip
shp/nm/countysubs.shp: gz/tl_2013_35_cousub.zip
shp/ny/countysubs.shp: gz/tl_2013_36_cousub.zip
shp/nc/countysubs.shp: gz/tl_2013_37_cousub.zip
shp/nd/countysubs.shp: gz/tl_2013_38_cousub.zip
shp/oh/countysubs.shp: gz/tl_2013_39_cousub.zip
shp/ok/countysubs.shp: gz/tl_2013_40_cousub.zip
shp/or/countysubs.shp: gz/tl_2013_41_cousub.zip
shp/pa/countysubs.shp: gz/tl_2013_42_cousub.zip
shp/ri/countysubs.shp: gz/tl_2013_44_cousub.zip
shp/sc/countysubs.shp: gz/tl_2013_45_cousub.zip
shp/sd/countysubs.shp: gz/tl_2013_46_cousub.zip
shp/tn/countysubs.shp: gz/tl_2013_47_cousub.zip
shp/tx/countysubs.shp: gz/tl_2013_48_cousub.zip
shp/ut/countysubs.shp: gz/tl_2013_49_cousub.zip
shp/vt/countysubs.shp: gz/tl_2013_50_cousub.zip
shp/va/countysubs.shp: gz/tl_2013_51_cousub.zip
shp/wa/countysubs.shp: gz/tl_2013_53_cousub.zip
shp/wv/countysubs.shp: gz/tl_2013_54_cousub.zip
shp/wi/countysubs.shp: gz/tl_2013_55_cousub.zip
shp/wy/countysubs.shp: gz/tl_2013_56_cousub.zip
shp/pr/countysubs.shp: gz/tl_2013_72_cousub.zip

topo/%/countysubs.json: shp/%/countysubs.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E6 \
		-s 1E-8 \
		-p NAME,STATEFP,COUNTYFP,COUSUBFP \
		-- countysubs=$<

# MA Towns via mass.gov
gz/CENSUS2010_MA_TOWNS_SHP.zip:
	mkdir -p $(dir $@)
	curl 'http://wsgw.mass.gov/data/gispub/shape/census2010/CENSUS2010TOWNS_SHP.zip' -o $@.download
	mv $@.download $@

shp/ma_towns/towns.shp: gz/CENSUS2010_MA_TOWNS_SHP.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

topo/ma/towns.json: shp/ma_towns/towns.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-p TOWN,POP2010,COUNTY,COUSUBFP10 \
		-- towns=$<

csv/%/countysubs.csv: shp/%/countysubs.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

##### clean targets ##########
clean-all: clean/shp clean/geo clean/topo clean/csv

clean/%:
	rm -rf $(notdir $@)
