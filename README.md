# Atlas Make

A toolbelt for building many different data formats via public Shape files (census.gov, usgs.gov)

### Install System prereqs (Linux/MacOSX):

```
$ brew install node
$ brew install gdal
```

### Clone repo and install dependencies

```
$ git clone https://github.com/bradoyler/atlas-make.git
$ cd atlas-make
$ npm install
```

### Make all targets/recipes

```
$ make all
```
this may take about 15mins, so try `$ make us-states` first

### Current make targets
- [`na-places`](./na-places/README.md) (populated places in North America )
- [`us-states`](./us-states)
- [`us-counties`](./us-counties)
- [`us-towns`](./us-towns) (county subdivisions)
- [`us-cities`](./us-cities)
- [`us-demographics`](./us-demographics)
- [`us-transportation`](./us-transportation)
- [`us-congress`](./us-congress)


### Future plans:
- expand `us-demographics` data (Census & ACS)
- recipes for inserting data into PostgreSQL
- a `world-countries` target
- more map layers: roads, airports, etc.
- rendered map examples using [D3.js](https://d3js.org/) & [D3-Node](https://github.com/bradoyler/d3-node)

#### Inspiration
- [Why Use Make](https://bost.ocks.org/mike/make/)
