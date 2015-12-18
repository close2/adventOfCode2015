library reindeer;

import 'dart:math';
import 'package:more/iterable.dart';

class Reindeer {
  final String name;
  final int speed;
  final int flyDuration;
  final int restDuration;

  Reindeer(this.name, this.speed, this.flyDuration, this.restDuration);
  factory Reindeer.fromDescription(String description) {
    var split = description.split(' ');
    // 0      1   2   3  4    5   6 7        8   9    10   11   12  13  14
    // Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds.
    return new Reindeer(split[0], int.parse(split[3]), int.parse(split[6]),
        int.parse(split[13]));
  }

  int calcDistanceAfter(int seconds) {
    var d1 = speed * flyDuration * (seconds ~/ (flyDuration + restDuration));
    var remaining = seconds % (flyDuration + restDuration);
    var d2 = speed * min(remaining, flyDuration);

    return d1 + d2;
  }
}

int getMaxDistance(List<String> reindeerDescriptions, int raceDuration) {
  var reindeers =
      reindeerDescriptions.map((_) => new Reindeer.fromDescription(_));

  return reindeers.map((r) => r.calcDistanceAfter(raceDuration)).reduce(max);
}

int getMaxScore(List<String> reindeerDescriptions, int raceDuration) {
  var reindeers =
      reindeerDescriptions.map((_) => new Reindeer.fromDescription(_));

  var reindeerNames = reindeers.map((Reindeer r) => r.name);

  var distancePerSec = <String, List<int>>{};
  reindeerNames.forEach(
      (String name) => distancePerSec[name] = new List<int>(raceDuration));

  var maxDistancePerSec = new List<int>(raceDuration);

  for (int i = 1; i < raceDuration; i++) {
    var maxThisSecond = 0;
    reindeers.forEach((Reindeer r) {
      var dist = r.calcDistanceAfter(i);
      distancePerSec[r.name][i] = dist;
      maxThisSecond = max(dist, maxThisSecond);
    });
    maxDistancePerSec[i] = maxThisSecond;
  }

  var scores = new Map<String, num>.fromIterables(
      reindeerNames, repeat(0, reindeers.length) as Iterable<int>);
  for (int i = 1; i < raceDuration; i++) {
    reindeerNames.forEach((String name) {
      if (distancePerSec[name][i] == maxDistancePerSec[i]) scores[name]++;
    });
  }

  return scores.values.reduce(max);
}
