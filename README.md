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

### Included make targets
- us-states
- us-counties
- us-towns (county subdivisions)
- us-cities
- us-demographics

### TODOs:
- world maps
- expand on us maps
- add recipes for Postgres via gdal

#### Inspiration
- [Why Use Make](https://bost.ocks.org/mike/make/)
