import 'package:logging/logging.dart';
import 'package:adventOfCode/code.dart';

const int row = 2947;
const int col = 3029;

main(List<String> arguments) async {
  Logger.root.level = Level.ALL;
//  Logger.root.onRecord.listen((LogRecord rec) {
//    print('${rec.message}');
//  });

  print(
      'DAY 25 -- PUZZLE1!\n  The code for Row $row Column $col is ${getCode(2947, 3029)}');
}
