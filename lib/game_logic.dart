class GameLogic {
  String quickGameWordGenerator() {
    List words = [
      'Put a Sock In It',
      'Not the Sharpest Tool in the Shed',
      'Birds of a Feather Flock Together',
      'Give a Man a Fish',
      'A Home Bird',
      'A Busy Bee',
      'Beating a Dead Horse',
      'My Cup of Tea',
      'Elvis Has Left The Building',
    ];

    words.shuffle();

    String wordToGuess = words[0].toUpperCase();

    return wordToGuess;
  }

  String hideWord(wordToGuess) {
    String hiddenWordToGuess = '';

    wordToGuess.split('').forEach(
      (char) {
        if (char == ' ') {
          hiddenWordToGuess += ' ';
        } else if (char != ' ') {
          hiddenWordToGuess += '_';
        }
      },
    );
    return hiddenWordToGuess;
  }

  String revealHiddenWord(hiddenWord, word, char) {
    String replaceCharAt(hiddenWord, i, char) {
      return hiddenWord.substring(0, i) + char + hiddenWord.substring(i + 1);
    }

    for (var i = 0; i < word.length; i++) {
      if (word[i].toUpperCase() == char.toUpperCase()) {
        hiddenWord = replaceCharAt(hiddenWord, i, char);
      }
    }
    return hiddenWord;
  }
}
