import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/screens/main/main_screen.dart';
import 'package:hangman/utilities/extensions.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  late Image background;
  bool isVisible = false;

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
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
                      textStyle: TextStyle(fontSize: 28),
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
                      context.setLocale(Locale('en', 'US'));
                    });
                    if (Navigator.canPop(context)) {
                      context.pop();
                    } else {
                      context.pushReplacement(MainScreen());
                    }
                  },
                  child: Text('EN'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      context.setLocale(Locale('hr', 'HR'));
                    });
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.pushReplacement(MainScreen());
                    }
                  },
                  child: Text('HR'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
