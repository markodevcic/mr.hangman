import 'package:flutter/material.dart';

enum CurrentWidgetType { icon, text }

class WidgetType {
  CurrentWidgetType type = CurrentWidgetType.icon;

  T when<T>({
    T Function()? icon,
    T Function()? text,
  }) {
    switch (type) {
      case CurrentWidgetType.icon:
        return icon!();
      case CurrentWidgetType.text:
        return text!();
      default:
        throw Exception('Unhandled method: $type');
    }
  }
}

// ignore: must_be_immutable
class TopScaffoldButton extends StatelessWidget with WidgetType {
  TopScaffoldButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
  }) : text = null {
    type = CurrentWidgetType.icon;
  }

  TopScaffoldButton.text({
    super.key,
    required this.text,
    required this.onPressed,
  }) : icon = null {
    type = CurrentWidgetType.text;
  }

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 0,
      child: when(
        icon: () => IconButton(
          icon: Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          onPressed: onPressed,
        ),
        text: () => TextButton(
          onPressed: onPressed,
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
