import 'package:flutter/foundation.dart';

class RException {
  static void errorHandler({required String erroMessage}) {
    // In a real app, you might log this to a service like Sentry or Firebase Crashlytics
    debugPrint("-------------------- ERROR HANDLER --------------------");
    debugPrint(erroMessage);
    debugPrint("-------------------------------------------------------");
  }

  static void exceptionHandler({required String exceptionMessage, StackTrace? stackTrace}) {
    // In a real app, you might log this to a service like Sentry or Firebase Crashlytics
    debugPrint("----------------- EXCEPTION HANDLER -----------------");
    debugPrint(exceptionMessage);
    if (stackTrace != null) {
      debugPrint("Stack Trace: \n$stackTrace");
    }
    debugPrint("-------------------------------------------------------");
  }
}
