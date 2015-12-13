library wire_logic;

int getInput(String v, Map<String, dynamic> states) {
  var isNumber = new RegExp(r'^\d+$').hasMatch(v);
  if (isNumber) return int.parse(v);
  var currentState = states[v];
  if (currentState is num) return currentState;
  var newState = _apply(v, currentState, states);
  states[v] = newState;
  return newState;
}

int _apply(String wire, String gate, Map<String, dynamic> states) {
  // a -> b
  Match m = new RegExp(r'^(\w+) -> \w+').firstMatch(gate);
  if (m != null) return getInput(m[1], states);

  // NOT x -> y
  m = new RegExp(r'^NOT (\w+) -> \w+').firstMatch(gate);
  if (m != null) return ~(getInput(m[1], states)) & 0xFFFF;

  m = new RegExp(r'(\w+) (AND|OR|LSHIFT|RSHIFT) (\w+) -> \w+').firstMatch(gate);
  int in1 = getInput(m[1], states);
  int in2 = getInput(m[3], states);
  switch (m[2]) {
    case 'AND':
      return in1 & in2;
    case 'OR':
      return in1 | in2;
    case 'LSHIFT':
      return in1 << in2 & 0xFFFF;
    case 'RSHIFT':
      return in1 >> in2;
  }

  throw new StateError('Unknown instruction: $gate');
}

int _buildStatesAndReadWire(String wire, List<String> connections,
    [String overrideWire, int overrideValue]) {
  Map<String, dynamic> states = new Map();
  connections
      .forEach((c) => states[new RegExp(r'.* -> (\w+)').firstMatch(c)[1]] = c);
  if (overrideWire != null) states[overrideWire] = overrideValue;
  return getInput(wire, states);
}

int readWire(String wire, List<String> connections) {
  return _buildStatesAndReadWire(wire, connections);
}

int readWireWithOverride(String wire, List<String> connections,
    String overrideWire, int overrideValue) {
  return _buildStatesAndReadWire(
      wire, connections, overrideWire, overrideValue);
}
