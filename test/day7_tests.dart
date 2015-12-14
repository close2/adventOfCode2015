import 'package:test/test.dart';
import 'package:adventOfCode/wire_logic.dart' as wl;
import 'package:adventOfCode/wire_logic_regexp.dart' as regWl;

const circuit = const [
  '123 -> x',
  '456 -> y',
  'x AND y -> d',
  'x OR y -> e',
  'x LSHIFT 2 -> f',
  'y RSHIFT 2 -> g',
  'NOT x -> h',
  'NOT y -> i',
];

const Map<String, int> result = const {
  'd': 72,
  'e': 507,
  'f': 492,
  'g': 114,
  'h': 65412,
  'i': 65079,
  'x': 123,
  'y': 456
};

void _puzzle1WithF(String funName, Function readWire) {
  test('readWire ($funName)', () {
    result.forEach(
        (String wire, int value) => expect(readWire(wire, circuit), value));
  });
  test('readWire numbers wires mixed ($funName)', () {
    expect(readWire('y', ['123 -> x', 'x -> y']), 123);
    expect(readWire('a', ['1 LSHIFT 2 -> a']), 4);
    expect(readWire('a', ['2 -> b', '1 LSHIFT b -> a']), 4);
    expect(readWire('a', ['NOT b -> a', '255 -> b']), 0xFF00);
  });
}

void _puzzle1() {
  _puzzle1WithF('readWire', wl.readWire);
  _puzzle1WithF('readWire with regexp', regWl.readWire);
}

void main() {
  _puzzle1();
}
