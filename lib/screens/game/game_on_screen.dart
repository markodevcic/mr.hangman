import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/models/game.dart';
import 'package:hangman/providers/game_provider.dart';
import 'package:hangman/screens/game/widgets/keyboard.dart';
import 'package:hangman/screens/game/widgets/phrase.dart';
import 'package:hangman/screens/game/widgets/wrong_guesses_image.dart';
import 'package:hangman/screens/player_input_word_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';

class GameOnScreen extends ConsumerWidget {
  const GameOnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.read(gameProvider)!;
    final watchGame = ref.watch(gameProvider)!;

    return AppScaffold(
      topButton: BackToMainMenuButton(leaveGame: true),
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: WrongGuessesImage(),
            ),
            Phrase(),
            watchGame.status.when(
              playing: () => Keyboard(),
              over: () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameOverMessage(
                    message: game.status.when(
                      lost: () => LocaleKeys.finishedGameFailMessage,
                      won: () => LocaleKeys.finishedGameSuccessMessage,
                    ),
                  ),
                  game.type.when(
                    quick: AppButton(
                      title: LocaleKeys.startNewQuickGameButton,
                      onTap: () {
                        ref.invalidate(gameProvider);
                        ref
                            .read(gameProvider.notifier)
                            .createGame(Game.quick(context));

                        // context.pushReplacement(GameOnScreen());
                      },
                    ),
                    twoPlayer: AppButton(
                      title: LocaleKeys.startNEWTwoPlayerGameButton,
                      onTap: () => context.pushReplacement(
                        PlayerInputPhraseScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
