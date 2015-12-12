import 'package:test/test.dart';
import 'package:adventOfCode/paper_wrapping.dart';

void _puzzle1() {
  test('calculateWrapping', () {
    expect(calculateWrapping('2x3x4'), 58);
    expect(calculateWrapping('1x1x10'), 43);
  });
}

void _puzzle2() {
  test('calculateRibbon', () {
    expect(calculateRibbon('2x3x4'), 34);
    expect(calculateRibbon('1x1x10'), 14);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
