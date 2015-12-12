library nice_strings;

const vowels = const ['a', 'e', 'i', 'o', 'u'];

bool isNiceString(String input) {
  const List<String> notAllowed = const ['ab', 'cd', 'pq', 'xy'];
  var pattern = '(' + notAllowed.join('|') + ')';
  if (input.contains(new RegExp(pattern))) return false;

  var vowelsPattern = '(' + vowels.join('|') + ')';
  var goodPatternVowels = new List.filled(3, vowelsPattern).join('.*');
  if (!input.contains(new RegExp(goodPatternVowels))) return false;

  var doubleLetterPattern = r'(.)\1';
  if (!input.contains(new RegExp(doubleLetterPattern))) return false;

  return true;
}

bool isNiceStringNewRules(String input) {
  var patternPair = r'(..).*\1';
  var patternOneLetter = r'(.).\1';

  return input.contains(new RegExp(patternPair)) &&
      input.contains(new RegExp(patternOneLetter));
}
