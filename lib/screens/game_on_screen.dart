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

  GameOnScreen(
      {Key? key, required this.phrase, this.phraseMeaning = '', required this.hiddenPhrase, required this.gameType})
      : super(key: key);

  final GameHelper gameHelper = GameHelper();
  final BackToMainMenuButton backToMainMenuButton = BackToMainMenuButton();
  final ShowPhraseMeaning showPhraseMeaning = ShowPhraseMeaning();
  late final List<String> keyboard = gameHelper.createKeyboard();
  List<String> disabledKeyboardLetters = [];
  int wrongGuesses = 0;

  @override
  _GameOnScreenState createState() => _GameOnScreenState();
}

class _GameOnScreenState extends State<GameOnScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                            padding: EdgeInsets.only(top: 10),
                            child: Wrap(
                              spacing: 1,
                              runSpacing: -10,
                              alignment: WrapAlignment.center,
                              children: [
                                for (var char in widget.keyboard)
                                  MaterialButton(
                                    child: Text(char, style: GoogleFonts.pressStart2p(fontSize: 14)),
                                    minWidth: 60,
                                    onPressed: (widget.disabledKeyboardLetters.contains(char))
                                        ? null
                                        : () {
                                            (widget.phrase.contains(char))
                                                ? setState(() {
                                                    widget.disabledKeyboardLetters.add(char);
                                                    widget.hiddenPhrase = widget.gameHelper
                                                        .revealHiddenPhrase(widget.hiddenPhrase, widget.phrase, char);
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
                                          List phraseGenerated = widget.gameHelper.phraseGenerator();
                                          String phrase = phraseGenerated[0].toUpperCase();
                                          String phraseMeaning = phraseGenerated[1];
                                          String hiddenPhrase = widget.gameHelper.hidePhrase(phrase);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => GameOnScreen(
                                                      phrase: phrase,
                                                      phraseMeaning: phraseMeaning,
                                                      hiddenPhrase: hiddenPhrase,
                                                      gameType: widget.gameType)),
                                              (route) => false);
                                        }
                                      : () => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => PlayerInputPhraseScreen()),
                                          (route) => false)),
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
