import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/components/reusable_buttons.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/providers/game_provider.dart';
import 'package:hangman/screens/game/game_on_screen.dart';
import 'package:hangman/screens/main/widgets/hangman_logo.dart';
import 'package:hangman/screens/main/widgets/language_button.dart';
import 'package:hangman/screens/main/widgets/message_looper.dart';
import 'package:hangman/screens/player_input_word_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';

import '../../models/game.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      topButton: LanguageButton(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HangmanLogo(),
            Expanded(
              child: Image.asset('assets/images/mr. hangman.png'),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MessageLooper(),
              ),
            ),
            StartGameButton(
              title: LocaleKeys.startQuickGameButton.tr(),
              onTapped: () {
                ref.read(gameProvider.notifier).createGame(Game.quick(context));

                context.push(GameOnScreen());
              },
            ),
            StartGameButton(
              title: LocaleKeys.startTwoPlayerGameButton.tr(),
              onTapped: () => context.push(PlayerInputPhraseScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
