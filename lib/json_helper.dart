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

int _sumIntsInJsonExclude(var totalInput, {String exclude: 'red'}) {
  int sumIntsInJsonExclude(var input) {
    if (input is num) return input;
    if (input is List || input is Iterable) {
      return input.map(sumIntsInJsonExclude).fold(0, (prev, i) => prev + i);
    }
    if (input is Map) {
      if (exclude != null && input.values.contains(exclude)) return 0;
      return sumIntsInJsonExclude(input.values);
    }
    return 0;
  }
  return sumIntsInJsonExclude(totalInput);
}

int sumIntsInJsonExclude(String input, {String exclude: 'red'}) {
  var v = JSON.decode(input);
  return _sumIntsInJsonExclude(v, exclude: exclude);
}
