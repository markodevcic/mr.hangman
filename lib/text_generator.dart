class TextGenerator {
  String saveMrHangman() {
    final List<String> saveMrHangmanList = [
      'Save Mr. Hangman from the evil hands!',
      'Mr. Hangman is counting on you!',
      'Don\'t let bad guys harm Mr. Hangman!',
      'Hurry up, Mr. Hangman\'s time\'s up!',
      'You can deliver Mr. Hangman from this!',
      'There\'s no much time left to save him!',
      'You\'re Mr. Hangman\'s superhero!',
      'Mr. Hangman is in great trouble!',
    ];
    saveMrHangmanList.shuffle();
    String saveMrHangman = saveMrHangmanList[0];

    return saveMrHangman;
  }

  List<String> createAlphabet() {
    List<String> alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];
    return alphabet;
  }
}
