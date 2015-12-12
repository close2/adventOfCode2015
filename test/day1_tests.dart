import 'package:test/test.dart';
import 'package:adventOfCode/floor_calculation.dart';

void _puzzle1() {
  test('findFloor', () {
    expect(findFloor('(())'), 0);
    expect(findFloor('()()'), 0);
    expect(findFloor('((('), 3);
    expect(findFloor('(()(()('), 3);
    expect(findFloor('))((((('), 3);
    expect(findFloor('())'), -1);
    expect(findFloor('))('), -1);
    expect(findFloor(')))'), -3);
    expect(findFloor(')())())'), -3);
  });
}

void _puzzle2() {
  test('posEnteringBasement', () {
    expect(posEnteringBasement(')'), 1);
    expect(posEnteringBasement('()())'), 5);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
