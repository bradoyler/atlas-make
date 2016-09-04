# source file index: https://www.census.gov/geo/maps-data/data/tiger-data.html
#### Scope ####
## 2010 Census, Demographic Profile 1 — Shapefile Format
## ACS 2014 - States:   http://www2.census.gov/geo/tiger/TIGER_DP/2014ACS/ACS_2014_5YR_STATE.gdb.zip
## ACS 2014 - Counties: http://www2.census.gov/geo/tiger/TIGER_DP/2014ACS/ACS_2014_5YR_COUNTY.gdb.zip

all: geo/census-2010/states-full.json geo/census-2010/counties-full.json csv/acs-2014/states csv/acs-2014/counties

gz/census-2010/%.zip:
	mkdir -p $(dir $@)
	curl 'http://www2.census.gov/geo/tiger/TIGER2010DP1/$(notdir $@)' -o $@.download
	mv $@.download $@

gz/acs-2014/%.zip:
	mkdir -p $(dir $@)
	curl 'http://www2.census.gov/geo/tiger/TIGER_DP/2014ACS/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/acs-2014_states.shp: gz/acs-2014/ACS_2014_5YR_STATE.gdb.zip
shp/acs-2014_counties.shp: gz/acs-2014/ACS_2014_5YR_COUNTY.gdb.zip
shp/census-2010_states.shp: gz/census-2010/State_2010Census_DP1.zip
shp/census-2010_counties.shp: gz/census-2010/County_2010Census_DP1.zip

gdb/acs-2014/ACS_2014_5YR_STATE.gdb: gz/acs-2014/ACS_2014_5YR_STATE.gdb.zip
	mkdir -p $(dir $@)
	unzip -aq $<
	mv $(notdir $@) $(dir $@)

gdb/acs-2014/ACS_2014_5YR_COUNTY.gdb: gz/acs-2014/ACS_2014_5YR_COUNTY.gdb.zip
	mkdir -p $(dir $@)
	unzip -aq $<
	mv $(notdir $@) $(dir $@)

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

# Census fields
# Total_Pop=DP0010001,Male=DP0010020,Female=DP0010039,Median_age=DP0020001,
# Race_White=DP0080003,Race_Black=DP0080004,Race_Asian=DP0080006,Race_Hispanic=DP0110002

geo/census-2010/states-minimal.json: shp/census-2010_states.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -simplify 0.9 -progress \
	-select GEOID10,STUSPS10,NAME10,DP0010001,DP0010020,DP0010039,DP0020001,DP0080003,DP0080004,DP0080006,DP0110002 \
	$@ $<

shp/acs-2014/states:
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -simplify 0.9 -progress $@ gz/acs-2014/ACS_2014_5YR_STATE.gdb

csv/acs-2014/states: gdb/acs-2014/ACS_2014_5YR_STATE.gdb
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

csv/acs-2014/counties: gdb/acs-2014/ACS_2014_5YR_COUNTY.gdb
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

#!!# fails to output layers
geo/acs-2014/states.json:
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -simplify 0.9 -progress -skipfailures $@ shp/acs-2014/states/ACS_2014_5YR_STATE.shp

geo/census-2010/%-full.json: shp/census-2010_%.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -simplify 0.9 -progress $@ $<

##### clean targets ##########
clean-all: clean/shp clean/geo clean/csv clean/gdb

clean/%:
	rm -rf $(notdir $@)
