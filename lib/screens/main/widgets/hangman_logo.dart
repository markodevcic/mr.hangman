import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HangmanLogo extends StatelessWidget {
  const HangmanLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splash_logo',
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: 80,
          child: Center(
            child: Text(
              'Mr. Hangman',
              style: GoogleFonts.pressStart2p(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }
}
