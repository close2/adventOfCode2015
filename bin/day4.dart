import 'package:adventOfCode/advent_coins.dart';

const puzzleInput = 'iwrupvqb';

main(List<String> arguments) {
  print('DAY 4 -- PUZZLE1!\n  Lowest Number for hash with 5 leading 0s: ${findLowestNumber(puzzleInput)}');
  print('DAY 4 -- PUZZLE2!\n  Lowest Number for hash with 6 leading 0s: ${findLowestNumber(puzzleInput, prefix: '000000')}');
}