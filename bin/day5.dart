import 'dart:io';
import 'package:adventOfCode/nice_strings.dart';

main(List<String> arguments) async {
  var strings = await new File('lib/puzzle_inputs/day5.txt').readAsLines();
  var niceStrings = strings.where(isNiceString).length;
  var niceStringsNewRules = strings.where(isNiceStringNewRules).length;
  print('DAY 5 -- PUZZLE1!\n  Count of nice strings: ${niceStrings}');
  print('DAY 5 -- PUZZLE2!\n  Count of nice strings with new rules: ${niceStringsNewRules}');
}