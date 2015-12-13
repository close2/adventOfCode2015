import 'package:test/test.dart';
import 'package:adventOfCode/lights.dart';

void _puzzle1() {
  test('countLights', () {
    expect(countLights(['turn on 0,0 through 999,999']), 1000 * 1000);
    expect(countLights(['toggle 0,0 through 999,0']), 1000);
    expect(
        countLights([
          'turn on 0,0 through 999,999',
          'turn off 499,499 through 500,500'
        ]),
        1000 * 1000 - 4);
    expect(
        countLights([
          'turn on 0,0 through 999,999',
          'turn off 499,499 through 500,500',
          'toggle 0,0 through 999,0'
        ]),
        1000 * 1000 - 4 - 1000);
  });
}

void _puzzle2() {
  test('calculateBrightness', () {
    expect(calculateTotalBrightness(['turn on 0,0 through 999,999']), 1000 * 1000);
    expect(calculateTotalBrightness(['toggle 0,0 through 999,0']), 2000);
    expect(
        calculateTotalBrightness([
          'turn on 0,0 through 999,999',
          'turn on 0,0 through 999,999',
          'turn off 499,499 through 500,500'
        ]),
        1000 * 1000 + 1000 * 1000 - 4);
    expect(
        calculateTotalBrightness([
          'turn on 0,0 through 999,999',
          'turn off 499,499 through 500,500',
          'toggle 0,0 through 999,0'
        ]),
        1000 * 1000 - 4 + 2 * 1000);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
