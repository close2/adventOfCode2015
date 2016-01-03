library rpg;

import 'dart:math' as m;

import 'package:more/iterable.dart';
import 'package:logging/logging.dart';

final Logger _logger = new Logger('rpg');

const int _playerHitpoints = 100;

class _Item {
  final String name;
  final int cost;
  final int damage;
  final int armor;

  _Item(this.name, this.cost, this.damage, this.armor);

  @override
  String toString() => name;
}

class _Character {
  int hitpoints = 0;
  int damage = 0;
  int armor = 0;
}

class _Player extends _Character {
  _Player() {
    this.hitpoints = _playerHitpoints;
  }

  useItems(List<_Item> items) {
    damage = 0;
    armor = 0;
    items.forEach((_Item item) {
      damage += item.damage;
      armor += item.armor;
    });
  }
}

class _Boss extends _Character {
  _Boss.fromDescription(List<String> description) {
    var split = description.map((String l) => l.split(': '));
    var desc = new Map.fromIterable(split,
        key: (List<String> l) => l[0], value: (List<String> l) => l[1]);
    this.hitpoints = int.parse(desc['Hit Points']);
    this.damage = int.parse(desc['Damage']);
    this.armor = int.parse(desc['Armor']);
  }
}

bool _doesPlayerWin(_Player player, _Boss boss) {
  var damageToBoss = m.max(1, player.damage - boss.armor);
  var roundsKillBoss = (boss.hitpoints.toDouble() / damageToBoss).ceil();
  var damageToPlayer = m.max(1, boss.damage - player.armor);
  var roundsKillPlayer = (player.hitpoints.toDouble() / damageToPlayer).ceil();
  return roundsKillBoss <= roundsKillPlayer;
}

class _Store {
  List<_Item> weapons;
  List<_Item> armor;
  List<_Item> rings;

  _Store(this.weapons, this.armor, this.rings);
}

_Store _parseStore(List<String> store) {
  List<_Item> weapons = [];
  List<_Item> armor = [];
  List<_Item> rings = [];

  // Parse lines such as: Damage +1    25     1       0
  var reg = new RegExp('^([^ ]+ *[^ ]+) +([0-9]+) *([0-9]+) *([0-9]+)');

  List<_Item> current;
  store.forEach((String line) {
    if (line.isEmpty) return;
    if (line.startsWith('Weapons:')) {
      current = weapons;
    } else if (line.startsWith('Armor:')) {
      current = armor;
    } else if (line.startsWith('Rings:')) {
      current = rings;
    } else {
      var m = reg.firstMatch(line);
      current.add(
          new _Item(m[1], int.parse(m[2]), int.parse(m[3]), int.parse(m[4])));
    }
  });
  return new _Store(weapons, armor, rings);
}

int findAmountOfGold(List<String> storeText, List<String> bossText,
    {bool tryToLose: false}) {
  var store = _parseStore(storeText);

  var boss = new _Boss.fromDescription(bossText);
  var player = new _Player();

  int bestAmount = null;
  List<_Item> cheapestItems;
  void tryItems(List<_Item> itemsToUse) {
    player.useItems(itemsToUse);
    if (_doesPlayerWin(player, boss) != tryToLose) {
      var cost = itemsToUse.fold(0, (int prev, _Item i) => prev + i.cost);
      if (bestAmount == null || (cost > bestAmount == tryToLose)) {
        bestAmount = cost;
        cheapestItems = itemsToUse;
      }
    }
  }

  store.armor.add(new _Item('no armor', 0, 0, 0));

  var noRing = new _Item('no ring', 0, 0, 0);
  store.rings.add(noRing);

  // Because combinations has no element repeated, we do not have a combination
  // where both rings are noRing.
  var ringComb = combinations(store.rings, 2) as Iterable<List<_Item>>;
  var noRingComb = [
    [noRing, noRing]
  ];
  // We add such a "combination" here.
  var rings = concat([noRingComb, ringComb]) as Iterable<List<_Item>>;

  store.weapons.forEach((_Item weapon) {
    store.armor.forEach((_Item armor) {
      rings.forEach((List<_Item> ringList) {
        tryItems([weapon, armor, ringList[0], ringList[1]]);
      });
    });
  });

  _logger.info('Best items: $cheapestItems');
  return bestAmount;
}
