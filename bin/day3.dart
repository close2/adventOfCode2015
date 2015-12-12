import 'dart:io';
import 'package:adventOfCode/house_visiting.dart';

main(List<String> arguments) async {
  String day3Input = await new File('lib/puzzle_inputs/day3.txt').readAsString();
  print('DAY 3 -- PUZZLE1!\n  Visited houses: ${countVisitedHouses(day3Input)}');
  print('DAY 3 -- PUZZLE2!\n  Visited houses with Robo-Santa: ${countVisitedHousesWithRoboSanta(day3Input)}');
}