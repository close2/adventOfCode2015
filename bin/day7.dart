import 'dart:io';
import 'package:adventOfCode/wire_logic.dart';

main(List<String> arguments) async {
  var instructions = await new File('lib/puzzle_inputs/day7.txt').readAsLines();
  var wireA = readWire('a', instructions);
  print('DAY 7 -- PUZZLE1!\n  Value on wire a is: $wireA');
  print('DAY 7 -- PUZZLE2!\n  Value on wire a with override on b is: ${readWireWithOverride('a', instructions, 'b', wireA)}');
}