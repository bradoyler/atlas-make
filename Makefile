# Atlas-make - master makefile

TARGETS=na-places us-demographics us-towns us-cities us-counties us-transportation

all: ${TARGETS}

.PHONY: ${TARGETS}

na-places:
	cd na-places && make

us-towns:
	cd us-towns && make

us-cities:
	cd us-cities && make

us-demographics:
	cd us-demographics && make

us-states:
	cd us-states && make

us-counties:
	cd us-counties && make

us-transportation:
	cd us-transportation && make

##--------------
clean-all:
	cd na-places && make clean-all
	cd us-demographics && make clean-all
	cd us-towns && make clean-all
	cd us-cities && make clean-all
	cd us-states && make clean-all
	cd us-counties && make clean-all
	cd us-transportation && make clean-all
