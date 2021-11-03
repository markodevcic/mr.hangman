import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/game_logic.dart';
import 'package:hangman/game_on_screen/game_on_screen.dart';

class PlayerInputWordScreen extends StatelessWidget {
  PlayerInputWordScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final GameLogic gameLogic = GameLogic();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(
                image: AssetImage('images/mr. hangman questions.png'),
                fit: BoxFit.fill,
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: controller,
                  maxLength: 40,
                  onFieldSubmitted: (value) {
                    if (value.isEmpty ||
                        value.contains(RegExp(r'[^a-zA-Z ]'))) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                  'Only letters from \'a\' to \'z\' and space is permitted!',
                                  style: GoogleFonts.pressStart2p(height: 1.2),
                                ),
                                actions: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      onPressed: () {
                                        controller.clear();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Get it',
                                          style: GoogleFonts.pressStart2p())),
                                ],
                              ));
                    } else {
                      String word = value.toUpperCase();
                      String hiddenWord = gameLogic.hideWord(word);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => GameOnScreen(
                              word: word, hiddenWord: hiddenWord)));
                    }
                  },
                  style: GoogleFonts.pressStart2p(),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Only a-z and space',
                    label: const Center(
                        child: Text('Type new phrase to guess',
                            textAlign: TextAlign.center)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white54, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
