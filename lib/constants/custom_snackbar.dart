import 'package:ticks_new/constants/r_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'custom_text_style.dart';


enum SnackbarType { success, error, info, warning }

void rShowCustomSnackbar({String? title, required String message, required SnackbarType snackbarType}) {
  final Icon icon;
  final Color backgroundColor;
  switch (snackbarType) {
    case SnackbarType.success:
      icon = Icon(Icons.check, color: RColors.pureWhite);
      backgroundColor = Colors.green;
    case SnackbarType.error:
      icon = Icon(Icons.error_outline, color: RColors.pureWhite);
      backgroundColor = RColors.darkRed;
    case SnackbarType.info:
      icon = Icon(Icons.info_outline_rounded, color: RColors.pureWhite);
      backgroundColor = RColors.black;
    case SnackbarType.warning:
      icon = Icon(Icons.warning_amber_outlined, color: RColors.pureWhite);
      backgroundColor = Colors.deepOrangeAccent;
  }

  Get.rawSnackbar(
    titleText:
        title != null
            ? Text(title, style: CustomTextStyle(color: RColors.pureWhite, fontWeight: FontWeight.bold, fontSize: 16))
            : null,
    messageText: Text(
      message,
      style: CustomTextStyle(color: RColors.pureWhite, fontSize: 14, fontWeight: FontWeight.bold),
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    backgroundColor: backgroundColor, // Dark background like LinkedIn
    borderRadius: 8,
    duration: const Duration(seconds: 3),
    icon: icon,
    padding: const EdgeInsets.all(12),
    overlayBlur: 0, // No unnecessary blur
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    animationDuration: const Duration(milliseconds: 300),
  );
}
