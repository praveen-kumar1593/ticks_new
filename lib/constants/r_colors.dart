import 'package:flutter/material.dart';

class RColors {
  static Color blue = hexToColor("#0C6DAD");
  static Color black = hexToColor("#242323");
  static Color darkRed = hexToColor("#FF0000");
  static Color mediumRed = hexToColor("#990000");
  static Color grey = hexToColor("#F1F1F1");
  static Color backGroundGrey = hexToColor("#F6F6F6");
  static Color darkGrey = hexToColor("#909090");
  static Color pureWhite = hexToColor("#FFFFFF");
  static Color neonGreen = hexToColor("#B3F607");
  static Color darkBlue = hexToColor("#003253");
  static Color fadedGreyText = hexToColor("#8A8A8A");
  static Color darkGreyText = hexToColor("#666666");
  static Color darkGreen = hexToColor("##08AD16");

  static Color borderGrey = hexToColor("#C9C9C9");
  static Color criticalRed = hexToColor("#f40014");
  static Color highOrange = hexToColor("#ff9d4c");
  static Color mediumBlue = blue;
  static Color lowGrey = hexToColor("#7a7a7a");
  static Color warningYellow = hexToColor("#ffb525");
  static  Color orange = Color(0xFFFD9C27);
   static Color lightblue = Color(0xFFF4F9FF);

  static Color getCriticalityColor(String? criticality) {
    switch (criticality?.toUpperCase()) {
      case 'CRITICAL':
        return RColors.criticalRed;
      case 'HIGH':
        return RColors.highOrange;
      case 'MEDIUM':
        return RColors.mediumBlue;
      case 'LOW':
        return RColors.lowGrey;
      case 'WARNING':
        return RColors.warningYellow;
      default:
        return Colors.grey;
    }
  }
}

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  if (hex.length == 6) {
    hex = "FF$hex"; // Add full opacity if not provided
  }
  return Color(int.parse("0x$hex"));
}
