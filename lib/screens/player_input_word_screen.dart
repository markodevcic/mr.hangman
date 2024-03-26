import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/models/game.dart';
import 'package:hangman/providers/game_provider.dart';
import 'package:hangman/screens/game/game_on_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';

class PlayerInputPhraseScreen extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();
  final GamePlay gameHelper = GamePlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      topButton: BackToMainMenuButton(),
      child: Center(
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
                  if (value.isEmpty ||
                      value.contains(
                          RegExp(LocaleKeys.permittedCharacters.tr()))) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          LocaleKeys.alertPermittedMessageTitle,
                          style: GoogleFonts.pressStart2p(fontSize: 16),
                        ).tr(),
                        content: Text(
                          LocaleKeys.alertPermittedMessageContent,
                          style: GoogleFonts.pressStart2p(
                              fontSize: 16, height: 1.5),
                        ).tr(),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              controller.clear();
                              context.pop();
                            },
                            child: Text(
                              LocaleKeys.alertPermittedMessageButton,
                              style: GoogleFonts.pressStart2p(fontSize: 16),
                            ).tr(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ref.read(gameProvider.notifier).createGame(
                        Game.twoPlayer(context, value.toUpperCase()));

                    context.pushReplacement(GameOnScreen());
                  }
                },
                style: GoogleFonts.pressStart2p(),
                decoration: InputDecoration(
                  label: Text(
                    LocaleKeys.inputFieldMessage,
                    textAlign: TextAlign.center,
                  ).tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white54, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
