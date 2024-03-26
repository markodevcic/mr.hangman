import 'package:flutter/material.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/utilities/locale_keys.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.topButton,
    this.backButtonQuitsGame = false,
  });

  final Widget child;
  final Widget? title;
  final Widget? topButton;
  final bool backButtonQuitsGame;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (canPop) async {
        if (!canPop) {
          await ExitAlert.show(
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
        }
      },
      child: Container(
        decoration: kBackgroundImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                if (title != null) title!,
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      child,
                      if (topButton != null) topButton!,
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
