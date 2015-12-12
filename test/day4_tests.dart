import 'package:test/test.dart';
import 'package:adventOfCode/advent_coins.dart';

void _puzzle1() {
  test('findLowestNumber', () {
    expect(findLowestNumber('abcdef'), 609043);
    expect(findLowestNumber('pqrstuv'), 1048970);
  });
}

void main() {
  _puzzle1();
}
