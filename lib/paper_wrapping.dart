library paper_wrapping;

int calculateWrapping(String dimensions) {
  var xyz = dimensions.split('x').map(int.parse).toList()..sort();
  int x = xyz[0];
  int y = xyz[1];
  int z = xyz[2];

  return 2 * (x * y + y * z + x * z) + x * y;
}

int calculateRibbon(String dimensions) {
  var xyz = dimensions.split('x').map(int.parse).toList()..sort();
  int x = xyz[0];
  int y = xyz[1];
  int z = xyz[2];

  return 2 * (x + y) + x * y * z;
}