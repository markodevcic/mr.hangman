import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/providers/game_provider.dart';

class WrongGuessesImage extends ConsumerWidget {
  const WrongGuessesImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider)!;

    return Container(
      child: Image.asset(
        game.status.when(
            won: () => 'assets/images/game_won.png',
            lost: () => 'assets/images/game_lost.png',
            playing: () => 'assets/images/guessesLeft${game.guessesLeft}.png'),
        gaplessPlayback: true,
      ),
    );
  }
}
