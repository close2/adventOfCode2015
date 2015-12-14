import 'package:test/test.dart';
import 'package:adventOfCode/password_generator.dart';

void _puzzle1() {
  test('is valid password', () {
    expect(isValidPassword('hijklmmn'.codeUnits), false);
    expect(isValidPassword('abbceffg'.codeUnits), false);
    expect(isValidPassword('abbcegjk'.codeUnits), false);
    expect(isValidPassword('abcdffaa'.codeUnits), true);
    expect(isValidPassword('ghjaabcc'.codeUnits), true);

  });
  test('find next password', () {
    expect(findNextPassword('abcdefgh'), 'abcdffaa');
    expect(findNextPassword('ghijklmn'), 'ghjaabcc');
  });
}

void main() {
  _puzzle1();
}
