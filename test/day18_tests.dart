import 'package:test/test.dart';
import 'package:adventOfCode/lights2.dart';

const List<String> initState = const ['.#.#.#',
'...##.',
'#....#',
'..#...',
'#.#..#',
'####..'];

void _puzzle1() {
  test('count lights', () {
    expect(countLightsOn(initState, iterations: 4), 4);
  });
}

void _puzzle2() {
  test('count lights corners always on', () {
    expect(countLightsOn(initState, iterations: 5, cornerAlwaysOn: true), 17);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
