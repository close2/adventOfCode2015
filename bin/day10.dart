import 'package:adventOfCode/look_and_say.dart';

const puzzleInput = '1113222113';

main(List<String> arguments) {
  print('DAY 10 -- PUZZLE1!\n  Length of $puzzleInput after 40 iterations: ${buildLookAndSay(puzzleInput).length}');
  print('DAY 10 -- PUZZLE2!\n  Length of $puzzleInput after 50 iterations: ${buildLookAndSay(puzzleInput, count: 50).length}');
}