import 'dart:io';
import 'package:adventOfCode/container.dart';

const int target = 150;

main(List<String> arguments) async {
  var container = (await new File('lib/puzzle_inputs/day17.txt').readAsLines())
      .map((String s) => int.parse(s));
  print(
      'DAY 17 -- PUZZLE1!\n  Combinations of containers: ${countCombinations(container, target)}');
  print(
      'DAY 17 -- PUZZLE2!\n  Combinations of minimal number of containers: ${countCombinations(container, target, stopWithMinContainer: true)}');
}
