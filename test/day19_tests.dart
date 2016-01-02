import 'package:test/test.dart';
import 'package:adventOfCode/replacement.dart';

const String molecule1 = 'HOH';
const String molecule2 = 'HOHOHO';

const List<String> ruleDescriptions1 = const ['H => HO', 'H => OH', 'O => HH'];

void _puzzle1() {
  test('count outcomes for $molecule1', () {
    expect(countDistinctReplacements(molecule1, ruleDescriptions1), 4);
  });
  test('count outcomes for $molecule2', () {
    expect(countDistinctReplacements(molecule2, ruleDescriptions1), 7);
  });
}

void main() {
  _puzzle1();
}
