import 'dart:io';
import 'package:adventOfCode/aunt_sue.dart';

const tickerTapeString = '''
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1''';

final tickerTape = new Map<String, String>.fromIterable(
    tickerTapeString.split('\n').map((String line) => line.split(': ')),
    key: (List<String> v) => v[0],
    value: (List<String> v) => v[1]);

main(List<String> arguments) async {
  var aunts = await new File('lib/puzzle_inputs/day16.txt').readAsLines();
  print('DAY 16 -- PUZZLE1!\n  Aunt: ${findAunt(tickerTape, aunts)}');
  print(
      'DAY 16 -- PUZZLE2!\n  Aunt: ${findAunt(tickerTape, aunts, adaptReadings: true)}');
}
