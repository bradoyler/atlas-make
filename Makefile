#

all: us-towns us-cities us-demographics us-states us-counties na-places

.PHONY: us-towns

us-towns:
	cd us-towns && make

.PHONY: us-cities

us-cities:
	cd us-cities && make

.PHONY: us-demographics

us-demographics:
	cd us-demographics && make

.PHONY: us-states

us-states:
	cd us-states && make

.PHONY: us-counties

us-counties:
	cd us-counties && make

.PHONY: na-places

na-places:
	cd na-places && make


##--------------
clean-all:
	cd us-demographics && make clean-all
	cd us-towns && make clean-all
	cd us-cities && make clean-all
	cd us-states && make clean-all
	cd us-counties && make clean-all
	cd na-places && make clean-all
