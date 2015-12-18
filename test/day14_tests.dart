import 'package:test/test.dart';
import 'package:adventOfCode/reindeer.dart';

const List<String> reindeerDescription = const [
  'Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.',
  'Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.',
];

void _puzzle1() {
  test('calculate reindeer distance', () {
    expect(getMaxDistance(reindeerDescription, 1000), 1120);
  });
}

void _puzzle2() {
  test('calculate reindeer score', () {
    expect(getMaxScore(reindeerDescription, 1000), 689);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
