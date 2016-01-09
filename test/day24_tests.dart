import 'package:test/test.dart';
import 'package:adventOfCode/grouping.dart';

const List<String> packageWeights = const [
'1', '2', '3', '4', '5', '7', '8', '9', '10', '11'
];

void _puzzle1() {
  test('run turing instr', () {
    expect(getBestQe(packageWeights), 99);
  });
}

void main() {
  _puzzle1();
}
