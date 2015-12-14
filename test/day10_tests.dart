import 'package:test/test.dart';
import 'package:adventOfCode/look_and_say.dart';

void _puzzle1() {
  test('buildLookAndSee', () {
    expect(buildLookAndSay('1', count: 1), '11');
    expect(buildLookAndSay('11', count: 1), '21');
    expect(buildLookAndSay('21', count: 1), '1211');
    expect(buildLookAndSay('1211', count: 1), '111221');
    expect(buildLookAndSay('111221', count: 1), '312211');
    expect(buildLookAndSay('1', count: 5), '312211');
  });
}

void main() {
  _puzzle1();
}
