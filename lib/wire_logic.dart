library wire_logic;

typedef int _ReadWire(Map<String, Function> states);

class _Gate {
  String wire;
  _ReadWire f;

  _Gate(this.wire, this.f);
}

bool _isNumber(String v) {
  return new RegExp(r'^\d+$').hasMatch(v);
}

int _getInput(String v, Map<String, Function> states) {
  if (_isNumber(v)) return int.parse(v);
  return states[v](states);
}

_ReadWire _value(int v) {
  return (_) => v;
}

_ReadWire _cache(String wire, _ReadWire f) {
  return (Map<String, Function> states) {
    int val = f(states);
    states[wire] = _value(val);
    return val;
  };
}

_Gate _notGate(String wire, String input) {
  notF(Map<String, Function> states) {
    return ~(_getInput(input, states)) & 0xFFFF; // 16bit
  }
  return new _Gate(wire, _cache(wire, notF));
}

_Gate _andGate(String wire, String input1, String input2) {
  andF(Map<String, Function> states) {
    int inputVal1 = _getInput(input1, states);
    int inputVal2 = _getInput(input2, states);
    return inputVal1 & inputVal2;
  }
  return new _Gate(wire, _cache(wire, andF));
}

_Gate _orGate(String wire, String input1, String input2) {
  orF(Map<String, Function> states) {
    int inputVal1 = _getInput(input1, states);
    int inputVal2 = _getInput(input2, states);
    return inputVal1 | inputVal2;
  }
  return new _Gate(wire, _cache(wire, orF));
}


_Gate _rshiftGate(String wire, String input, int shift) {
  rshiftF(Map<String, Function> states) {
    int inputVal = _getInput(input, states);
    return inputVal >> shift;
  }
  return new _Gate(wire, _cache(wire, rshiftF));
}

_Gate _lshiftGate(String wire, String input, int shift) {
  lshiftF(Map<String, Function> states) {
    int inputVal = _getInput(input, states);
    return (inputVal << shift) & 0xFFFF; // 16bit integers
  }
  return new _Gate(wire, _cache(wire, lshiftF));
}

_Gate _redirectGate(String wire, String input) {
  redirectF(Map<String, Function> states) {
    return _getInput(input, states);
  }
  return new _Gate(wire, _cache(wire, redirectF));
}

_Gate _parseConnection(String connection) {
  // a -> b
  var patternRedirect = r'^(\w+) -> (\w+)';
  Match m = new RegExp(patternRedirect).firstMatch(connection);
  if (m != null) return _redirectGate(m[2], m[1]);

  // NOT x -> y
  var patternNot = r'^NOT (\w+) -> (\w+)';
  m = new RegExp(patternNot).firstMatch(connection);
  if (m != null) return _notGate(m[2], m[1]);

  var patternOther =
      r'(\w+) (AND|OR|LSHIFT|RSHIFT) (\w+) -> (\w+)';
  m = new RegExp(patternOther).firstMatch(connection);
  if (m != null) {
    switch (m[2]) {
      case 'AND':
        return _andGate(m[4], m[1], m[3]);
      case 'OR':
        return _orGate(m[4], m[1], m[3]);
      case 'LSHIFT':
        return _lshiftGate(m[4], m[1], int.parse(m[3]));
      case 'RSHIFT':
        return _rshiftGate(m[4], m[1], int.parse(m[3]));
    }
  }
  print("Shouldn't come here!");
}

int _buildStatesAndReadWire(String wire, List<String> connections, [String overrideWire, int overrideValue]) {
  Map<String, _ReadWire> states = new Map();
  connections.forEach((c) {
    var gate = _parseConnection(c);
    states[gate.wire] = gate.f;
  });
  if (overrideWire != null) states[overrideWire] = _value(overrideValue);
  return states[wire](states);
}

int readWire(String wire, List<String> connections) {
  return _buildStatesAndReadWire(wire, connections);
}

int readWireWithOverride(String wire, List<String> connections, String overrideWire, int overrideValue) {
  return _buildStatesAndReadWire(wire, connections, overrideWire, overrideValue);
}