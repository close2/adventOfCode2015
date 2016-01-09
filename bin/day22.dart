import 'package:logging/logging.dart';
import 'package:adventOfCode/wizard.dart';

const int bossHitPoints = 71;
const int bossDamage = 10;

main(List<String> arguments) async {
  Logger.root.level = Level.ALL;
  //Logger.root.onRecord.listen((LogRecord rec) {
  //  print('${rec.message}');
  //});

  print(
      'DAY 22 -- PUZZLE1!\n  Least amount of mana to kill boss: ${mana(bossHitPoints, bossDamage)}');
  print(
      'DAY 22 -- PUZZLE2!\n  Least amount of mana to kill boss (hard): ${mana(bossHitPoints, bossDamage, levelHard: true)}');
}
