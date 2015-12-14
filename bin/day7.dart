import 'dart:io';
import 'package:adventOfCode/wire_logic.dart' as wl;
import 'package:adventOfCode/wire_logic_regexp.dart' as wlr;

_showResult (Function readWire, Function readWireWithOverride, List<String> instructions){
  var wireA = readWire('a', instructions);
  print('DAY 7 -- PUZZLE1!\n  Value on wire a is: $wireA');
  print('DAY 7 -- PUZZLE2!\n  Value on wire a with override on b is: ${readWireWithOverride('a', instructions, 'b', wireA)}');

}
main(List<String> arguments) async {
  var instructions = await new File('lib/puzzle_inputs/day7.txt').readAsLines();
  print('\n\nUsing instructions.split:\n');
  var sw = new Stopwatch()..start();
  _showResult(wl.readWire, wl.readWireWithOverride, instructions);
  sw.stop();
  print('\nTime used: ${sw.elapsedMicroseconds}');

  print('\n\nUsing regular expressions:\n');
  sw = new Stopwatch()..start();
  _showResult(wlr.readWire, wlr.readWireWithOverride, instructions);
  sw.stop();
  print('\nTime used: ${sw.elapsedMicroseconds}');
}