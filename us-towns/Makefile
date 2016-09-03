# County subdivisions (Towns): https://www.census.gov/geo/maps-data/data/cbf/cbf_cousub.html

# http://wsgw.mass.gov/data/gispub/shape/census2010/CENSUS2010TOWNS_SHP.zip
# states:
# al ak az ar ca co ct de dc fl
# ga hi id il in ia ks ky la me
# md ma mi mn ms mo mt ne nv nh
# nj nm ny nc nd oh ok or pa ri
# sc sd tn tx ut vt va wa wv wi
# wy

# StateFIPS=01 02 04 05 06 08 09 10 11 12 13 15 16 17 18 19 20 21 22 23 25 33 44 50

## Legend: CT(09),ME(23),MA(25),NH(33),RI(44),VT(50)

StateFIPS=09 23 25 33 44 50
States=ct me ma nh ri vt

all:
	for i in ${States} ; do make topo/$$i/countysubs.json ; done

gz/tl_2013_%_cousub.zip:
	mkdir -p $(dir $@)
	curl 'http://www2.census.gov/geo/tiger/TIGER2013/COUSUB/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/ct/countysubs.shp: gz/tl_2013_09_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/me/countysubs.shp: gz/tl_2013_23_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/ma/countysubs.shp: gz/tl_2013_25_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/nh/countysubs.shp: gz/tl_2013_33_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/ri/countysubs.shp: gz/tl_2013_44_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/vt/countysubs.shp: gz/tl_2013_50_cousub.zip
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

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

##### clean targets ##########
clean-all: clean/shp clean/geo clean/topo

clean/%:
	rm -rf $(notdir $@)
