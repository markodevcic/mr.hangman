import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/game_helper.dart';

class Keyboard extends ConsumerWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.read(gameProvider)!;
    final watchGame = ref.watch(gameProvider)!;

    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          for (var row = 0; row < game.keyboard.length; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var char in game.keyboard[row])
                  Flexible(
                    child: MaterialButton(
                      child: Text(char,
                          style: GoogleFonts.pressStart2p(fontSize: 14)),
                      height: 55,
                      minWidth: 1,
                      onPressed: game.disabledKeyboardLetters.contains(char)
                          ? null
                          : () => GamePlay.checkGuess(ref, char),
                    ),
                  ),
              ],
            )
        ],
      ),
    );
  }
}
