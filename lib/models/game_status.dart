enum CurrentGameStatus { won, lost, playing }

class GameStatus {
  final CurrentGameStatus status;

  const GameStatus._(this.status);

  factory GameStatus.won() => GameStatus._(CurrentGameStatus.won);
  factory GameStatus.lost() => GameStatus._(CurrentGameStatus.lost);
  factory GameStatus.playing() => GameStatus._(CurrentGameStatus.playing);

  CurrentGameStatus get current {
    switch (status) {
      case CurrentGameStatus.won:
        return CurrentGameStatus.won;
      case CurrentGameStatus.lost:
        return CurrentGameStatus.lost;
      case CurrentGameStatus.playing:
        return CurrentGameStatus.playing;
      default:
        throw Exception('Unhandled method: $status');
    }
  }

  R when<R>({
    R Function()? won,
    R Function()? lost,
    R Function()? playing,
    R Function()? over,
  }) {
    switch (status) {
      case CurrentGameStatus.won:
        return won != null ? won() : over!();
      case CurrentGameStatus.lost:
        return lost != null ? lost() : over!();
      case CurrentGameStatus.playing:
        return playing!();
      default:
        return over!();
    }
  }

  GameStatus copyWith(CurrentGameStatus newStatus) {
    if (this.status == newStatus) {
      return this;
    }
    return GameStatus._(newStatus);
  }
}
