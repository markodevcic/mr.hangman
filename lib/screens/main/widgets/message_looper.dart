import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/game_provider.dart';
import '../../../utilities/locale_keys.dart';
import '../constants.dart';

class MessageLooper extends StatefulWidget {
  const MessageLooper({Key? key}) : super(key: key);

  @override
  State<MessageLooper> createState() => _MessageLooperState();
}

class _MessageLooperState extends State<MessageLooper> {
  bool isVisible = true;
  int isNotVisibleTime = 600;

  String mainScreenMessage = '';

  final GamePlay gameHelper = GamePlay();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(milliseconds: isNotVisibleTime), (_) {
        if (isVisible == false) {
          setState(() => isNotVisibleTime = 5000);
          mainScreenMessage =
              generateMainScreenMessages(LocaleKeys.keyboardLanguage.tr());
        } else {
          setState(() => isNotVisibleTime = 300);
        }
        return isVisible = !isVisible;
      }),
      builder: (context, snapshot) {
        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                mainScreenMessage,
                style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
