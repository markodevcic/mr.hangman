import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void push(Widget widget) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  void pushReplacement(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  bool canPop() {
    return Navigator.canPop(this);
  }
}
