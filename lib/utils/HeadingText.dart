import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;
  HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}
