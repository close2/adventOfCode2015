import 'package:test/test.dart';
import 'package:adventOfCode/container.dart';

const List<int> container = const [20, 15, 10, 5, 5];

void _puzzle1() {
  test('count combinations', () {
    expect(countCombinations(container, 25), 4);
  });
}

void _puzzle2() {
  test('count combinations with min number', () {
    expect(countCombinations(container, 25, stopWithMinContainer: true), 3);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
