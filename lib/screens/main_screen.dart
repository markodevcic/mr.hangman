import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/components/reusable_buttons.dart';
import 'package:hangman/helpers/game_helper.dart';
import 'package:hangman/screens/game_on_screen.dart';
import 'package:hangman/screens/player_input_word_screen.dart';

class MainScreen extends StatelessWidget {
  final GameHelper gameHelper = GameHelper();
  final ShowExitAlert showExitAlert = ShowExitAlert();
  late String chooseLanguage = 'ENG';
  late String mainScreenMessage = '';
  bool isVisible = true;
  int isNotVisibleTime = 600;

  late Function() changeLanguage;

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        willLeave = await showExitAlert.showAlertDialog(
            context, translate!.exitGameContentMessage, willLeave,
            cancelButton: translate.exitGameCancelButton,
            okButton: translate.exitGameOkButton);
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
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Image.asset('assets/images/mr. hangman.png'),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: StatefulBuilder(builder: (context, setState) {
                        return StreamBuilder(
                            stream: Stream.periodic(
                                Duration(milliseconds: isNotVisibleTime), (_) {
                              if (isVisible == false) {
                                setState(() => isNotVisibleTime = 5000);
                                mainScreenMessage =
                                    gameHelper.generateMainScreenMessages(
                                        translate!.keyboardLanguage);
                              } else {
                                setState(() => isNotVisibleTime = 300);
                              }
                              return isVisible = !isVisible;
                            }),
                            builder: (context, snapshot) {
                              return Container(
                                height: 100,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AnimatedOpacity(
                                  opacity: isVisible ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 200),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      mainScreenMessage,
                                      style: GoogleFonts.pressStart2p(
                                          fontSize: 18, height: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                  StartGameButton(
                    buttonLabelFirstLine:
                        translate!.startQuickGameButtonFirstLine,
                    buttonLabelSecondLine:
                        translate.startAnyGameButtonSecondLine,
                    onTapped: () {
                      final QuickGame quickGameGenerate = QuickGame.generate();
                      String phrase = quickGameGenerate.phrase;
                      String phraseMeaning = quickGameGenerate.phraseMeaning;
                      String hiddenPhrase = quickGameGenerate.hiddenPhrase;
                      String gameType = quickGameGenerate.gameType;
                      String keyboardLanguage = translate.keyboardLanguage;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GameOnScreen(
                              phrase: phrase,
                              phraseMeaning: phraseMeaning,
                              hiddenPhrase: hiddenPhrase,
                              gameType: gameType,
                              keyboardLanguage: keyboardLanguage)));
                    },
                  ),
                  StartGameButton(
                    buttonLabelFirstLine:
                        translate.startTwoPlayerGameButtonFirstLine,
                    buttonLabelSecondLine:
                        translate.startAnyGameButtonSecondLine,
                    onTapped: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayerInputPhraseScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
