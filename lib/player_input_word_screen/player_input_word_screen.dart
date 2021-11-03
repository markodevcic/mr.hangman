import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/game_logic.dart';
import 'package:hangman/game_on_screen/game_on_screen.dart';
import 'package:hangman/main_screen/main_screen.dart';

class PlayerInputWordScreen extends StatelessWidget {
  PlayerInputWordScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final GameLogic gameLogic = GameLogic();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Are you going to abandon Mr. Hangman?',
              style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.2),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    willLeave = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Sorry',
                      style: GoogleFonts.pressStart2p(fontSize: 18))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade600,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Never!',
                      style: GoogleFonts.pressStart2p(fontSize: 18)))
            ],
          ),
        );
        return willLeave;
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.home_rounded,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainScreen()));
                    },
                  ),
                  left: 10,
                  top: 10,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: const Image(
                          image: AssetImage('images/mr. hangman questions.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          'Only letters from \'a\' to \'z\' and space are permitted!',
                                          style: GoogleFonts.pressStart2p(
                                              fontSize: 18, height: 1.2),
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
                                                  style:
                                                      GoogleFonts.pressStart2p(
                                                          fontSize: 18))),
                                        ],
                                      ));
                            } else {
                              String word = value.toUpperCase();
                              String hiddenWord = gameLogic.hideWord(word);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => GameOnScreen(
                                          word: word, hiddenWord: hiddenWord)));
                            }
                          },
                          style: GoogleFonts.pressStart2p(),
                          decoration: InputDecoration(
                            label: Text('Type new phrase to guess',
                                textAlign: TextAlign.center),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white54, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
