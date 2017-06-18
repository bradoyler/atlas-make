# http://www.naturalearthdata.com/downloads/
# SCALES: 10m 50m 110m
BIN = ../node_modules/.bin
NATURAL_EARTH_CDN = http://naciscdn.org/naturalearth

all: topo/world-110m.json csv/world-countries.csv

.SECONDARY:

gz/ne_10m_%.zip:
	mkdir -p $(dir $@)
	curl -L "$(NATURAL_EARTH_CDN)/10m/cultural/ne_10m_$*.zip" -o $@.download
	mv $@.download $@

gz/ne_50m_%.zip:
	mkdir -p $(dir $@)
	curl -L "$(NATURAL_EARTH_CDN)/50m/cultural/ne_50m_$*.zip" -o $@.download
	mv $@.download $@

gz/ne_110m_%.zip:
	mkdir -p $(dir $@)
	curl -L "$(NATURAL_EARTH_CDN)/110m/cultural/ne_110m_$*.zip" -o $@.download
	mv $@.download $@

# Admin 0 – countries (5.08M)
shp/ne_%_admin_0_countries.shp: gz/ne_%_admin_0_countries.zip
	mkdir -p $(dir $@)
	unzip -d shp $<
	touch $@

# created w/ basic props, countries & land collection
topo/world-%.json: shp/ne_%_admin_0_countries.shp
	mkdir -p $(dir $@)
	$(BIN)/topojson \
		--quantization 1e5 \
		--properties name,type,abbrev,postal,pop_est,continent \
		--id-property=+iso_n3 \
		-- countries=shp/ne_$*_admin_0_countries.shp \
		| $(BIN)/topojson-merge \
			-o $@ \
			--io=countries \
			--oo=land \
			--no-key

csv/world-countries.csv: shp/ne_110m_admin_0_countries.shp
	mkdir -p $(dir $@)
	rm -f $@
	ogr2ogr -f 'CSV' -progress $@ $<

clean-all: clean/shp clean/topo clean/csv

clean/%:
	rm -rf $(notdir $@)
