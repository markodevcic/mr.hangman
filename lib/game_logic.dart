List usedPhrases = [];
List phrases = [
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

class GameLogic {
  List quickGameWordGenerator() {
    phrases.shuffle();

    List phraseToGuess = phrases[0];

    usedPhrases.add(phrases[0]);
    phrases.removeAt(0);

    if (phrases.isEmpty) {
      phrases = List.from(usedPhrases);
      usedPhrases = [];
    }

    print('Phrases: ${phrases.length}');
    print('UsedPhrases: ${usedPhrases.length}');

    return phraseToGuess;
  }

  String hideWord(wordToGuess) {
    String hiddenWordToGuess = '';

    wordToGuess.split('').forEach(
      (char) {
        if (char == ' ') {
          hiddenWordToGuess += ' ';
        } else if (char == '?') {
          hiddenWordToGuess += '?';
        } else if (char == ',') {
          hiddenWordToGuess += ',';
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
