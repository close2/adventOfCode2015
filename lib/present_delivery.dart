library present_delivery;


int findLowestHouseNumber(int presentCount,
    {int presentsPerElf: 10, int stopAfter: null}) {
  // found size through trial and error
  const size = 1000000;
  var presents = new List<int>.filled(size, presentsPerElf);

  // start with 2 (we already filled everything with presents from elf 1
  // during initialization
  for (var i = 2; i < size; i++) {
    var addThis = i * presentsPerElf;
    var stopCounter = (stopAfter != null) ? stopAfter : size;
    for (var j = i;
        j < size && stopCounter-- > 0;
        j += i) presents[j] += addThis;
  }

  var runner = 0;
  for (; runner < size && presents[runner] < presentCount; runner++);
  return runner;
}
