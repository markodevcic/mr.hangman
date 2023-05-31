String generateMainScreenMessages(language) {
  final Map mainScreenMessagesList = {
    'en': [
      'Save Mr. Hangman from the evil hands!',
      'Mr. Hangman is counting on you!',
      'Don\'t let bad guys harm Mr. Hangman!',
      'You can deliver Mr. Hangman from this!',
      'There\'s no much time left to save him!',
      'You\'re Mr. Hangman\'s superhero!',
      'Mr. Hangman is in great trouble, help him!',
      'Help him so you gain life\'s deepest wisdom!',
      'Tap into Mr. Hangman\'s well of wisdom!',
      'You\'ll become a wise person with Mr. Hangman!',
      'Pour his knowledge into your life\'s well!'
    ],
    'hr': [
      'Spasi Mr. Hangmana od zlih ljudi!',
      'Mr. Hangman računa na tebe!',
      'Ne dopusti da loši ljudi naude Mr. Hangmanu!',
      'Ti možeš osloboditi Mr. Hangmana od ovog!',
      'Nema puno vremena da ga se spasi!',
      'Ti si Mr. Hangmanov superjunak!',
      'Mr. Hangman je u velikoj nevolji, spasi ga!',
      'Pomogni mu i otkrit ćeš duboke mudrosti!',
      'Zaroni u Mr. Hangmanov izvor mudrosti!',
      'Postat ćeš mudra osoba uz Mr. Hangmana!',
      'Ulij njegovo znanje u bunar svog života!'
    ]
  };

  mainScreenMessagesList[language].shuffle();

  final String mainScreenMessage = mainScreenMessagesList[language][0];

  return mainScreenMessage;
}
