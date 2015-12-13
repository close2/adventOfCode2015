import 'dart:io';
import 'package:adventOfCode/lights.dart';

main(List<String> arguments) async {
  var instructions = await new File('lib/puzzle_inputs/day6.txt').readAsLines();
  print('DAY 6 -- PUZZLE1!\n  Lights which are on: ${countLights(instructions)}');
  print('DAY 6 -- PUZZLE2!\n  Total brightness: ${calculateTotalBrightness(instructions)}');
}