import 'package:flutter/material.dart';
import 'package:hangman/models/keyboard.dart';

import '../providers/game_provider.dart';
import 'phrase_lists.dart';

enum GameType { quick, twoPlayer }

enum GameStatus { won, lost, playing }

class Game {
  Game({
    required this.type,
    required this.status,
    required this.keyboard,
    required this.disabledKeyboardLetters,
    required this.guessesLeft,
    required this.phrase,
    required this.hiddenPhrase,
    this.phraseMeaning,
  });

  GameType type;
  GameStatus status;
  List<List<String>> keyboard;
  List<String> disabledKeyboardLetters;
  int guessesLeft;
  String phrase;
  String hiddenPhrase;
  String? phraseMeaning;

  factory Game.quick(BuildContext context) {
    phraseList.shuffle();

    List phraseToGuess = phraseList[0];

    String phrase = phraseToGuess[0].toUpperCase();
    String phraseMeaning = phraseToGuess[1];

    usedPhrases.add(phraseList[0]);
    phraseList.removeAt(0);

    if (phraseList.isEmpty) {
      phraseList = List.from(usedPhrases);
      usedPhrases = [];
    }

    String hiddenPhrase = GamePlay.hidePhrase(phrase);

    return Game(
      type: GameType.quick,
      status: GameStatus.playing,
      keyboard: Keyboard.create(context),
      disabledKeyboardLetters: [],
      guessesLeft: 5,
      phrase: phrase,
      phraseMeaning: phraseMeaning,
      hiddenPhrase: hiddenPhrase,
    );
  }

  factory Game.twoPlayer(BuildContext context, String phrase) {
    String hiddenPhrase = GamePlay.hidePhrase(phrase);

    return Game(
      type: GameType.twoPlayer,
      status: GameStatus.playing,
      keyboard: Keyboard.create(context),
      disabledKeyboardLetters: [],
      guessesLeft: 5,
      phrase: phrase,
      hiddenPhrase: hiddenPhrase,
    );
  }

  Game copyWith({
    GameType? type,
    GameStatus? status,
    List<List<String>>? keyboard,
    List<String>? disabledKeyboardLetters,
    int? guessesLeft,
    String? phrase,
    String? hiddenPhrase,
    String? phraseMeaning,
  }) {
    return Game(
      type: type ?? this.type,
      status: status ?? this.status,
      keyboard: keyboard ?? this.keyboard,
      disabledKeyboardLetters:
          disabledKeyboardLetters ?? this.disabledKeyboardLetters,
      guessesLeft: guessesLeft ?? this.guessesLeft,
      phrase: phrase ?? this.phrase,
      hiddenPhrase: hiddenPhrase ?? this.hiddenPhrase,
      phraseMeaning: phraseMeaning ?? this.phraseMeaning,
    );
  }
}
