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

void main() {
  _puzzle1();
}
