library wire_logic;

int _getInput(String v, Map<String, dynamic> states) {
  var isNumber = new RegExp(r'^\d+$').hasMatch(v);
  if (isNumber) return int.parse(v);

  var currentState = states[v];
  if (currentState is num) return currentState;

  var newState = _apply(currentState as List<String>, states);
  states[v] = newState;
  return newState;
}

int _apply(List<String> gate, Map<String, dynamic> states) {
  getInput(String wire) => _getInput(wire, states);

  // a -> b
  if (gate.length == 3) return getInput(gate[0]);

  // NOT x -> y
  if (gate.length == 4) return ~(getInput(gate[1])) & 0xFFFF;

  // x AND y -> z
  int in1 = getInput(gate[0]);
  int in2 = getInput(gate[2]);
  switch (gate[1]) {
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
  connections.forEach((c) {
    var s = c.split(' ');
    states[s.last] = s;
  });
  if (overrideWire != null) states[overrideWire] = overrideValue;
  return _getInput(wire, states);
}

int readWire(String wire, List<String> connections) {
  return _buildStatesAndReadWire(wire, connections);
}

int readWireWithOverride(String wire, List<String> connections,
    String overrideWire, int overrideValue) {
  return _buildStatesAndReadWire(
      wire, connections, overrideWire, overrideValue);
}
