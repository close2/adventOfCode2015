import 'dart:io';
import 'package:adventOfCode/visiting_santa.dart';

main(List<String> arguments) async {
  var distances = await new File('lib/puzzle_inputs/day9.txt').readAsLines();
  print('DAY 9 -- PUZZLE1!\n  Shortest path length: ${findPathLength(distances)}');
  print('DAY 9 -- PUZZLE2!\n  Shortest path length: ${findPathLength(distances, shortest: false)}');
}