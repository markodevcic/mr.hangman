import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/screens/main/main_screen.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/prefs.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Prefs.init();
      await Prefs.saveLanguage(context.locale.languageCode);
      await Future.delayed(Duration(seconds: 3));
      context.pushReplacement(MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: FittedBox(
          child: Hero(
            tag: 'splash_logo',
            // added Material to fix red letter when Hero is 'on fly'
            child: Material(
              type: MaterialType.transparency,
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Mr. Hangman',
                    speed: Duration(milliseconds: 240),
                    curve: Curves.fastOutSlowIn,
                    textStyle: GoogleFonts.pressStart2p(fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
