library wizard;

import 'dart:math' as math;
import 'package:more/iterable.dart';
import 'package:logging/logging.dart';

final Logger _logger = new Logger('wizard');

const _initHitpoints = 50;
const _initMana = 500;

class GameState {
  int bossHitpoints;
  int hitpoints = _initHitpoints;
  int mana = _initMana;
  int armor = 0;
  int spellShield = 0;
  int spellPoison = 0;
  int spellRecharge = 0;

  GameState(this.bossHitpoints);

  factory GameState.from(GameState gameState) {
    var res = new GameState(gameState.bossHitpoints);
    res.bossHitpoints = gameState.bossHitpoints;
    res.hitpoints = gameState.hitpoints;
    res.mana = gameState.mana;
    res.armor = gameState.armor;
    res.spellShield = gameState.spellShield;
    res.spellPoison = gameState.spellPoison;
    res.spellRecharge = gameState.spellRecharge;
    return res;
  }
}

int mana(int bossHitpoints, int bossDamage, {bool levelHard: false}) {
  int leastManaSpent = null;
  List<String> bestSpells = null;

  void playRound(GameState state, int manaSpent, bool playerRound, Iterable<String> spellsCast) {

    if (leastManaSpent != null && manaSpent > leastManaSpent) return;

    // Apply all round based spells:
    if (state.spellShield-- > 0) state.armor += 7;
    if (state.spellPoison-- > 0) state.bossHitpoints -= 3;
    if (state.spellRecharge-- > 0) state.mana += 101;

    // Boss attacks player.
    if (!playerRound) {
      if (state.bossHitpoints <= 0) {
        // We just killed the boss.
        if (leastManaSpent == null || manaSpent < leastManaSpent) {
          leastManaSpent = manaSpent;
          bestSpells = spellsCast.toList(growable: false);
        }
      } else {
        // Boss is hitting us:
        state.hitpoints -= math.max(1, bossDamage - state.armor);
        playRound(state, manaSpent, true, spellsCast);
      }
      return;
    }

    if (levelHard) state.hitpoints--;

    // Player attacks boss.
    state.armor = 0;

    // Have we died?
    if (state.hitpoints <= 0 || state.mana <= 0) return;

    Iterable<String> addSpell(String newSpell) {
      return concat([
        spellsCast,
        [newSpell]
      ]) as Iterable<String>;
    }

    // Now try different spells.  We create a temporary new state for every
    // spell we try and only modify this state.  This means that every spell
    // starts with the same state.
    const int shieldCost = 113;
    if (state.spellShield <= 0 && state.mana >= shieldCost) {
      var newState = new GameState.from(state);
      newState.mana -= shieldCost;
      newState.spellShield = 6;
      playRound(newState, manaSpent + shieldCost, false, addSpell('Shield'));
    }
    const int poisonCost = 173;
    if (state.spellPoison <= 0 && state.mana >= poisonCost) {
      var newState = new GameState.from(state);
      newState.mana -= poisonCost;
      newState.spellPoison = 6;
      playRound(newState, manaSpent + poisonCost, false, addSpell('Poison'));
    }
    const int rechargeCost = 229;
    if (state.spellRecharge <= 0 && state.mana >= rechargeCost) {
      var newState = new GameState.from(state);
      newState.mana -= rechargeCost;
      newState.spellRecharge = 5;
      playRound(newState, manaSpent + rechargeCost, false, addSpell('Recharge'));
    }
    // Missile spell:
    const int missileCost = 53;
    if (state.mana >= missileCost) {
      var newState = new GameState.from(state);
      newState.mana -= missileCost;
      newState.bossHitpoints -= 4;
      playRound(newState, manaSpent + missileCost, false, addSpell('Missile'));
    }
    // Drain spell:
    const int drainCost = 73;
    if (state.mana >= drainCost) {
      var newState = new GameState.from(state);
      newState.mana -= drainCost;
      newState.hitpoints += 2;
      newState.bossHitpoints -= 2;
      playRound(newState, manaSpent + drainCost, false, addSpell('Drain'));
    }
  }

  playRound(new GameState(bossHitpoints), 0, true, []);

  _logger.info('Best spells ${levelHard ? '(hard)' : ''}: ${bestSpells}');
  return leastManaSpent;
}
