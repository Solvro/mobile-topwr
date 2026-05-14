import "dart:typed_data";

export "src/constants.dart" show kSecretSizeMin, kXXH3SmallDataSize, kXXH3StreamBufferSize;

typedef HashLongFunction = int Function(ByteData input, int seed, ByteData secret);

const HashLongFunction kXXH3HashLongFunction64Bit = _unsupportedHashLongFunction;

int xxh3(
  Uint8List input, {
  Uint8List? secret,
  int seed = 0,
  HashLongFunction hashLongFunction = kXXH3HashLongFunction64Bit,
}) {
  throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
}

String xxh3String(
  Uint8List input, {
  Uint8List? secret,
  int seed = 0,
  HashLongFunction hashLongFunction = kXXH3HashLongFunction64Bit,
}) {
  throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
}

XXH3State xxh3Stream({Uint8List? secret, int? seed}) {
  throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
}

int _unsupportedHashLongFunction(ByteData input, int seed, ByteData secret) {
  throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
}

class XXH3State {
  XXH3State.create();

  void update(Uint8List input) {
    throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
  }

  int digest() {
    throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
  }

  String digestString() {
    throw UnsupportedError("xxh3 is stubbed for web CI builds only.");
  }
}
