library house_visiting;

int _countVisitedHouses(String directions, {bool roboSanta: false}) {
  var visitedHouses = new Set<String>();

  var x = [0, 0];
  var y = [0, 0];

  var santaIndex = 0;

  visitedHouses.add('${x[0]}.${y[0]}');
  for (int i = 0; i < directions.length; i++) {
    var dir = directions[i];
    switch(dir) {
      case '>': x[santaIndex]++; break;
      case '<': x[santaIndex]--; break;
      case '^': y[santaIndex]++; break;
      case 'v': y[santaIndex]--; break;
    }
    visitedHouses.add('${x[santaIndex]}.${y[santaIndex]}');
    if (roboSanta) santaIndex = (santaIndex + 1) % 2;
  }

  return visitedHouses.length;
}

int countVisitedHouses(String directions) {
  return _countVisitedHouses(directions);
}

int countVisitedHousesWithRoboSanta(String directions) {
  return _countVisitedHouses(directions, roboSanta: true);
}
