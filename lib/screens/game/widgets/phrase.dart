import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/reusable_buttons.dart';
import '../../../models/game.dart';

class Phrase extends StatelessWidget {
  const Phrase({Key? key, required this.game}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
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
