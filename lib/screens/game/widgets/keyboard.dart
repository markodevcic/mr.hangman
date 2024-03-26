import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/providers/game_provider.dart';

class Keyboard extends ConsumerWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.read(gameProvider)!;

    return Padding(
      padding: EdgeInsets.only(top: 30, left: 4),
      child: Column(
        children: game.keyboard
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row
                    .map(
                      (char) => Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4, right: 4),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 36,
                            ),
                            child: MaterialButton(
                              child: Text(
                                char,
                                style: GoogleFonts.pressStart2p(fontSize: 14),
                              ),
                              height: 50,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              onPressed:
                                  game.disabledKeyboardLetters.contains(char)
                                      ? null
                                      : () => GamePlay.checkGuess(ref, char),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
