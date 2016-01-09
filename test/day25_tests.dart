import 'package:test/test.dart';
import 'package:adventOfCode/code.dart';

void _puzzle1() {
  test('calcCodes', () {
    expect(getCode(1, 1), 20151125);
    expect(getCode(1, 3), 17289845);
    expect(getCode(2, 1), 31916031);
    expect(getCode(3, 3), 1601130);
    expect(getCode(6, 5), 1534922);
    expect(getCode(5, 6), 31663883);
  });
}

void main() {
  _puzzle1();
}
