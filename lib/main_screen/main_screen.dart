import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/game_logic.dart';
import 'package:hangman/game_on_screen/game_on_screen.dart';
import 'package:hangman/main_screen/main_screen_components.dart';
import 'package:hangman/player_input_word_screen/player_input_word_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GameLogic gameLogic = GameLogic();

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('images/background.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: FittedBox(
            child: Text(
              'Mr. Hangman',
              style: GoogleFonts.pressStart2p(fontSize: 28),
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset('images/mr. hangman.png'),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Save Mr. Hangman from the evil hands!',
                    style: GoogleFonts.pressStart2p(fontSize: 20, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              StartGameButton(
                buttonLabel: 'QUICK',
                onTapped: () {
                  String word = gameLogic.quickGameWordGenerator();
                  String hiddenWord = gameLogic.hideWord(word);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          GameOnScreen(word: word, hiddenWord: hiddenWord)));
                },
              ),
              StartGameButton(
                buttonLabel: '2 PLAYER',
                onTapped: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlayerInputWordScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
