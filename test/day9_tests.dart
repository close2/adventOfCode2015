import 'package:test/test.dart';
import 'package:adventOfCode/visiting_santa.dart';

void _puzzle1() {
  test('find shortest path', () {
    expect(
        findPathLength([
          'London to Dublin = 464',
          'London to Belfast = 518',
          'Dublin to Belfast = 141'
        ]),
        605);
  });
}

void _puzzle2() {
  test('find longest path', () {
    expect(
        findPathLength([
          'London to Dublin = 464',
          'London to Belfast = 518',
          'Dublin to Belfast = 141'
        ], shortest: false),
        982);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
