import 'dart:io';
import 'package:adventOfCode/nice_strings.dart';

const puzzleInput = 'iwrupvqb';

main(List<String> arguments) async {
  var strings = await new File('lib/puzzle_inputs/day5.txt').readAsLines();
  var niceStrings = strings.where(isNiceString).length;
  print('DAY 5 -- PUZZLE1!\n  Count of nice strings: ${niceStrings}');
}