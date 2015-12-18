import 'dart:io';
import 'package:adventOfCode/cookies.dart';

main(List<String> arguments) async {
  var ingredients = await new File('lib/puzzle_inputs/day15.txt').readAsLines();
  print(
      'DAY 15 -- PUZZLE1!\n  Highest cookie score: ${getHighestCookieScore(ingredients)}');
  print(
      'DAY 15 -- PUZZLE2!\n  Highest cookie score with 500 calories: ${getHighestCookieScore(ingredients, caloriesMustEq: 500)}');
}
