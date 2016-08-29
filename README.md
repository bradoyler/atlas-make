# US Cities

A handy way to build a "Cities" map layer for US and every State. 

### Why

This can be tricky for a few reasons:
- 5 states do not have cities with populations over 100k.
- 1 state does not have a city with population over 50k
- Some states (NJ, FL, etc) have multiple cities with over 150k pop in close proximity
- City labels add some complexity due to overlap and text clipping

City classifications, by state:
- over 30k (VT)
- over 50k (DE, ME, WV, WY)
- over 150k (all other states)

#### Install System prereqs (Linux/MacOSX):

```
$ brew install node
$ brew install gdal
```

#### Clone repo and install dependencies

```
$ git clone https://github.com/bradoyler/us-cities.git
$ cd us-cities
$ npm install
```

#### Build files (via Make)
```
$ make all
```
