import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/providers/game_provider.dart';

class Phrase extends ConsumerWidget {
  const Phrase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider)!;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            game.hiddenPhrase,
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
          ),
        ),
        if (game.hiddenPhrase == game.phrase && game.phraseMeaning != null)
          Align(
            alignment: Alignment(1.05, 0.0),
            child: IconButton(
              icon: Icon(Icons.info_outline,
                  size: 14, color: Colors.grey.shade400),
              onPressed: () {
                PhraseMeaning.show(
                  context,
                  game.phraseMeaning!,
                );
              },
            ),
          ),
      ],
    );
  }
}
