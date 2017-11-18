# Atlas-make - master makefile

TARGETS=na-places us-demographics us-energy us-towns us-cities us-states us-counties \
 us-transportation us-congress us-congress-census world-places world-countries

.PHONY: all clean-all ${TARGETS}

all: ${TARGETS}

world-countries:
	cd $@ && make all

world-places:
	cd $@ && make all

na-places:
	cd $@ && make all

us-towns:
	cd $@ && make all

us-towns/topo:
	cd $(dir $@) && make all-topo

us-cities:
	cd $@ && make all

us-demographics:
	cd $@ && make all

us-energy:
	cd $@ && make all

us-demographics/csv:
	cd $(dir $@) && make all-csv

us-states:
	cd $@ && make all

us-counties:
	cd $@ && make all

us-counties/topo:
	cd $(dir $@) && make all-topo

us-transportation:
	cd $@ && make all

us-congress:
	cd $@ && make all

us-congress-census:
	cd $@ && make all


##-- deletes all files except gz/zip files -----
clean-all:
	cd na-places && make clean-all
	cd us-demographics && make clean-all
	cd us-towns && make clean-all
	cd us-cities && make clean-all
	cd us-states && make clean-all
	cd us-counties && make clean-all
	cd us-transportation && make clean-all
	cd us-congress && make clean-all
	cd us-congress-census && make clean-all
	cd world-countries && make clean-all
	cd world-places && make clean-all
	cd us-energy && make clean-all
