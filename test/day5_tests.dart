import 'package:test/test.dart';
import 'package:adventOfCode/nice_strings.dart';

void _puzzle1() {
  test('isNiceString', () {
    expect(isNiceString('ugknbfddgicrmopn'), true);
    expect(isNiceString('aaa'), true);
    expect(isNiceString('jchzalrnumimnmhp'), false);
    expect(isNiceString('haegwjzuvuyypxyu'), false);
    expect(isNiceString('dvszwmarrgswjxmb'), false);
  });
}

void _puzzle2() {
  test('isNiceStringNewRules', () {
    expect(isNiceStringNewRules('qjhvhtzxzqqjkmpb'), true);
    expect(isNiceStringNewRules('xxyxx'), true);
    expect(isNiceStringNewRules('uurcxstgmygtbstg'), false);
    expect(isNiceStringNewRules('ieodomkazucvgmuy'), false);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
