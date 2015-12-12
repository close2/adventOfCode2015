import 'dart:io';
import 'package:adventOfCode/paper_wrapping.dart';

main(List<String> arguments) async {
  List<String> day2Input = await new File('lib/puzzle_inputs/day2.txt').readAsLines();
  int neededPaper = day2Input.fold(0, (prev, p) => prev + calculateWrapping(p));
  print('DAY 2 -- PUZZLE1!\n  Needed paper: $neededPaper');

  int neededRibbon = day2Input.fold(0, (prev, p) => prev + calculateRibbon(p));
  print('DAY 2 -- PUZZLE2!\n  Needed ribbon: $neededRibbon');
}