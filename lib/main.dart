import 'package:flutter/material.dart';
import 'package:hangman/splash_screen/splash_screen.dart';

void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
