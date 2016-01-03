import 'package:adventOfCode/present_delivery.dart';

const int input = 29000000;

main(List<String> arguments) async {
  print(
      'DAY 20 -- PUZZLE1!\n  Lowest house # with >= $input presents: ${findLowestHouseNumber(input)}');
  print(
      'DAY 20 -- PUZZLE2!\n  Lowest house # with >= $input presents: ${findLowestHouseNumber(input, presentsPerElf: 11, stopAfter: 50)}');
}
