library escaped_strings;

import 'dart:convert';


/* DOESN'T WORK
String _unescape(String s) {
  return JSON.decode(s);
}
*/

String _unescape(String s) {
  s = s.replaceAll(r'\\', '.');
  s = s.replaceAll(r'\"', '.');
  s = s.replaceAll(new RegExp(r'\\x..'), '.');
  s = s.replaceFirstMapped(new RegExp(r'^"(.*)"$'), (m) => m[1]);
  return s;
}

String _escape(String s) {
  return JSON.encode(s);
}

int differenceToUnescaped(List<String> input) {
  int totalInputLength = input.fold(0, (prev, s) => prev + s.length);
  int totalMemLength = input.map(_unescape).fold(0, (prev, s) => prev + s.length);
  return totalInputLength - totalMemLength;
}

int differenceToEscaped(List<String> input) {
  int totalInputLength = input.fold(0, (prev, s) => prev + s.length);
  int totalEscapedLength = input.map(_escape).fold(0, (prev, s) => prev + s.length);
  return totalEscapedLength - totalInputLength;

}