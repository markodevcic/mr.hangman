import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 70,
      child: IconButton(
        icon: Text(
          context.locale.toString().substring(0, 2).toUpperCase(),
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => StartHangman()),
              (route) => false);
        },
      ),
    );
  }
}
