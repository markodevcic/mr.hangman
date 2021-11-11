import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/helpers/game_helper.dart';
import 'package:hangman/screens/game_on_screen.dart';
import 'package:hangman/components/reusable_buttons.dart';
import 'package:hangman/screens/player_input_word_screen.dart';

class MainScreen extends StatelessWidget {
  final GameHelper gameHelper = GameHelper();
  final ShowExitAlert showExitAlert = ShowExitAlert();
  late String mainScreenMessage = gameHelper.generateMainScreenMessages();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        willLeave = await showExitAlert.showAlertDialog(context, 'Are you going to abandon Mr. Hangman?', willLeave,
            cancelButton: 'Never', okButton: 'Sorry');
        return willLeave;
      },
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: FittedBox(
              child: Hero(
                tag: 'splash_logo',
                // added Material to fix red letter when Hero is 'on fly'
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    'Mr. Hangman',
                    style: GoogleFonts.pressStart2p(fontSize: 28),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.asset('images/mr. hangman.png'),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 5), (_) {
                          return mainScreenMessage = gameHelper.generateMainScreenMessages();
                        }),
                        builder: (context, snapshot) {
                          return Text(
                            mainScreenMessage,
                            style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                            textAlign: TextAlign.center,
                          );
                        }),
                  ),
                ),
                StartGameButton(
                  buttonLabelFirstLine: 'QUICK',
                  buttonLabelSecondLine: 'GAME',
                  onTapped: () {
                    List phraseGenerated = gameHelper.phraseGenerator();
                    String phrase = phraseGenerated[0].toUpperCase();
                    String meaning = phraseGenerated[1];
                    String hiddenWord = gameHelper.hidePhrase(phrase);
                    String gameType = 'NEW QUICK';
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => GameOnScreen(
                            phrase: phrase, phraseMeaning: meaning, hiddenPhrase: hiddenWord, gameType: gameType)));
                  },
                ),
                StartGameButton(
                  buttonLabelFirstLine: '2 PLAYER',
                  buttonLabelSecondLine: 'GAME',
                  onTapped: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PlayerInputPhraseScreen()), (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
