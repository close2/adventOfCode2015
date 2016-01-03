import 'dart:io';
import 'package:adventOfCode/rpg.dart';
import 'package:logging/logging.dart';

main(List<String> arguments) {
  Logger.root.level = Level.ALL;
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   print('${rec.message}');
  // });

  var bossDesc = new File('lib/puzzle_inputs/day21_boss.txt').readAsLinesSync();
  var storeDesc =
      new File('lib/puzzle_inputs/day21_store.txt').readAsLinesSync();
  print(
      'DAY 21 -- PUZZLE1!\n  Minimal gold to beat boss: ${findAmountOfGold(storeDesc, bossDesc)}');
  print(
      'DAY 21 -- PUZZLE2!\n  Max gold to still lose: ${findAmountOfGold(storeDesc, bossDesc, tryToLose: true)}');
}
