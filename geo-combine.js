var fs = require('fs');

var statesString = 'al ak az ar ca co ct de dc fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy';

var states = statesString.split(' ');
var cities = [];

states.forEach(function (stateCode) {
  fs.readFile('geo/'+ stateCode +'/cities.json', function (err, resp) {
    var geojson = JSON.parse(resp);
    var stateFeatures = JSON.parse(resp).features;
    cities = cities.concat(stateFeatures);

    if(stateCode === 'wy') { // last state
      complete(geojson, cities);
    }
  });
});

function complete(geojson, allcities) {
  geojson.features = allcities;
  fs.writeFile('geo/cities-all.json', JSON.stringify(geojson));
}
