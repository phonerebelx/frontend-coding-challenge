import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final double letterSpacing;
  final TextAlign textAlign;
  final double height;
  final int? maxLines;
  final bool underline;

  CustomText({
    required this.text,
    required this.textColor,
    required this.fontSize,
    this.letterSpacing = 1.0,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Manrope',
    this.textAlign = TextAlign.left,
    this.height = 1.2,
    this.underline = false, // Default is no underline
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height,
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
