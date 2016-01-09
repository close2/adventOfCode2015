import 'dart:io';

import 'package:logging/logging.dart';
import 'package:adventOfCode/grouping.dart';

main(List<String> arguments) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.message}');
  });

  var packages = new File('lib/puzzle_inputs/day24.txt').readAsLinesSync();
  print(
      'DAY 24 -- PUZZLE1!\n  Best QE: ${getBestQe(packages)}');
  print(
      'DAY 24 -- PUZZLE1!\n  Best QE: ${getBestQe(packages, locationCount: 4)}');
}
