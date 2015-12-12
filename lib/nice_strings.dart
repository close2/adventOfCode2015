library nice_strings;


const vowels = const ['a', 'e', 'i', 'o', 'u'];

bool isNiceString(String input) {
  const List<String> notAllowed = const ['ab', 'cd', 'pq', 'xy'];
  var pattern = '(' + notAllowed.join('|') + ')';
  if (input.contains(new RegExp(pattern))) return false;

  const int minVowelsCount = 3;
  var vowelsPattern = '(' + vowels.join('|') + ')';
  var vowelsIterable = new Iterable<String>.generate(minVowelsCount, (_) => vowelsPattern);

  var goodPatternVowels = vowelsIterable.join('.*');
  if (!input.contains(new RegExp(goodPatternVowels))) return false;

  var doubleLetterPattern = r'(.)\1';
  var goodPatternDoubleLetters = doubleLetterPattern;
  if (!input.contains(new RegExp(goodPatternDoubleLetters))) return false;

  return true;
}


