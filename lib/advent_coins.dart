library advent_coins;

import 'package:crypto/crypto.dart' as crypto;

int findLowestNumber(String secretKey, {String prefix: '00000'}) {
  for (int i = 0; true; i++) {
    var md5 = new crypto.MD5();
    md5.add('$secretKey$i'.codeUnits);
    var hex = crypto.CryptoUtils.bytesToHex(md5.close());
    if (hex.startsWith(prefix)) return i;
  }
}