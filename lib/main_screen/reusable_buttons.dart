import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../game_logic.dart';
import 'main_screen.dart';

class StartGameButton extends StatelessWidget {
  final String buttonLabelFirstLine;
  final String buttonLabelSecondLine;
  final Function() onTapped;

  StartGameButton(
      {Key? key, required this.buttonLabelFirstLine, required this.buttonLabelSecondLine, required this.onTapped})
      : super(key: key);

  final GameLogic gameLogic = GameLogic();

  @override
  Widget build(context) {
    return Card(
      elevation: 8,
      color: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTapped,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Text(
            '$buttonLabelFirstLine\n$buttonLabelSecondLine',
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.4),
          ),
        ),
      ),
    );
  }
}

class BackToMainMenuButton extends StatelessWidget {
  const BackToMainMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: IconButton(
        icon: Icon(
          Icons.home_rounded,
          color: Colors.grey.shade600,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
        },
      ),
      left: 10,
      top: 10,
    );
  }
}

class GameEndMessage extends StatelessWidget {
  final String message;
  const GameEndMessage({required this.message});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        message,
        style: GoogleFonts.pressStart2p(fontSize: 20, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ShowExitAlert {
  Future<bool> showAlertDialog(BuildContext context, String content, bool willLeave,
      {String cancelButton = '', String okButton = ''}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            content,
            style: GoogleFonts.pressStart2p(fontSize: 16, height: 1.5),
          ),
          actions: [
            if (cancelButton.isNotEmpty)
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(cancelButton, style: GoogleFonts.pressStart2p(fontSize: 16))),
            if (okButton.isNotEmpty)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade600,
                  ),
                  onPressed: () {
                    willLeave = true;
                    Navigator.of(context).pop(willLeave);
                  },
                  child: Text(okButton, style: GoogleFonts.pressStart2p(fontSize: 16)))
          ],
        );
      },
    );
  }
}

const kBackgroundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/background.jpg'),
    fit: BoxFit.cover,
  ),
);
