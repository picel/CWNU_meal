import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JuaText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final bool bold;

  JuaText({
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    required this.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.jua(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
