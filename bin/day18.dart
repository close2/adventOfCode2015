import 'dart:io';
import 'package:adventOfCode/lights2.dart';

main(List<String> arguments) async {
  var initState = await new File('lib/puzzle_inputs/day18.txt').readAsLines();
  print(
      'DAY 18 -- PUZZLE1!\n  Lights on after 100 iterations: ${countLightsOn(initState)}');
  print(
      'DAY 18 -- PUZZLE2!\n  Lights on after 100 iterations, corners always on: ${countLightsOn(initState, cornerAlwaysOn: true)}');
}
