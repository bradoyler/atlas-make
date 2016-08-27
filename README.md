# US Cities

A handy way to build a "Cities" map layer for US and every State. This can be a little tricky as 5 states do not have cities with populations over 100k.

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
