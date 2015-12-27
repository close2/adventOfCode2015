library lights2;

// assume square
int _get(List<List<int>> states, int x, int y) {
  var size = states.length;
  if (x < 0 || y < 0 || x >= size || y >= size) return 0;
  return states[x][y];
}

int _calcNewState(List<List<int>> states, int x, int y) {
  var count = 0;
  var current = _get(states, x, y);
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y - 1; j <= y + 1; j++) {
      if (i == x && j == y) continue;
      count += _get(states, i, j);
    }
  }

  if (count == 3) return 1;
  if (current == 1 && count == 2) return 1;
  return 0;
}

void _turnCornersOn(List<List<int>> state) {
  var size = state.length;
  state[0][0] = 1;
  state[size - 1][0] = 1;
  state[0][size - 1] = 1;
  state[size - 1][size - 1] = 1;
}

List<List<int>> _step(List<List<int>> currentState, bool cornerAlwaysOn) {
  // assume square
  var size = currentState.length;
  List<List<int>> newState = new List.generate(size, (int _) => new List(size));

  for (int x = 0; x < size; x++) {
    for (int y = 0; y < size; y++) {
      newState[x][y] = _calcNewState(currentState, x, y);
    }
  }

  if (cornerAlwaysOn) _turnCornersOn(newState);
  return newState;
}

List<List<int>> _convertFromStr(List<String> lightsAsStr) {
  const String off = '.';

  // assume square
  var size = lightsAsStr.length;

  List<List<int>> lights = new List.generate(size, (int _) => new List(size));
  for (int x = 0; x < size; x++) {
    for (int y = 0; y < size; y++) {
      lights[x][y] = lightsAsStr[x][y] == off ? 0 : 1;
    }
  }

  return lights;
}

int countLightsOn(List<String> lightsAsStr,
    {int iterations: 100, bool cornerAlwaysOn: false}) {
  var lights = _convertFromStr(lightsAsStr);
  if (cornerAlwaysOn) _turnCornersOn(lights);

  for (int i = 0; i < iterations; i++) lights = _step(lights, cornerAlwaysOn);

  return lights
      .expand((List<int> l) => l)
      .fold(0, (int prev, int i) => prev + i);
}
