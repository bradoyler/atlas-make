all: topo/na-rivers.json topo/us-rivers.json

gz/%.zip:
	mkdir -p $(dir $@)
	curl 'https://www.sciencebase.gov/catalog/file/get/4fb55df0e4b04cb937751e02?facet=Lakes_and_Rivers_Shapefile%2FNA_Lakes_and_Rivers%2Fdata%2Fhydrography_l_rivers_v2' -o $@.download
	mv $@.download $@

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

shp/na-rivers.shp: shp/hydrography_l_rivers_v2.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "Shape_Leng > 10000 AND (NAMEEN IS NOT NULL)" $@ $<

shp/us-rivers.shp: shp/hydrography_l_rivers_v2.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'ESRI Shapefile' -where "COUNTRY LIKE 'USA' AND Shape_Leng > 10000 AND (NAMEEN IS NOT NULL)" $@ $<

topo/us-rivers.json: shp/us-rivers.shp
	mkdir -p $(dir $@)
	../node_modules/.bin/topojson \
		-o $@ \
		-q 1E4 \
		-s 0.000001 \
		-p NAMEEN \
		--id-property=UIDENT \
		-- rivers=$<

clean-all: clean/shp clean/topo

clean/%:
	rm -rf $(notdir $@)
