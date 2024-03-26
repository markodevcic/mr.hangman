import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ).tr(),
      ),
    );
  }
}
