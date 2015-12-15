import 'package:test/test.dart';
import 'package:adventOfCode/json_helper.dart';

void _puzzle1WF(String funName, Function f) {
  test('sum ints in json ($funName)', () {
    expect(f('[1,2,3]'), 6);
    expect(f('{"a":2,"b":4}'), 6);
    expect(f('[[[3]]]'), 3);
    expect(f('{"a":{"b":4},"c":-1}'), 3);
    expect(f('{"a":[-1,1]}'), 0);
    expect(f('[-1,{"a":1}]'), 0);
    expect(f('{}'), 0);
    expect(f('[]'), 0);
  });
}

void _puzzle1() {
  _puzzle1WF('sumIntsInJsonString', sumIntsInJsonString);
  _puzzle1WF('sumIntsInJsonString2', sumIntsInJsonString2);
  _puzzle1WF(
      'sumIntsInJsonExclude', (_) => sumIntsInJsonExclude(_, exclude: null));
}

void _puzzle2() {
  test('sum ints in json where !red', () {
    expect(sumIntsInJsonExclude('[1,2,3]'), 6);
    expect(sumIntsInJsonExclude('[1,{"c":"red","b":2},3]'), 4);
    expect(sumIntsInJsonExclude('{"d":"red","e":[1,2,3,4],"f":5}'), 0);
    expect(sumIntsInJsonExclude('[1,"red",5]'), 6);
    expect(sumIntsInJsonExclude('{}'), 0);
    expect(sumIntsInJsonExclude('[]'), 0);
  });
}

void main() {
  _puzzle1();
  _puzzle2();
}
