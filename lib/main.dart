import 'package:flutter/material.dart';

import 'main_screen/main_screen.dart';

void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      theme: ThemeData.dark(),
      home: const MainScreen(title: 'Hangman'),
    );
  }
}
