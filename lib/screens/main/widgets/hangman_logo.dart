import 'package:flutter/material.dart';
import 'package:hangman/screens/main/widgets/scaffold_title.dart';

class HangmanLogo extends StatelessWidget {
  const HangmanLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splash_logo',
      child: Material(
        type: MaterialType.transparency,
        child: ScaffoldTitle(title: 'Mr. Hangman'),
      ),
    );
  }
}
