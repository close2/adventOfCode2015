import 'dart:io';
import 'package:adventOfCode/turing.dart';
import 'package:logging/logging.dart';

main(List<String> arguments) {
  Logger.root.level = Level.ALL;
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   print('${rec.message}');
  // });

  var stringInstr = new File('lib/puzzle_inputs/day23.txt').readAsLinesSync();
  print(
      'DAY 23 -- PUZZLE1!\n  Reg b at the end: ${getState(stringInstr).regs[Reg.b]}');
  print('DAY 23 -- PUZZLE1v2!\n  Reg b at the end: ${getB(stringInstr)}');

  var state = new State();
  state.regs[Reg.a] = 1;
  print(
      'DAY 23 -- PUZZLE2!\n  Reg b at the end when reg a starts as 1: ${getState(stringInstr, state).regs[Reg.b]}');
  print(
      'DAY 23 -- PUZZLE2v2!\n  Reg b at the end when reg a starts as 1: ${getB(stringInstr, a: 1)}');
}
