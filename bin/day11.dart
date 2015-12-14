import 'package:adventOfCode/password_generator.dart';

const puzzleInput = 'hepxcrrq';

/*
 * Note that this puzzle may be solved without any code at all! *
 */

main(List<String> arguments) {
  String nextPassword = findNextPassword(puzzleInput);
  print('DAY 11 -- PUZZLE1!\n  Password after $puzzleInput: $nextPassword');
  print('DAY 11 -- PUZZLE2!\n  Password after $nextPassword: ${findNextPassword(nextPassword)}');
}