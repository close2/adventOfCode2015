library floor_calculation;

int findFloor(String instructions) {
  int ups = '('.allMatches(instructions).length;
  // yes I know we parse instructions twice
  int downs = ')'.allMatches(instructions).length;

  return ups - downs;
}

int posEnteringBasement(String instructions) {
  int floor = 0;
  for (int i = 0; i < instructions.length; i++) {
    var instruction = instructions[i];
    if (instruction == '(') floor++;
    else floor--;
    if (floor == -1) return i + 1;
  }
}
