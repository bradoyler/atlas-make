# Index of EIA.gov shape files: https://www.eia.gov/maps/layer_info-m.php
# Index of PHMSA http://www.phmsa.dot.gov/pipeline/library/data-stats/flagged-data-files

all: shp/CrudeOil_Pipelines_US_EIA.shp shp/PetroleumProduct_Pipelines_US_EIA.shp csv/PHMSA

zip/eia/%.zip:
	mkdir -p $(dir $@)
	curl 'http://www.eia.gov/maps/map_data/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

zip/PHMSA_Pipeline_Safety_Flagged_Incidents.zip:
	mkdir -p $(dir $@)
	curl 'http://www.phmsa.dot.gov/staticfiles/PHMSA/DownloadableFiles/Pipeline/PHMSA_Pipeline_Safety_Flagged_Incidents.zip' -o $@.download
	mv $@.download $@

csv/PHMSA:
	mkdir -p $(dir $@)
	unzip -o $< -d $(dir $@)

csv/PHMSA: zip/PHMSA_Pipeline_Safety_Flagged_Incidents.zip
shp/CrudeOil_Pipelines_US_EIA.shp: zip/eia/CrudeOil_Pipelines_US_EIA.zip
shp/CrudeOil_RailTerminals_US_EIA.shp: zip/eia/CrudeOil_RailTerminals_US_EIA.zip
shp/PetroleumProduct_Pipelines_US_EIA.shp: zip/eia/PetroleumProduct_Pipelines_US_EIA.zip
shp/SedimentaryBasins_US_EIA.shp: zip/eia/SedimentaryBasins_US_EIA.zip
shp/PowerPlants_US_EIA.shp: zip/eia/PowerPlants_US_EIA.zip
shp/HGL_Pipelines_US_EIA.shp: zip/eia/HGL_Pipelines_US_EIA.zip


##### clean targets ##########
clean-all: clean/shp clean/csv

clean/%:
	rm -rf $(notdir $@)
