library visiting_santa;

import 'package:more/iterable.dart' as it;

int findPathLength(List<String> distanceDescriptions, {bool shortest: true}) {
  var distances = new Map<String, Map>();

  addDistance(String distanceDescription) {
    var split = distanceDescription.split(' ');
    // AlphaCentauri to Snowdin = 66
    var from = split[0];
    var to = split[2];
    int distance = int.parse(split[4]);

    distances.putIfAbsent(from, () => new Map<String, int>());
    distances.putIfAbsent(to, () => new Map<String, int>());

    distances[from][to] = distance;
    distances[to][from] = distance;
  }

  var bestDistance = null;
  //var bestRoute = null;

  findBest(List<String> destinations) {
    var distance = 0;
    for (int i = 0; i < destinations.length - 1; i++) {
      var from = destinations[i];
      var to = destinations[i + 1];
      distance = distance + distances[from][to];
    }
    if (bestDistance == null ||
        (shortest && distance < bestDistance) ||
        (!shortest && distance > bestDistance)) {
      bestDistance = distance;
      //bestRoute = destinations;
    }
  }

  distanceDescriptions.forEach(addDistance);

  // lastCity stuff is to prevent unnecessary calculation of reversed path
  var lastCityOfFirstPermutation = null;
  bool startsNotWithLastCityOfFirstPermutation(List<String> cities) {
    if (lastCityOfFirstPermutation == null) {
      lastCityOfFirstPermutation = cities.last;
    }
    return cities.first == lastCityOfFirstPermutation;
  }

  Iterable<List<String>> perm = it.permutations(distances.keys);
  perm.where(startsNotWithLastCityOfFirstPermutation).forEach(findBest);

  return bestDistance;
}
