library turing;

import 'package:logging/logging.dart';

final Logger _logger = new Logger('turing');

enum Reg { a, b }

class State {
  Map<Reg, int> regs = {};
  int pc = 0;

  State() {
    for (var reg in Reg.values) regs[reg] = 0;
  }

  @override
  String toString() => 'pc: $pc; regs: $regs';
}

abstract class _Instruction {
  void execute(State state);
}

void _log(State state, _Instruction instr) {
  _logger.fine('State: $state;      Instruction: $instr');
}

class Hlf extends _Instruction {
  final Reg reg;
  Hlf(this.reg);

  @override
  void execute(State state) {
    _log(state, this);
    state.regs[reg] = (state.regs[reg] / 2).floor();
    state.pc++;
  }

  @override
  String toString() => 'hlf $reg';
}

class Tpl extends _Instruction {
  final Reg reg;
  Tpl(this.reg);

  @override
  void execute(State state) {
    _log(state, this);
    state.regs[reg] = (state.regs[reg] * 3).floor();
    state.pc++;
  }

  @override
  String toString() => 'tpl $reg';
}

class Inc extends _Instruction {
  final Reg reg;
  Inc(this.reg);

  @override
  void execute(State state) {
    _log(state, this);
    state.regs[reg] += 1;
    state.pc++;
  }

  @override
  String toString() => 'inc $reg';
}

class Jmp extends _Instruction {
  final int offset;
  Jmp(this.offset);

  @override
  void execute(State state) {
    _log(state, this);
    state.pc += offset;
  }

  @override
  String toString() => 'jmp $offset';
}

class Jie extends _Instruction {
  final Reg reg;
  final int offset;

  Jie(this.reg, this.offset);

  @override
  void execute(State state) {
    _log(state, this);
    if (state.regs[reg] % 2 == 0) state.pc += offset;
    else state.pc++;
  }

  @override
  String toString() => 'jie $reg, $offset';
}

// Jump if ONE!
class Jio extends _Instruction {
  final Reg reg;
  final int offset;

  Jio(this.reg, this.offset);

  @override
  void execute(State state) {
    _log(state, this);
    if (state.regs[reg] == 1) state.pc += offset;
    else state.pc++;
  }

  @override
  String toString() => 'jio $reg, $offset';
}

List<_Instruction> _convert(List<String> stringInstructions) {
  Reg l2r(String l) => l == 'a' ? Reg.a : Reg.b;

  var res = stringInstructions.map((String sIns) {
    // Example commands:
    // jio a, +8
    // jmp +22
    // tpl a
    List<String> split = sIns.split(new RegExp(',* '));
    switch (split[0]) {
      case 'hlf':
        return new Hlf(l2r(split[1]));
      case 'tpl':
        return new Tpl(l2r(split[1]));
      case 'inc':
        return new Inc(l2r(split[1]));
      case 'jmp':
        return new Jmp(int.parse(split[1]));
      case 'jie':
        return new Jie(l2r(split[1]), int.parse(split[2]));
      case 'jio':
        return new Jio(l2r(split[1]), int.parse(split[2]));
      default:
        throw new Exception('Unknown command: ${split[0]}');
    }
  });
  return res.toList(growable: false) as List<_Instruction>;
}

State getState(List<String> stringInstructions, [State state]) {
  var instructions = _convert(stringInstructions);

  state ??= new State();
  while (state.pc >= 0 && state.pc < instructions.length) {
    instructions[state.pc].execute(state);
  }

  return state;
}


/// A compact version of the above:
int getB(List<String> stringInstructions, {int a: 0}) {
  int pc = 0;
  var regs = <String, int>{'a': a, 'b': 0};

  while (pc >= 0 && pc < stringInstructions.length) {
    var instr = stringInstructions[pc].split(new RegExp(',* '));
    var arg1 = instr[1]; // either reg name or offset for jmp
    var offset = (instr.length > 2) ? int.parse(instr[2]) : 0;
    switch (instr[0]) {
      case 'hlf':
        regs[arg1] = (regs[arg1] / 2).floor();
        break;
      case 'tpl':
        regs[arg1] *= 3;
        break;
      case 'inc':
        regs[arg1]++;
        break;
      case 'jmp':
      // We reduce the offset for jumps because the pc is incremented for all
      // instructions.
        pc += int.parse(instr[1]) - 1;
        break;
      case 'jie':
        if (regs[arg1] % 2 == 0) pc += offset - 1;
        break;
      case 'jio':
        if (regs[arg1] == 1) pc += offset - 1;
        break;
      default:
        throw new Exception('Unknown command: ${instr[0]}');
    }
    pc++;
  }
  return regs['b'];
}
