// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// import '../../../main.dart';
// import '../../services/shared_preferences_services.dart';
//
//
// class NotificationController {
//   static const String jobsChannelKey = 'job-alerts';
//   static const String serviceRequestChannelKey = "service-request-alerts";
//   static const String notifyMeChannelKey = "notify-me";
//   static const String alertsChannelKey = "alerts";
//   static const String backgroundServiceKey = 'background-service';
//   static const String CHANNEL_GROUP_KEY = 'job-tracking-group';
//
//   static void awesomeNotificationinitialise() {
//     AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: alertsChannelKey,
//           channelName: 'alerts',
//           channelDescription: 'alert notifications',
//           vibrationPattern: lowVibrationPattern,
//           importance: NotificationImportance.High,
//           soundSource: 'resource://raw/res_notification_sound',
//           playSound: true,
//         ),
//         NotificationChannel(
//           channelKey: jobsChannelKey,
//           channelName: 'Job alerts',
//           channelDescription: 'Job notifications',
//           vibrationPattern: lowVibrationPattern,
//           importance: NotificationImportance.High,
//           soundSource: 'resource://raw/res_notification_sound',
//           playSound: true,
//         ),
//         NotificationChannel(
//           channelKey: serviceRequestChannelKey,
//           channelName: 'Service request alerts',
//           channelDescription: 'Service request notifications ',
//           vibrationPattern: lowVibrationPattern,
//           importance: NotificationImportance.High,
//           soundSource: 'resource://raw/res_notification_sound',
//           playSound: true,
//         ),
//         NotificationChannel(
//           channelKey: notifyMeChannelKey,
//           channelName: 'NotifyMe alerts',
//           channelDescription: 'NotifyMe notifications',
//           vibrationPattern: lowVibrationPattern,
//           importance: NotificationImportance.High,
//           ledColor: Colors.yellow,
//           locked: true,
//           soundSource: 'resource://raw/res_notification_sound',
//           playSound: true,
//         ),
//         NotificationChannel(
//           channelKey: backgroundServiceKey,
//           channelName: 'Background Service',
//           channelDescription: 'Background Service notifications',
//           importance: NotificationImportance.Low,
//           playSound: false,
//           enableVibration: false,
//           locked: true,
//           onlyAlertOnce: true,
//         ),
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: CHANNEL_GROUP_KEY,
//           channelGroupName: 'Job Updates',
//         ),
//       ],
//     ).onError((error, stackTrace) {
//       return true;
//     });
//   }
//
//   static startListeningNotificationEvents() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//     );
//   }
//
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//     ReceivedAction action,
//   ) async {
//     print("hi im in this 115");
//     try {
//       Map<String, String?> payload = action.payload!;
//       String updateItemType = payload['updateItemType'] ?? "";
//       if (updateItemType == "JOB") {
//         int? commentId =
//             payload['commentId'] == null || payload['commentId']!.isEmpty
//                 ? null
//                 : int.parse(payload['commentId']!);
//         int? replyId = payload['replyId'] == null || payload['replyId']!.isEmpty
//             ? null
//             : int.parse(payload['replyId']!);
//         int? checkListId =
//             payload['checkListId'] == null || payload['checkListId']!.isEmpty
//                 ? null
//                 : int.parse(payload['checkListId']!);
//         MyApp.navigatorKey.currentState?.pushNamed(
//           JobDetailsScreen.id,
//           arguments: {
//             "jobId": int.parse(payload['jobId']!),
//             "commentId": commentId,
//             "replyId": replyId,
//             "checklistId": checkListId,
//           },
//         );
//       } else if (updateItemType == "SERVICE REQUEST") {
//         String serviceRequestId = payload["serviceRequestId"] ?? "";
//         if (serviceRequestId.isEmpty) {
//           return;
//         }
//         String replaced =
//             serviceRequestId.substring(1, serviceRequestId.length - 1);
//         List<String> splited = replaced.split(",").toList();
//         MyApp.navigatorKey.currentState?.pushNamed(
//           ServiceDetailsScreen.id,
//           arguments: {
//             "requestNumber": splited[0],
//           },
//         );
//       } else {
//         print("hi im in this ");
//       }
//     } catch (e) {
//       // TODO
//     }
//   }
//
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//     ReceivedNotification receivedNotification,
//   ) async {
//     String? isSpokenNotificationsEnabled = SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';
//     if (isSpokenNotificationsEnabled == 'true') {
//       if (receivedNotification.title != null &&
//           receivedNotification.body != null) {
//         try {
//           FlutterTts tts = FlutterTts();
//           await tts.setLanguage("en-US");
//           print("running......................tts");
//           await tts.speak(
//               "${receivedNotification.title}. ${receivedNotification.body}");
//         } catch (e) {
//           print("Background TTS error: $e");
//         }
//       }
//     }
//     if (receivedNotification.channelKey == "attendance_missed_checkout") {
//       if (MyApp.navigatorKey.currentState != null) {
//         attendanceForceCheckoutUser(MyApp.navigatorKey.currentState!.context);
//       } else {
//         print("Navigator state is not available.");
//       }
//     }
//   }
//
//   void loadSingletonPage(
//     NavigatorState? navigatorState, {
//     required String targetPage,
//     Map<String, String?>? payload,
//   }) {
//     navigatorState?.pushNamed(
//       targetPage,
//       arguments: payload,
//     );
//   }
// }