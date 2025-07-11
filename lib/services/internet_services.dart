import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class InterNetServices {
  static Future<bool> checkInternetConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      // In case of any error, assume no connectivity
      return false;
    }
  }
} 