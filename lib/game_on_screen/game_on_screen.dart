import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/game_logic.dart';
import 'package:hangman/main_screen/main_screen.dart';
import 'package:hangman/main_screen/reusable_buttons.dart';
import 'package:hangman/player_input_word_screen/player_input_word_screen.dart';
import 'package:hangman/text_generator.dart';

class GameOnScreen extends StatefulWidget {
  final String word;
  String hiddenWord;
  final String gameType;

  GameOnScreen(
      {Key? key,
      required this.word,
      required this.hiddenWord,
      required this.gameType})
      : super(key: key);

  final GameLogic gameLogic = GameLogic();
  List<String> disabledLetters = [];
  int wrongGuesses = 0;
  final List<String> alphabet = TextGenerator().createAlphabet();
  final BackToMainMenuButton backToMainMenuButton = BackToMainMenuButton();

  @override
  _GameOnScreenState createState() => _GameOnScreenState();
}

class _GameOnScreenState extends State<GameOnScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Are you going to abandon Mr. Hangman?',
              style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.2),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    willLeave = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Sorry',
                      style: GoogleFonts.pressStart2p(fontSize: 16))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade600,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Never!',
                      style: GoogleFonts.pressStart2p(fontSize: 16)))
            ],
          ),
        );
        return willLeave;
      },
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                widget.backToMainMenuButton,
                Center(
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
                      Text(
                        widget.hiddenWord,
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                      ),
                      Container(
                        child: Column(
                          children: [
                            if (widget.wrongGuesses == 6)
                              GameEndMessage(
                                  message: 'You failed to save Mr. Hangman!'),
                            if (widget.wrongGuesses == 7)
                              GameEndMessage(
                                  message: 'You set Mr. Hangman free!'),
                            if (widget.wrongGuesses < 6)
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Wrap(
                                  spacing: 1,
                                  runSpacing: -10,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    for (var char in widget.alphabet)
                                      MaterialButton(
                                        child: Text(char,
                                            style: GoogleFonts.pressStart2p(
                                                fontSize: 14)),
                                        minWidth: 60,
                                        onPressed: (widget.disabledLetters
                                                .contains(char))
                                            ? null
                                            : () {
                                                (widget.word.contains(char))
                                                    ? setState(() {
                                                        widget.disabledLetters
                                                            .add(char);
                                                        widget.hiddenWord = widget
                                                            .gameLogic
                                                            .revealHiddenWord(
                                                                widget
                                                                    .hiddenWord,
                                                                widget.word,
                                                                char);
                                                        if (widget.hiddenWord ==
                                                            widget.word) {
                                                          widget.wrongGuesses =
                                                              7;
                                                        }
                                                      })
                                                    : setState(
                                                        () {
                                                          widget.disabledLetters
                                                              .add(char);
                                                          widget.wrongGuesses +=
                                                              1;
                                                        },
                                                      );
                                              },
                                      )
                                  ],
                                ),
                              ),
                            if (widget.wrongGuesses == 6 ||
                                widget.wrongGuesses == 7)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StartGameButton(
                                      buttonLabelFirstLine: widget.gameType,
                                      buttonLabelSecondLine: 'GAME',
                                      onTapped: (widget.gameType == 'NEW QUICK')
                                          ? () {
                                              String word = widget.gameLogic
                                                  .quickGameWordGenerator();
                                              String hiddenWord = widget
                                                  .gameLogic
                                                  .hideWord(word);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GameOnScreen(
                                                              word: word,
                                                              hiddenWord:
                                                                  hiddenWord,
                                                              gameType: widget
                                                                  .gameType)),
                                                  (route) => false);
                                            }
                                          : () => Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayerInputWordScreen()),
                                              (route) => false)),
                                  StartGameButton(
                                    buttonLabelFirstLine: 'MAIN',
                                    buttonLabelSecondLine: 'MENU',
                                    onTapped: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreen()),
                                          (route) => false);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
