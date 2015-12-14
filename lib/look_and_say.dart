library look_and_say;

String buildLookAndSay(String start, {count: 40}) {
  var result = start;

  var reg = new RegExp(r'((.)\2*)');

  for (int i =0; i < count; i++) {
    result = result.replaceAllMapped(reg, (m) {
      return '${m[1].length}${m[1][0]}';
    });
  }
  return result;
}