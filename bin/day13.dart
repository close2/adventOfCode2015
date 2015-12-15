import 'dart:io';
import 'package:adventOfCode/happiness.dart';

main(List<String> arguments) async {
  var preferences = await new File('lib/puzzle_inputs/day13.txt').readAsLines();
  print('DAY 13 -- PUZZLE1!\n  Best happiness: ${findBestHappiness(preferences)}');
  print('DAY 13 -- PUZZLE2!\n  Best happiness: ${findBestHappiness(preferences, addNeutral: true)}');
}