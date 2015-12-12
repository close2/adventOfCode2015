import 'package:test/test.dart';
import 'package:adventOfCode/house_visiting.dart';

void _puzzle1() {
  test('countVisitedHouses', () {
    expect(countVisitedHouses('>'), 2);
    expect(countVisitedHouses('^>v<'), 4);
    expect(countVisitedHouses('^v^v^v^v^v'), 2);
  });
}

void _puzzle2() {
  test('countVisitedHousesWithRoboSanta', () {
    expect(countVisitedHousesWithRoboSanta('>'), 2);
    expect(countVisitedHousesWithRoboSanta('^v'), 3);
    expect(countVisitedHousesWithRoboSanta('^>v<'), 3);
    expect(countVisitedHousesWithRoboSanta('^v^v^v^v^v'), 11);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
