import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.showButton,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    if (!showButton) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
