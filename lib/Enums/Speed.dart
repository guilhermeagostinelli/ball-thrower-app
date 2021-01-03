enum Speed {
  LOW,
  MEDIUM,
  HIGH,
}

extension SpeedExt on Speed {
  String get valueOf {
    String v;
    switch (this) {
      case Speed.LOW:
        v = 'l';
        break;
      case Speed.MEDIUM:
        v = 'm';
        break;
      case Speed.HIGH:
        v = 'h';
        break;
    }
    // if (v == null) throw ArgumentError('$this is not a valid value');
    return v;
  }
}
