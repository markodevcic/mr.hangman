import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:hangman/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Image background;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
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

  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
    background = Image.asset('assets/images/background.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(background.image, context);
  }

  _navigateToMainScreen() async {
    await Future.delayed(Duration(milliseconds: 3500));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
