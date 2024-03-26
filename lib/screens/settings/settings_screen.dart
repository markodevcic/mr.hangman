import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hangman/global_widgets/app_scaffold.dart';
import 'package:hangman/global_widgets/reusable_buttons.dart';
import 'package:hangman/screens/main/widgets/scaffold_title.dart';
import 'package:hangman/utilities/extensions.dart';
import 'package:hangman/utilities/locale_keys.dart';
import 'package:hangman/utilities/prefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: ScaffoldTitle(title: LocaleKeys.settingsScreenTitle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text(LocaleKeys.settingsLanguageTitle).tr(),
                  leading: const Icon(Icons.language),
                  horizontalTitleGap: 30,
                  trailing: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Colors.grey.shade800.withOpacity(0.5)),
                    child: DropdownButton<Locale>(
                      onChanged: (Locale? locale) {
                        context.setLocale(locale!);
                        Prefs.saveLanguage(locale.toLanguageTag());
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      value: context.locale,
                      items: context.supportedLocales
                          .map(
                            (locale) => DropdownMenuItem(
                              value: locale,
                              child: Text(locale.languageCode,
                                  style: TextStyle(fontSize: 14)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Game difficulty'),
                  leading: const Icon(Icons.emoji_events),
                  horizontalTitleGap: 30,
                  trailing: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Colors.grey.shade800.withOpacity(0.5)),
                    child: DropdownButton<String>(
                      onChanged: (String? difficulty) {
                        Prefs.saveDifficulty(difficulty!);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      value: Prefs.loadDifficulty(),
                      items: [
                        DropdownMenuItem(
                          value: 'easy',
                          child: Text('Easy', style: TextStyle(fontSize: 14)),
                        ),
                        DropdownMenuItem(
                          value: 'medium',
                          child: Text('Medium', style: TextStyle(fontSize: 14)),
                        ),
                        DropdownMenuItem(
                          value: 'hard',
                          child: Text('Hard', style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          AppButton(
            title: LocaleKeys.settingsScreenBackButton,
            onTap: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
