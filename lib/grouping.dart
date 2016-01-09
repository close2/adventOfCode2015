library grouping;

import 'dart:math' as math;

import 'package:logging/logging.dart';

final Logger _logger = new Logger('grouping');

int getBestQe(List<String> sWeights, {int locationCount: 3}) {
  List<int> packages = sWeights.map((String w) => int.parse(w)).toList();

  packages.sort();

  var totalWeight = packages.fold(0, (int prev, int i) => prev + i);
  int targetWeight = totalWeight ~/ locationCount;

  int bestCount = null;
  int bestQe = null;

  bool listStartCorrectly(List<int> l1, List<int> l2) {
    for (int i = 0; i < math.min(l1.length, l2.length); i++) {
      if (l1[i] > l2[i]) return false;
    }
    return true;
  }

  var packageCount = packages.length;
  var placedPackages =
      new List<List<int>>.generate(locationCount, (int i) => <int>[]);
  List<int> locationWeights = new List<int>.filled(locationCount, 0);

  void partition() {
    // do not continue if
    // * bestCount is already better than smallest current length
    var minLength = placedPackages.fold(
        packageCount, (int prev, List<int> l1) => math.min(prev, l1.length));
    if (bestCount != null && bestCount < minLength) return;
    // * first package(s) in 3rd list are lower than package(s) in 2nd list.
    //   We don't want to try the same combinations again.
    for (int j = 1; j < locationCount - 2; j++) {
      if (!listStartCorrectly(placedPackages[j], placedPackages[j + 1])) return;
    }

    if (packages.isEmpty) {
      // verify targetWeights
      assert(locationWeights.every((int i) => i == targetWeight));

      // check QE
      for (int i = 0; i < placedPackages.length; i++) {
        var p = placedPackages[i];
        if (p.length == minLength) {
          var qe = p.fold(1, (int prev, int package) => prev * package);
          if (bestCount == null ||
              minLength < bestCount ||
              minLength == bestCount && bestQe > qe) {
            bestCount = minLength;
            bestQe = qe;
            _logger.fine(
                'Found better partition. Count: $bestCount, QE: $bestQe, partitions: $placedPackages');
          }
        }
      }
      return;
    }

    int current = packages.removeLast();
    for (int i = 0; i < locationCount; i++) {
      if (locationWeights[i] + current <= targetWeight) {
        // try
        placedPackages[i].add(current);
        locationWeights[i] += current;

        partition();

        // undo
        placedPackages[i].removeLast();
        locationWeights[i] -= current;
      }
    }
    // put current back:
    packages.add(current);
  }

  var last = packages.removeLast();
  placedPackages[0].add(last);
  locationWeights[0] = last;
  partition();
  return bestQe;
}
