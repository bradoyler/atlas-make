#

all: us-towns us-cities us-demographics

.PHONY: us-towns

us-towns:
	cd us-towns && make

.PHONY: us-cities

us-cities:
	cd us-cities && make

.PHONY: us-demographics

us-demographics:
	cd us-demographics && make

clean-all:
	cd us-demographics && make clean-all
	cd us-towns && make clean-all
	cd us-cities && make clean-all
