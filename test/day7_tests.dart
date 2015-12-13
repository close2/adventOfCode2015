import 'package:test/test.dart';
import 'package:adventOfCode/wire_logic.dart';

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

void _puzzle1() {
  test('readWire', () {
    result.forEach(
        (String wire, int value) => expect(readWire(wire, circuit), value));
  });
}

void main() {
  _puzzle1();
}
