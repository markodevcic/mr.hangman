import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/components/reusable_buttons.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/providers/game_provider.dart';
import 'package:hangman/screens/game/widgets/keyboard.dart';
import 'package:hangman/screens/game/widgets/phrase.dart';
import 'package:hangman/screens/game/widgets/wrong_guesses_image.dart';
import 'package:hangman/screens/player_input_word_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';

import '../../models/game.dart';

class GameOnScreen extends ConsumerStatefulWidget {
  GameOnScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GameOnScreen> createState() => _GameOnScreenState();
}

class _GameOnScreenState extends ConsumerState<GameOnScreen> {
  @override
  Widget build(BuildContext context) {
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
            Phrase(game: game),
            watchGame.status == GameStatus.playing
                ? Keyboard()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FinishedGameMessage(
                          message: game.status == GameStatus.lost
                              ? LocaleKeys.finishedGameFailMessage
                              : LocaleKeys.finishedGameSuccessMessage),
                      StartGameButton(
                        title: game.type == GameType.quick
                            ? LocaleKeys.startNewQuickGameButton.tr()
                            : LocaleKeys.startNEWTwoPlayerGameButton.tr(),
                        onTapped: game.type == GameType.quick
                            ? () {
                                ref
                                    .read(gameProvider.notifier)
                                    .createGame(Game.quick(context));

                                context.pushReplacement(GameOnScreen());
                              }
                            : () => context.pushReplacement(
                                  PlayerInputPhraseScreen(),
                                ),
                      ),
                      StartGameButton(
                        title: LocaleKeys.mainMenuButtonFirstLine.tr(),
                        onTapped: () => context.pop(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
