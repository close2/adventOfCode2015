library lights;

import 'dart:math';

/* first version
bool _applyInstruction(Point p, bool previous, _Instruction instruction) {
  if (instruction.area.containsPoint(p)) {
    switch (instruction.command) {
      case _Command.on:
        return true;
      case _Command.off:
        return false;
      case _Command.toggle:
        return !previous;
    }
  }
  return previous;
}
*/

int _applyInstruction(Point p, int previous, _Instruction instruction) {
  if (instruction.area.containsPoint(p)) {
    switch (instruction.command) {
      case _Command.on:
        return 1;
      case _Command.off:
        return 0;
      case _Command.toggle:
        return previous == 0 ? 1 : 0;
    }
  }
  return previous;
}

int _applyInstructionWithBrightness(Point p, int previous, _Instruction instruction) {
  if (instruction.area.containsPoint(p)) {
    switch (instruction.command) {
      case _Command.on:
        return previous + 1;
      case _Command.off:
        return previous == 0 ? 0 : previous - 1;
      case _Command.toggle:
        return previous + 2;
    }
  }
  return previous;
}

enum _Command { on, off, toggle }

const Map<String, _Command> _commands = const {
  'turn on': _Command.on,
  'turn off': _Command.off,
  'toggle': _Command.toggle
};

class _Instruction {
  final _Command command;
  final Rectangle<int> area;

  _Instruction.fromCoordinates(this.command, int x1, int y1, int x2, int y2)
      : area = new Rectangle.fromPoints(new Point(x1, y1), new Point(x2, y2));

  factory _Instruction.parseFromString(String stringInstruction) {
    var pattern = r'(' +
        _commands.keys.join('|') +
        r') (\d+),(\d+) through (\d+),(\d+)';
    var regExp = new RegExp(pattern);
    var parsed = regExp.allMatches(stringInstruction).first;

    return new _Instruction.fromCoordinates(
        _commands[parsed[1]],
        int.parse(parsed[2]),
        int.parse(parsed[3]),
        int.parse(parsed[4]),
        int.parse(parsed[5]));
  }
}

typedef int _F(Point p, int previous, _Instruction instruction);

int _calculate(List<String> stringInstructions, _F f) {
  var instructions = stringInstructions
      .map((_) => new _Instruction.parseFromString(_))
      .toList();

  int brightnessCounter = 0;
  for (int x = 0; x < 1000; x++) {
    for (int y = 0; y < 1000; y++) {
      var currentPoint = new Point(x, y);
      var brightness = instructions.fold(
          0,
          (int previous, _Instruction instruction) =>
          f(currentPoint, previous, instruction));
      brightnessCounter += brightness;
    }
  }
  return brightnessCounter;

}

int calculateTotalBrightness(List<String> stringInstructions) {
  return _calculate(stringInstructions, _applyInstructionWithBrightness);
}

int countLights(List<String> stringInstructions) {
  return _calculate(stringInstructions, _applyInstruction);
}
