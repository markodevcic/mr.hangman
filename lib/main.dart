import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/screens/main_screen.dart';
import 'translations/l10n.dart';

void main() {
  runApp(StartHangman());
}

class StartHangman extends StatefulWidget {
  String language = 'en';

  @override
  State<StartHangman> createState() => _StartHangmanState();
}

class _StartHangmanState extends State<StartHangman> {
  late Image background;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: L10n.all,
      locale: Locale(widget.language),
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Hero(
                  tag: 'splash_logo',
                  // added Material to fix red letter when Hero is 'on fly'
                  child: Material(
                    type: MaterialType.transparency,
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          ' Mr. Hangman',
                          speed: Duration(milliseconds: 240),
                          curve: Curves.fastOutSlowIn,
                          textStyle: GoogleFonts.pressStart2p(fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          widget.language = 'en';
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                      child: Text('ENG', style: GoogleFonts.pressStart2p(color: Colors.white)),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          widget.language = 'hr';
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                      child: Text('HRV', style: GoogleFonts.pressStart2p(color: Colors.white)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    background = Image.asset('assets/images/background.jpg');
    triggerLanguages();
  }

  triggerLanguages() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(background.image, context);
  }
}
