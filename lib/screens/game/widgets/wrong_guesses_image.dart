import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/game_provider.dart';
import '../../../models/game.dart';

class WrongGuessesImage extends ConsumerWidget {
  const WrongGuessesImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider)!;

    return Container(
        child: Image.asset(
      game.status == GameStatus.playing
          ? 'assets/images/guessesLeft${game.guessesLeft}.png'
          : game.status == GameStatus.won
              ? 'assets/images/game_won.png'
              : 'assets/images/game_lost.png',
      gaplessPlayback: true,
    ));
  }
}
