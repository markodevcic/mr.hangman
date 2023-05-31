import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/screens/select_language_screen.dart';
import 'package:hangman/utilities/extensions.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 80,
      child: IconButton(
        icon: Text(
          context.locale.toString().substring(0, 2).toUpperCase(),
          style: GoogleFonts.pressStart2p(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        onPressed: () => context.push(SelectLanguageScreen()),
      ),
    );
  }
}
