import 'dart:io';
import 'package:adventOfCode/escaped_strings.dart';

main(List<String> arguments) async {
  var input = await new File('lib/puzzle_inputs/day8.txt').readAsLines();
  print('DAY 8 -- PUZZLE1!\n  Difference: ${differenceToUnescaped(input)}');
  print('DAY 8 -- PUZZLE2!\n  Difference: ${differenceToEscaped(input)}');
}