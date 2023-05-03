import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IBMText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final bool bold;

  IBMText({
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    required this.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSansKr(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
