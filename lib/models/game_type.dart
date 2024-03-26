class GameType {
  final String value;
  const GameType._(this.value);

  factory GameType.quick() => GameType._('quick');
  factory GameType.twoPlayer() => GameType._('twoPlayer');

  R when<R>({
    R? quick,
    R? twoPlayer,
  }) {
    switch (value) {
      case 'quick':
        return quick!;
      case 'twoPlayer':
        return twoPlayer!;
      default:
        throw Exception('Unhandled method: $value');
    }
  }
}
