import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/models/game.dart';
import 'package:hangman/models/game_status.dart';

final gameProvider =
    StateNotifierProvider<GameProvider, Game?>((_) => GameProvider());

class GameProvider extends StateNotifier<Game?> {
  GameProvider() : super(null);

  void createGame(Game game) {
    state = game;
  }

  void setGameStatus(GameStatus status) {
    state = state!.copyWith(status: status);
  }

  void decreaseGuessesLeft() {
    state = state!.copyWith(guessesLeft: state!.guessesLeft - 1);
  }

  void setHiddenPhrase(String phrase) {
    state = state!.copyWith(hiddenPhrase: phrase);
  }

  void addDisabledKeyboardLetter(String char) {
    state = state!.copyWith(
      disabledKeyboardLetters: [...state!.disabledKeyboardLetters, char],
    );
  }
}

class GamePlay {
  static void checkGuess(WidgetRef ref, String char) {
    final game = ref.watch(gameProvider)!;
    final gameNotifier = ref.read(gameProvider.notifier);

    gameNotifier.addDisabledKeyboardLetter(char);

    if (game.phrase.contains(char)) {
      final hiddenPhrase =
          revealHiddenPhrase(game.hiddenPhrase, game.phrase, char);
      gameNotifier.setHiddenPhrase(hiddenPhrase);

      if (ref.read(gameProvider)!.hiddenPhrase == game.phrase) {
        gameNotifier.setGameStatus(GameStatus.won());
      }
    } else {
      gameNotifier.decreaseGuessesLeft();

      if (ref.read(gameProvider)!.guessesLeft < 0) {
        gameNotifier.setGameStatus(GameStatus.lost());
      }
    }
  }

  static String hidePhrase(phraseToGuess) {
    String hiddenPhraseToGuess = '';

    phraseToGuess.split('').forEach(
      (char) {
        if (char == ' ') {
          hiddenPhraseToGuess += ' ';
        } else if (char == '?') {
          hiddenPhraseToGuess += '?';
        } else if (char == '!') {
          hiddenPhraseToGuess += '!';
        } else if (char == ',') {
          hiddenPhraseToGuess += ',';
        } else if (char == '\'') {
          hiddenPhraseToGuess += '\'';
        } else {
          hiddenPhraseToGuess += '_';
        }
      },
    );
    return hiddenPhraseToGuess;
  }

  static String revealHiddenPhrase(hiddenPhrase, phrase, char) {
    String replaceCharAt(hiddenPhrase, i, char) {
      return hiddenPhrase.substring(0, i) +
          char +
          hiddenPhrase.substring(i + 1);
    }

    for (var i = 0; i < phrase.length; i++) {
      if (phrase[i] == char) {
        hiddenPhrase = replaceCharAt(hiddenPhrase, i, char);
      }
    }
    return hiddenPhrase;
  }
}
