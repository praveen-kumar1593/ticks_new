import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message, {String type = 'info'}) {
  Get.snackbar(
    type[0].toUpperCase() + type.substring(1), // Capitalize type for title
    message,
    backgroundColor: type == 'error' ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(12),
    borderRadius: 8,
  );
} 