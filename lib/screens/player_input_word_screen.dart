import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:hangman/helpers/game_helper.dart';
import 'package:hangman/screens/game_on_screen.dart';
import 'package:hangman/components/reusable_buttons.dart';

class PlayerInputPhraseScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final GameHelper gameHelper = GameHelper();

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                BackToMainMenuButton(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: const Image(
                          image: AssetImage('assets/images/mr. hangman questions.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          maxLength: 40,
                          onFieldSubmitted: (value) {
                            if (value.isEmpty || value.contains(RegExp(translate!.permittedCharacters))) {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text(
                                          translate!.alertPermittedMessageTitle,
                                          style: GoogleFonts.pressStart2p(fontSize: 16),
                                        ),
                                        content: Text(
                                          translate.alertPermittedMessageContent,
                                          style: GoogleFonts.pressStart2p(fontSize: 16, height: 1.5),
                                        ),
                                        actions: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                              onPressed: () {
                                                controller.clear();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(translate.alertPermittedMessageButton,
                                                  style: GoogleFonts.pressStart2p(fontSize: 16))),
                                        ],
                                      ));
                            } else {
                              TwoPlayerGame twoPlayerGameGenerate = TwoPlayerGame.generate(value.toUpperCase());
                              String phrase = twoPlayerGameGenerate.phrase;
                              String hiddenPhrase = twoPlayerGameGenerate.hiddenPhrase;
                              String gameType = twoPlayerGameGenerate.gameType;
                              String keyboardLanguage = translate.keyboardLanguage;

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GameOnScreen(
                                            phrase: phrase,
                                            hiddenPhrase: hiddenPhrase,
                                            gameType: gameType,
                                            keyboardLanguage: keyboardLanguage,
                                          )));
                            }
                          },
                          style: GoogleFonts.pressStart2p(),
                          decoration: InputDecoration(
                            label: Text(translate!.inputFieldMessage, textAlign: TextAlign.center),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white54, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
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
