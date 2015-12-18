import 'dart:io';
import 'package:adventOfCode/reindeer.dart';

const raceDuration = 2503;

main(List<String> arguments) async {
  var reindeerDescriptions =
      await new File('lib/puzzle_inputs/day14.txt').readAsLines();
  print('DAY 14 -- PUZZLE1!\n  Max distance after $raceDuration seconds: '
      '${getMaxDistance(reindeerDescriptions, raceDuration)}');
  print('DAY 14 -- PUZZLE1!\n  Max score after $raceDuration seconds: '
      '${getMaxScore(reindeerDescriptions, raceDuration)}');
}
