import 'package:test/test.dart';
import 'package:adventOfCode/cookies.dart';

const List<String> ingredients = const [
  'Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8',
  'Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3'
];

void _puzzle1() {
  test('calculate highest cookie score', () {
    expect(getHighestCookieScore(ingredients), 62842880);
  });
}

void _puzzle2() {
  test('calculate highest cookie score with calories == 500', () {
    expect(getHighestCookieScore(ingredients, caloriesMustEq: 500), 57600000);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
