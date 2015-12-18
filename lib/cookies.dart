library cookies;

const List<String> properties = const [
  'capacity',
  'durability',
  'flavor',
  'texture',
  'calories'
];

class Ingredient {
  final String name;
  final Map<String, int> properties;

  Ingredient(this.name, this.properties);

  factory Ingredient.fromString(String s) {
    var split = s.split(' ');
    // 0             1        2   3          4   5      6  7       8  9        10
    // Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8

    int toNum(String s) => int.parse(s.replaceAll(',', ''));
    var properties = <String, int>{};
    for (int i = 1; i < 10; i += 2) {
      properties[split[i]] = toNum(split[i + 1]);
    }
    return new Ingredient(split[0], properties);
  }
}

int _calculateScore(List<Ingredient> ingredients, List<int> amounts, int caloriesMustEq) {
  Map<String, int> sums = <String, int>{};
  for (int i = 0; i < amounts.length; i++) {
    properties.forEach((String prop) {
      sums.putIfAbsent(prop, () => 0);
      sums[prop] += ingredients[i].properties[prop] * amounts[i];
    });
  }
  if (caloriesMustEq != null && sums['calories'] != caloriesMustEq) return 0;
  sums.remove('calories');
  return sums.values
      .map((int i) => i < 0 ? 0 : i)
      .reduce((int i1, int i2) => i1 * i2);
}

int _findBestAmounts(List<Ingredient> ingredients, int caloriesMustEq) {
  final stopAt = ingredients.length - 1;
  List<int> amounts = new List<int>(ingredients.length);
  int findBestAmount(int remaining, int currentIngredient) {
    if (remaining == 0) return _calculateScore(ingredients, amounts, caloriesMustEq);
    if (stopAt == currentIngredient) {
      amounts[currentIngredient] = remaining;
      return findBestAmount(0, currentIngredient);
    }
    var bestScore = -1;
    for (int i = 0; i <= remaining; i++) {
      amounts[currentIngredient] = i;
      var currentScore = findBestAmount(remaining - i, currentIngredient + 1);
      if (currentScore > bestScore) bestScore = currentScore;
    }
    return bestScore;
  }
  return findBestAmount(100, 0);
}

int getHighestCookieScore(List<String> ingredientStrings, {int caloriesMustEq: null}) {
  List<Ingredient> ingredients = ingredientStrings.map((s) => new Ingredient.fromString(s)).toList(growable: false);
  return _findBestAmounts(ingredients, caloriesMustEq);
}
