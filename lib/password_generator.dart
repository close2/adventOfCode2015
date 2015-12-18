library password_generator;

bool isValidPassword(List<int> password) {
  int doubles = 0;
  int threeInRow = 0;
  for (int i = 2; i < password.length; i++) {
    if (password[i - 1] == password[i]) {
      doubles++;
      i = i + 1; // skip next check.
    } else if (password[i - 2] == password[i - 1] - 1 &&
        password[i - 1] == password[i] - 1) {
      threeInRow++;
    }
  }
  return doubles >= 2 && threeInRow >= 1;
}

String findNextPassword(String password) {
  var pw = new List<int>.from(password.codeUnits);

  var invalid = new Set.from(['i', 'o', 'l'].map((_) => _.codeUnitAt(0)));
  var a = 'a'.codeUnitAt(0);
  var z = 'z'.codeUnitAt(0);

  // remove invalid codeUnits
  for (int i = 0; i < pw.length; i++) {
    if (invalid.contains(pw[i])) {
      pw[i] = pw[i] + 1;
      for (int j = i + 1; j < pw.length; j++) pw[j] = a;
      // should break here, but don't really care
    }
  }

  do {
    for (int c = pw.length - 1; c >= 0; c--) {
      if (pw[c] == z) {
        pw[c] = a;
        continue;
      } else {
        pw[c] = pw[c] + 1;
        if (invalid.contains(pw[c])) pw[c] = pw[c] + 1;
      }
      break;
    }
  } while (!isValidPassword(pw));
  return new String.fromCharCodes(pw);
}
