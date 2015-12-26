library container;

import 'package:more/iterable.dart';

int countCombinations(Iterable<int> container, int target, {bool stopWithMinContainer: false}) {
  int _sum(int i, int j) => i + j;

  bool isTarget(List<dynamic> perm) =>
      (perm as List<int>).fold(0, _sum) == target;

  int res = 0;
  for (int i = 1; i < container.length; i++) {
    res +=
        combinations(container, i, repetitions: false).where(isTarget).length;
    if (res != 0 && stopWithMinContainer) break;
  }
  return res;
}
