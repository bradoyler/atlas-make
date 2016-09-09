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

### Current make targets
- `us-states`
- `us-counties`
- `us-towns` (county subdivisions)
- `us-cities`
- `na-places`
- `us-demographics`

### Future plans:
- expand `us-demographics` data (Census & ACS)
- recipes for inserting data into PostgreSQL
- a `world-countries` target
- more map layers: roads, airports, etc.

#### Inspiration
- [Why Use Make](https://bost.ocks.org/mike/make/)
