import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/game_helper.dart';
import '../utilities/locale_keys.dart';

class StartGameButton extends StatelessWidget {
  StartGameButton({
    required this.title,
    required this.onTapped,
  });

  final Function() onTapped;
  final String title;
  final GamePlay gameHelper = GamePlay();

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
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}

class BackToMainMenuButton extends StatelessWidget {
  BackToMainMenuButton({this.leaveGame = false});

  final bool leaveGame;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 10,
      child: IconButton(
        icon: Icon(
          Icons.home_rounded,
          color: Colors.grey.shade600,
        ),
        onPressed: () async {
          if (leaveGame) {
            bool isLeaving = await ExitAlert.show(
              context,
              LocaleKeys.quitGameContentMessage,
              cancelButton: LocaleKeys.quitGameCancelButton,
              okButton: LocaleKeys.quitGameOkButton,
            );
            if (isLeaving) {
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class FinishedGameMessage extends StatelessWidget {
  const FinishedGameMessage({required this.message});

  final String message;

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        message,
        style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
        textAlign: TextAlign.center,
      ).tr(),
    );
  }
}

class ExitAlert {
  static Future<bool> show(BuildContext context, String content,
      {String cancelButton = '', String okButton = ''}) async {
    bool willExit = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            content,
            style: GoogleFonts.pressStart2p(fontSize: 16, height: 1.5),
          ).tr(),
          actions: [
            if (cancelButton.isNotEmpty)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancelButton,
                  style: GoogleFonts.pressStart2p(fontSize: 16),
                ).tr(),
              ),
            if (okButton.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                ),
                onPressed: () {
                  willExit = true;
                  Navigator.pop(context);
                },
                child: Text(
                  okButton,
                  style: GoogleFonts.pressStart2p(fontSize: 16),
                ).tr(),
              ),
          ],
        );
      },
    );

    return willExit;
  }
}

class PhraseMeaning {
  static Future show(BuildContext context, String content) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Meaning',
            style: GoogleFonts.pressStart2p(fontSize: 16),
          ),
          content: Text(
            content,
            style: GoogleFonts.pressStart2p(fontSize: 16, height: 1.5),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Dismiss',
                    style: GoogleFonts.pressStart2p(fontSize: 16))),
          ],
        );
      },
    );
  }
}

const kBackgroundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/background.jpg'),
    fit: BoxFit.cover,
  ),
);
