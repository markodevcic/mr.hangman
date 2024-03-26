import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/models/game.dart';
import 'package:hangman/providers/game_provider.dart';
import 'package:hangman/screens/game/game_on_screen.dart';
import 'package:hangman/screens/main/widgets/hangman_logo.dart';
import 'package:hangman/screens/main/widgets/message_looper.dart';
import 'package:hangman/screens/main/widgets/top_scaffold_button.dart';
import 'package:hangman/screens/player_input_word_screen.dart';
import 'package:hangman/screens/settings/settings_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: HangmanLogo(),
      topButton: TopScaffoldButton.icon(
        icon: Icons.settings,
        onPressed: () => context.push(SettingsScreen()),
      ),
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
                child: MessageLooper(),
              ),
            ),
            AppButton(
              title: LocaleKeys.startQuickGameButton,
              onTap: () {
                ref.read(gameProvider.notifier).createGame(Game.quick(context));
                context.push(GameOnScreen());
              },
            ),
            AppButton(
              title: LocaleKeys.startTwoPlayerGameButton,
              onTap: () => context.push(PlayerInputPhraseScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
