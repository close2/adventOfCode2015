library replacement;

import 'package:more/collection.dart' as more;

Map<String, List<String>> buildRules(List<String> ruleDescriptions,
    {bool reverse: false}) {
  var indexFrom = reverse ? 1 : 0;
  var indexTo = reverse ? 0 : 1;
  var result = <String, List<String>>{};
  ruleDescriptions.map((String _) => _.split(' => ')).forEach(
      (List<String> rule) => result
          .putIfAbsent(rule[indexFrom], () => <String>[])
          .add(rule[indexTo]));
  return result;
}

Set<String> _possibleMolecules(
    String molecule, Map<String, List<String>> rules) {
  var outComes = new Set<String>();

  for (int i = 0; i < molecule.length; i++) {
    String prefix = molecule.substring(0, i);
    String subStr = molecule.substring(i);
    rules.keys.forEach((String key) {
      if (subStr.startsWith(key)) {
        var vals = rules[key];
        var replLen = key.length;
        vals.forEach((String val) {
          var newRepl = prefix +
              val +
              ((subStr.length == replLen) ? '' : subStr.substring(replLen));
          outComes.add(newRepl);
        });
      }
    });
  }

  return outComes;
}

int countDistinctReplacements(String molecule, List<String> rulesDescriptions) {
  var rules = buildRules(rulesDescriptions);

  return _possibleMolecules(molecule, rules).length;
}


// See https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju
// for a far more elegant solution
int countRounds(String start, String target, List<String> rulesDescriptions) {
  var rules = <String, String>{};
  rulesDescriptions
      .map((String rd) => more.string(rd).reversed.join('').split(' >= '))
      .forEach((List<String> rd) => rules[rd[0]] = rd[1]);

  var reg = new RegExp('(${rules.keys.join('|')})');

  var count = 0;
  for (String current = more.string(target).reversed.join('');
      current != start;
      count++,
      current = current.replaceFirstMapped(reg, (Match m) => rules[m[1]]));

  return count;
}
