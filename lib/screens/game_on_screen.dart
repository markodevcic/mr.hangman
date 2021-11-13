import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/helpers/game_helper.dart';
import 'package:hangman/screens/main_screen.dart';
import 'package:hangman/components/reusable_buttons.dart';
import 'package:hangman/screens/player_input_word_screen.dart';

class GameOnScreen extends StatefulWidget {
  final String phrase;
  String hiddenPhrase;
  final String gameType;
  late String phraseMeaning;

  GameOnScreen({
    required this.phrase,
    this.phraseMeaning = '',
    required this.hiddenPhrase,
    required this.gameType,
  });

  final GameHelper gameHelper = GameHelper();
  final QuickGame quickGameGenerate = QuickGame.generate();
  final ShowExitAlert showExitAlert = ShowExitAlert();
  final ShowPhraseMeaning showPhraseMeaning = ShowPhraseMeaning();
  late final List keyboard = gameHelper.createKeyboard();
  List<String> disabledKeyboardLetters = [];
  int wrongGuesses = 0;

  @override
  _GameOnScreenState createState() => _GameOnScreenState();
}

class _GameOnScreenState extends State<GameOnScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.phrase);
    print(widget.gameType);
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        willLeave = await widget.showExitAlert.showAlertDialog(context, 'Leaving Mr. Hangman on his own?', willLeave,
            cancelButton: 'No', okButton: 'Main menu');
        return willLeave;
      },
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Image.asset(
                        'images/hangman${widget.wrongGuesses}.png',
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  (widget.hiddenPhrase == widget.phrase && widget.phraseMeaning.isNotEmpty)
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.hiddenPhrase,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                              ),
                            ),
                            Align(
                              alignment: Alignment(1.05, 0.0),
                              child: IconButton(
                                icon: Icon(Icons.info_outline, size: 14, color: Colors.grey.shade400),
                                onPressed: () {
                                  widget.showPhraseMeaning.showAlertDialog(context, widget.phraseMeaning);
                                },
                              ),
                            ),
                          ],
                        )
                      : Text(
                          widget.hiddenPhrase,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                        ),
                  Container(
                    child: Column(
                      children: [
                        if (widget.wrongGuesses == 6) FinishedGameMessage(message: 'You failed to save Mr. Hangman!'),
                        if (widget.wrongGuesses == 7) FinishedGameMessage(message: 'You set Mr. Hangman free!'),
                        if (widget.wrongGuesses < 6)
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                for (var row = 0; row < widget.keyboard.length; row++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var char in widget.keyboard[row])
                                        Flexible(
                                          child: MaterialButton(
                                            child: Text(char, style: GoogleFonts.pressStart2p(fontSize: 14)),
                                            height: 55,
                                            minWidth: 1,
                                            onPressed: (widget.disabledKeyboardLetters.contains(char))
                                                ? null
                                                : () {
                                                    (widget.phrase.contains(char))
                                                        ? setState(() {
                                                            widget.disabledKeyboardLetters.add(char);
                                                            widget.hiddenPhrase = widget.gameHelper.revealHiddenPhrase(
                                                                widget.hiddenPhrase, widget.phrase, char);
                                                            if (widget.hiddenPhrase == widget.phrase) {
                                                              widget.wrongGuesses = 7;
                                                            }
                                                          })
                                                        : setState(
                                                            () {
                                                              widget.disabledKeyboardLetters.add(char);
                                                              widget.wrongGuesses += 1;
                                                            },
                                                          );
                                                  },
                                          ),
                                        ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        if (widget.wrongGuesses == 6 || widget.wrongGuesses == 7)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StartGameButton(
                                  buttonLabelFirstLine: widget.gameType,
                                  buttonLabelSecondLine: 'GAME',
                                  onTapped: (widget.gameType == 'NEW QUICK')
                                      ? () {
                                          // List phraseGenerated = widget.gameHelper.quickGameGenerator();
                                          // String phrase = phraseGenerated[0].toUpperCase();
                                          // String phraseMeaning = phraseGenerated[1];
                                          // String hiddenPhrase = widget.gameHelper.hidePhrase(phrase);
                                          String phrase = widget.quickGameGenerate.phrase;
                                          String phraseMeaning = widget.quickGameGenerate.phraseMeaning;
                                          String hiddenPhrase = widget.quickGameGenerate.hiddenPhrase;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => GameOnScreen(
                                                      phrase: phrase,
                                                      phraseMeaning: phraseMeaning,
                                                      hiddenPhrase: hiddenPhrase,
                                                      gameType: widget.gameType)));
                                        }
                                      : () => Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => PlayerInputPhraseScreen()))),
                              StartGameButton(
                                buttonLabelFirstLine: 'MAIN',
                                buttonLabelSecondLine: 'MENU',
                                onTapped: () {
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
