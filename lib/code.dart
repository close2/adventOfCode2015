library code;

import 'package:logging/logging.dart';

final Logger _logger = new Logger('code');

int rowCol2n(int row, int col) {
  //   row - 1
  // 1 + Σ n
  //     1
  var nAtStartOfRow = 1 + row * (row - 1) ~/ 2;

  // col + row
  //   Σ n
  // row + 1
  var offsetToColumn = (col + 2 * row) * (col - 1) ~/ 2;

  return nAtStartOfRow + offsetToColumn;
}

const int _firstCode = 20151125;
const int _multiplier = 252533;
const int _divider = 33554393;

int getCode(int row, int col) {
  var n = rowCol2n(row, col);

  var c = _firstCode;
  for (int i = 1; i < n; i++) {
    _logger.fine('Code $i = $c');
    c = (c * _multiplier) % _divider;
  }

  _logger.info('Code after n rounds: $c');
  return c;
}