library aunt_sue;

List<Map<String, String>> _parse(List<String> aunts) {
  // Sue 1: goldfish: 6, trees: 9, akitas: 0
  var auntPropsAsList = aunts.map((String s) => s
      .replaceFirstMapped(
          new RegExp('Sue ([0-9]+):'), (Match m) => 'Sue: ${m[1]},')
      .split(', '));
  return auntPropsAsList
      .map((List<String> propL) => new Map<String, String>.fromIterable(
          propL.map((String s) => s.split(': ')),
          key: (_) => _[0],
          value: (_) => _[1]))
      .toList(growable: false);
}

Map<String, String> findAunt(
    Map<String, String> tickerInput, List<String> auntDescriptions,
    {bool adaptReadings: false}) {
  var aunts = _parse(auntDescriptions);

  bool eq(String aunt, String ticker, String key) {
    if (adaptReadings) {
      if (key == 'cats' || key == 'trees') return int.parse(aunt) >
          int.parse(ticker);
      if (key == 'pomeranians' || key == 'goldfish') return int.parse(aunt) <
          int.parse(ticker);
    }
    return aunt == ticker;
  }

  bool checkAunt(Map<String, String> aunt) {
    var keys = new Set<String>.from(tickerInput.keys)
        .intersection(new Set<String>.from(aunt.keys));
    return keys.fold(
        true,
        (bool prev, String key) =>
            prev && eq(aunt[key], tickerInput[key], key));
  }

  var matchingAunts = aunts.where(checkAunt);
  if (matchingAunts.length > 1) print("MORE THAN ONE AUNT");
  return matchingAunts.first;
}
