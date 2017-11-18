# http://www.naturalearthdata.com/downloads/
# SCALES: 10m 50m 110m
BIN = ../node_modules/.bin
NATURAL_EARTH_CDN = http://naciscdn.org/naturalearth

all: geo/world-places.json csv/world-places.csv

.SECONDARY:

gz/ne_10m_populated_places_simple.zip:
	mkdir -p $(dir $@)
	curl -L "$(NATURAL_EARTH_CDN)/10m/cultural/ne_10m_populated_places_simple.zip" -o $@.download
	mv $@.download $@

# Admin 0 – countries (5.08M)
shp/ne_10m_populated_places_simple.shp: gz/ne_10m_populated_places_simple.zip
	mkdir -p $(dir $@)
	unzip -d shp $<
	touch $@

geo/world-places.json: shp/ne_10m_populated_places_simple.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'GeoJSON' -select adm0name,adm1name,name,pop_max $@ $<

csv/world-places.csv: shp/ne_10m_populated_places_simple.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

clean-all: clean/shp clean/topo clean/csv

clean/%:
	rm -rf $(notdir $@)
