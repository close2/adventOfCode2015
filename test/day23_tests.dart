import 'package:test/test.dart';
import 'package:adventOfCode/turing.dart';

const List<String> strInstructions = const [
'inc a',
'jio a, +2',
'tpl a',
'inc a'
];

void _puzzle1() {
  test('run turing instr', () {
    expect(getState(strInstructions).regs[Reg.a], 2);
  });
}

void main() {
  _puzzle1();
}
