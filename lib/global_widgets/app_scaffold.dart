import 'package:flutter/material.dart';

import '../components/reusable_buttons.dart';
import '../utilities/locale_keys.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {Key? key,
      required this.child,
      this.topButton,
      this.backButtonQuitsGame = false})
      : super(key: key);

  final Widget child;
  final Widget? topButton;
  final bool backButtonQuitsGame;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await ExitAlert.show(
          context,
          backButtonQuitsGame
              ? LocaleKeys.quitGameContentMessage
              : LocaleKeys.exitGameContentMessage,
          cancelButton: backButtonQuitsGame
              ? LocaleKeys.quitGameCancelButton
              : LocaleKeys.exitGameCancelButton,
          okButton: backButtonQuitsGame
              ? LocaleKeys.quitGameOkButton
              : LocaleKeys.exitGameOkButton,
        );
      },
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                child,
                if (topButton != null) topButton!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
