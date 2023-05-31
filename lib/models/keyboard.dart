import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Keyboard {
  static Map keyboard = {
    'en': [
      ['Q', 'W', 'E', 'R', 'T', 'Z', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Y', 'X', 'C', 'V', 'B', 'N', 'M']
    ],
    'hr': [
      ['Q', 'W', 'E', 'R', 'T', 'Z', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Č', 'Ć'],
      ['Y', 'X', 'C', 'V', 'B', 'N', 'M', 'Š', 'Đ', 'Ž']
    ]
  };

  static List<List<String>> create(BuildContext context) =>
      keyboard[context.locale.languageCode];
}
