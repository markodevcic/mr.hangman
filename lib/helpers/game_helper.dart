List usedPhrases = [];
List phraseList = [
  ['Put a Sock In It', 'Asking someone to be quiet or to shut up'],
  ['All Greek To Me', 'When something is incomprehensible due to complexity'],
  ['A Day Late and a Dollar Short', 'Too late. A missed opportunity'],
  ['Keep Your Eyes Peeled', 'To be watchful, paying careful attention to something'],
  ['Barking Up The Wrong Tree', 'To make a wrong assumption about something'],
  ['Beating a Dead Horse', 'To bring up an issue that has already been resolved'],
  [
    'A Dog in the Manger',
    'Someone who prevents others from using valuable items even though they have no need for them'
  ],
  ['There is No I in Team', 'To not work alone, but rather, together with others in order to achieve a certain goal'],
  ['A Cut Below', 'Something that\'s inferior to the surrounding others'],
  ['Cry Over Spilt Milk', 'It\'s useless to worry about things that already happened and cannot be changed'],
  ['Love Birds', 'A pair of people who have a shared love for each other'],
  ['Hard Pill to Swallow', 'Something that\'s difficult to accept'],
  ['A Little Bird Told Me', 'Used when you don\'t wish to divulge where you got the information'],
  ['Birds of a Feather Flock Together', 'People tend to associate with others who share similar interests or values'],
  ['Needle In a Haystack', 'Something that is impossible or extremely difficult to find'],
  ['Cut The Mustard', 'To meet a required standard, or to meet expectations'],
  ['A Bite at the Cherry', 'An opportunity that\'s not available to most people'],
  ['You Can Not Judge a Book By Its Cover', 'Don\'t judge someone or something only by the outward appearance'],
  ['Wild Goose Chase', 'Futilely pursuing something that will never be attainable'],
  [
    'Quick and Dirty',
    'Things that are fixed with great speed, but as a result, it\'s probably not going to work very well'
  ],
  ['Right Off the Bat', 'Immediately, done in a hurry, without delay'],
  ['Close But No Cigar', 'Coming close to a successful outcome only to fall short at the end'],
  ['Cut To The Chase', 'To get to the point, leaving out all of the unnecessary details'],
  [
    'What Am I, Chopped Liver?',
    'A rhetorical question used by a person who feels they are being given less consideration than someone else'
  ],
  ['It Is Not Brain Surgery', 'A task that\'s easy to accomplish, a thing lacking complexity'],
  [
    'Elephant in the Room',
    'Ignoring a large, obvious problem or failing to address an issue that stands out in a major way'
  ],
  ['On the Same Page', 'Thinking alike or understanding something in a similar way with others'],
];

class GameHelper {
  String generateMainScreenMessages() {
    final List<String> mainScreenMessagesList = [
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
    ];
    mainScreenMessagesList.shuffle();
    String mainScreenMessage = mainScreenMessagesList[0];

    return mainScreenMessage;
  }

  List phraseGenerator() {
    phraseList.shuffle();

    List phraseToGuess = phraseList[0];

    usedPhrases.add(phraseList[0]);
    phraseList.removeAt(0);

    if (phraseList.isEmpty) {
      phraseList = List.from(usedPhrases);
      usedPhrases = [];
    }

    return phraseToGuess;
  }

  String hidePhrase(phraseToGuess) {
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

  String revealHiddenPhrase(hiddenPhrase, phrase, char) {
    String replaceCharAt(hiddenPhrase, i, char) {
      return hiddenPhrase.substring(0, i) + char + hiddenPhrase.substring(i + 1);
    }

    for (var i = 0; i < phrase.length; i++) {
      if (phrase[i] == char) {
        hiddenPhrase = replaceCharAt(hiddenPhrase, i, char);
      }
    }
    return hiddenPhrase;
  }

  List<String> createKeyboard() {
    List<String> keyboard = [
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
    return keyboard;
  }
}