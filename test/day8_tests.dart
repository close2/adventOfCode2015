import 'package:test/test.dart';
import 'package:adventOfCode/escaped_strings.dart';

void _puzzle1() {
  test('difference to unescaped', () {
    expect(differenceToUnescaped([r'""', r'"abc"', r'"aaa\"aaa"', r'"\x27"']), 12);
  });
}

void _puzzle2() {
  test('difference to escaped', () {
    expect(differenceToEscaped([r'""', r'"abc"', r'"aaa\"aaa"', r'"\x27"']), 19);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
