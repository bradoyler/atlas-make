# Index of EIA.gov shape files: https://www.eia.gov/maps/layer_info-m.php
# Index of PHMSA http://www.phmsa.dot.gov/pipeline/library/data-stats/flagged-data-files

all: shp/CrudeOil_Pipelines_US_EIA.shp shp/PetroleumProduct_Pipelines_US_EIA.shp csv/PHMSA_Pipeline/files

zip/eia/%.zip:
	mkdir -p $(dir $@)
	curl -L 'http://www.eia.gov/maps/map_data/$(notdir $@)' -o $@.download
	mv $@.download $@

shp/%.shp:
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

zip/PHMSA_Pipeline_Safety_Flagged_Incidents.zip:
	mkdir -p $(dir $@)
	curl -L 'http://www.phmsa.dot.gov/staticfiles/PHMSA/DownloadableFiles/Pipeline/PHMSA_Pipeline_Safety_Flagged_Incidents.zip' -o $@.download
	mv $@.download $@

zip/annual_hazardous_liquid_2010_present.zip:
	mkdir -p $(dir $@)
	curl -L 'http://phmsa.dot.gov/staticfiles/PHMSA/DownloadableFiles/Pipeline2data/annual_hazardous_liquid_2010_present.zip' -o $@.download
	mv $@.download $@

csv/%/files:
	mkdir -p $(dir $@)
	unzip -o $< -d $(dir $@)

csv/PHMSA_Pipeline/files: zip/PHMSA_Pipeline_Safety_Flagged_Incidents.zip
csv/PHMSA_Pipeline2data/files: zip/annual_hazardous_liquid_2010_present.zip
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
