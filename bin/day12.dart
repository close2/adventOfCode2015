import 'dart:io';
import 'package:adventOfCode/json_helper.dart';

main(List<String> arguments) async {
  var input = await new File('lib/puzzle_inputs/day12.txt').readAsString();
  var sum = sumIntsInJsonString(input);
  var sum2 = sumIntsInJsonString2(input);
  var sum3 = sumIntsInJsonExclude(input, exclude: null);
  print('DAY 12 -- PUZZLE1!\n  Sum (json decoder -- 37ms): $sum');
  print('  Sum (string split -- 15ms): $sum2');
  print('  Sum (json recursive -- 44ms): $sum3');
  print('DAY 12 -- PUZZLE2!\n  Sum without red: ${sumIntsInJsonExclude(input)}');
}
