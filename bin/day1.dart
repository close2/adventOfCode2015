import 'dart:io';
import 'package:adventOfCode/floor_calculation.dart';

main(List<String> arguments) async {
  String day1Input = await new File('lib/puzzle_inputs/day1.txt').readAsString();
  print('DAY 1 -- PUZZLE1!\n  Floor: ${findFloor(day1Input)}');
  print('DAY 1 -- PUZZLE2!\n  Position when Entering Basement: ${posEnteringBasement(day1Input)}');


}