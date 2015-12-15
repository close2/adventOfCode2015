library json_helper;

import 'dart:convert';

int sumIntsInJsonString(String input) {
  int sum = 0;

  sumJson(var key, dynamic j) {
    if (j is num) sum += j;
  }

  JSON.decode(input, reviver: sumJson);

  return sum;
}

int sumIntsInJsonString2(String input) {
  var split =
      input.split(new RegExp(r'[^\d-]+')).where((s) => s != '-' && s != '');
  var ints = split.map(int.parse);
  var sum = ints.fold(0, (prev, i) => prev + i);
  return sum;
}

int _sumIntsInJsonExclude(var input, {String exclude: 'red'}) {
  if (input is num) return input;
  if (input is List || input is Iterable) {
    return input
        .map((_) => _sumIntsInJsonExclude(_, exclude: exclude))
        .fold(0, (prev, i) => prev + i);
  }
  if (input is Map) {
    if (exclude != null && input.values.contains(exclude)) return 0;
    return _sumIntsInJsonExclude(input.values, exclude: exclude);
  }
  return 0;
}

int sumIntsInJsonExclude(String input, {String exclude: 'red'}) {
  var v = JSON.decode(input);
  return _sumIntsInJsonExclude(v, exclude: exclude);
}
