import 'package:flutter/material.dart';

class CustomTextStyle extends TextStyle {
  const CustomTextStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal, Color? color})
    : super(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black, // Default to black if no color provided
        letterSpacing: -.2, // Common letter spacing globally applied
      );
}
