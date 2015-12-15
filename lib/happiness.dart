library happiness;

import 'package:more/iterable.dart';

int findBestHappiness(List<String> preferences, {bool addNeutral: false}) {
  var happinessChange = new Map<String, Map<String, int>>();

  addPreference(String preference) {
    var split = preference.split(' ');
    // Alice would gain 76 happiness units by sitting next to Mallory.
    // Bob would lose 14 happiness units by sitting next to Alice.
    var who1 = split[0];
    var who2 = split[10].substring(0, split[10].length - 1);
    var amount = int.parse(split[3]) * (split[2] == 'gain' ? 1 : -1);

    happinessChange.putIfAbsent(who1, () => new Map<String, int>());
    happinessChange[who1][who2] = amount;
  }

  preferences.forEach(addPreference);

  var bestHappinessValue = null;
  //var bestArrangement = null;

  findBest(List<String> arrangement) {
    var happinessForArrangement = 0;
    var endAt = addNeutral ? arrangement.length - 1 : arrangement.length;
    // if we have a neutral person.  Assume it always sits at the end
    // and don't wrap around
    for (int i = 0; i < endAt; i++) {
      var guest1 = arrangement[i];
      var guest2 = arrangement[(i + 1) % arrangement.length];
      var hapChange1 = happinessChange[guest1][guest2];
      var hapChange2 = happinessChange[guest2][guest1];
      happinessForArrangement += hapChange1 + hapChange2;
    }
    if (bestHappinessValue == null ||
        bestHappinessValue < happinessForArrangement) {
      bestHappinessValue = happinessForArrangement;
      // bestArrangement = arrangement;
    }
  }

  // Because circular table, we can limit our search to arrangements where
  // always the same person starts.
  // Unless we add a neutral person sitting at the end of the list.
  var guests = happinessChange.keys.toList(growable: false)..sort();
  permutations(guests)
      .where((arrangement) => addNeutral || arrangement.first == guests.first)
      .forEach(findBest);

  return bestHappinessValue;
}
