library wizard;

import 'dart:math' as math;
import 'package:more/iterable.dart';
import 'package:logging/logging.dart';

final Logger _logger = new Logger('wizard');

const _initHitpoints = 50;
const _initMana = 500;

int mana(int bossHitpoints, int bossDamage, {bool levelHard: false}) {
  int leastManaSpent = null;
  List<String> bestSpells = null;

  void playRound(int bossHitpoints,
      [int manaSpent = 0,
      int hitPoints = _initHitpoints,
      int mana = _initMana,
      int armor,
      int spellShield = 0,
      int spellPoison = 0,
      int spellRecharge = 0,
      bool playerRound = true,
      Iterable<String> spellsCast = const <String>[]]) {
    // Apply all round based spells:
    if (spellShield > 0) {
      armor += 7;
      spellShield--;
    }
    if (spellPoison > 0) {
      bossHitpoints -= 3;
      spellPoison--;
    }
    if (spellRecharge > 0) {
      mana += 101;
      spellRecharge--;
    }

    // Boss attacks player.
    if (!playerRound) {
      if (bossHitpoints <= 0) {
        // We just killed the boss.
        if (leastManaSpent == null || manaSpent < leastManaSpent) {
          leastManaSpent = manaSpent;
          bestSpells = spellsCast.toList(growable: false);
        }
        return;
      } else if (leastManaSpent != null && manaSpent > leastManaSpent) return;

      // Boss is hitting us:
      hitPoints -= math.max(1, bossDamage - armor);
      if (hitPoints > 0) {
        playRound(bossHitpoints, manaSpent, hitPoints, mana, armor, spellShield,
            spellPoison, spellRecharge, true, spellsCast);
      }
      return;
    }

    if (levelHard) hitPoints--;

    // Player attacks boss.
    armor = 0;

    // Did we die?
    if (hitPoints < 0 || mana <= 0) return;

    // Now try different spells:
    if (spellShield == 0 && mana >= 113) {
      playRound(
          bossHitpoints,
          manaSpent + 113,
          hitPoints,
          mana - 113,
          armor,
          spellShield + 6,
          spellPoison,
          spellRecharge,
          false,
          concat([
            spellsCast,
            ['Shield']
          ]) as Iterable<String>);
    }
    if (spellPoison == 0 && mana >= 173) {
      playRound(
          bossHitpoints,
          manaSpent + 173,
          hitPoints,
          mana - 173,
          armor,
          spellShield,
          spellPoison + 6,
          spellRecharge,
          false,
          concat([
            spellsCast,
            ['Poison']
          ]) as Iterable<String>);
    }
    if (spellRecharge == 0 && mana >= 229) {
      playRound(
          bossHitpoints,
          manaSpent + 229,
          hitPoints,
          mana - 229,
          armor,
          spellShield,
          spellPoison,
          spellRecharge + 5,
          false,
          concat([
            spellsCast,
            ['Recharge']
          ]) as Iterable<String>);
    }
    // Missile spell:
    if (mana >= 53) {
      playRound(
          bossHitpoints - 4,
          manaSpent + 53,
          hitPoints,
          mana - 53,
          armor,
          spellShield,
          spellPoison,
          spellRecharge,
          false,
          concat([
            spellsCast,
            ['Missile']
          ]) as Iterable<String>);
    }
    // Drain spell:
    if (mana >= 73) {
      playRound(
          bossHitpoints - 2,
          manaSpent + 73,
          hitPoints + 2,
          mana - 73,
          armor,
          spellShield,
          spellPoison,
          spellRecharge,
          false,
          concat([
            spellsCast,
            ['Drain']
          ]) as Iterable<String>);
    }
  }

  playRound(bossHitpoints);

  _logger.info('Best spells ${levelHard ? '(hard)' : ''}: ${bestSpells}');
  return leastManaSpent;
}
