import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import 'package:flutter_tts/flutter_tts.dart';

@pragma('vm:entry-point')
Future<void> myBackgroundNotificationActionHandler(
    ReceivedAction receivedAction) async {
  if (receivedAction.groupKey ==
      AttendanceNotificationController.ATTENDANCE_GROUP) {
    print('Background action received from custom group');
    print('ActionId: \\${receivedAction.actionType}');
    print('ActionData: \\${receivedAction.payload}');
  }
}

class AttendanceNotificationController {
  static final AttendanceNotificationController _instance =
      AttendanceNotificationController._internal();
  factory AttendanceNotificationController() => _instance;
  AttendanceNotificationController._internal();

  final FlutterTts flutterTts = FlutterTts();

  // ----------------------------   Attendance Notificaitons keys ------------------------------ //

  static const String ATTENDANCE_GROUP = 'attendance_group';

  static const String ATTENDANCE_individual = 'alerts';


  static const String beforeCheckInChannelKey = 'attendance_before_checkin';
  static const String missedCheckInChannelKey = 'attendance_missed_checkin';

  static const String breakExceedChannelKey = 'attendance_break_exceeds';
  static const String breakExceedReminderChannelKey =
      'attendance_break_reminder';

  static const String beforeCheckOutChannelKey = 'attendance_before_checkout';
  static const String missedCheckOutChannelKey = 'attendance_missed_checkout';

  // final FlutterTts flutterTts = FlutterTts();

  Future<void> initialize() async {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: _onActionReceivedMethod,
        onNotificationCreatedMethod: _onNotificationCreatedMethod,
        onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: _onDismissActionReceivedMethod);

    await AwesomeNotifications().initialize(
      null, // no default icon, will use app icon
      [
        //---------------- Attendance Local Notification channels  --------- //
        NotificationChannel(
          channelKey: beforeCheckInChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance before check in.',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          locked: false,
          onlyAlertOnce: false,
          criticalAlerts: true,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: missedCheckInChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance missed check in',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          locked: false,
          criticalAlerts: true,
          onlyAlertOnce: false,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: breakExceedReminderChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance for exceeding breaks remonder',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          criticalAlerts: true,
          locked: false,
          onlyAlertOnce: false,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: breakExceedChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance for exceeding breaks',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          locked: false,
          criticalAlerts: true,
          onlyAlertOnce: false,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: beforeCheckOutChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance before check out.',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          locked: false,
          criticalAlerts: true,
          onlyAlertOnce: false,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: missedCheckOutChannelKey,
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'Attendance Alerts',
          channelDescription:
              'Notifications and Alerts related to attendance missed check out.',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          criticalAlerts: true,
          locked: false,
          onlyAlertOnce: false,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: 'alerts',
          channelGroupKey: ATTENDANCE_GROUP,
          channelName: 'General Alerts',
          channelDescription: 'General alert notifications',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 500, 250, 500]),
          enableLights: true,
          locked: false,
          onlyAlertOnce: false,
          criticalAlerts: true,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: ATTENDANCE_GROUP,
          channelGroupName: 'Attendance Notifications',
        ),
      ],
      // debug: true,
    );

    // Initialize TTS
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  // Static methods that will be called in background
  @pragma('vm:entry-point')
  static Future<void> _onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print('Background action received from custom group 167');
    if (receivedAction.groupKey == ATTENDANCE_GROUP) {
      print('Background action received from custom group 169');
      myBackgroundNotificationActionHandler(receivedAction);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print('Background action received from custom group 117');
    if (receivedNotification.groupKey == ATTENDANCE_GROUP) {
      print('Notification created in background');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print('Background action received from custom group 186');

    if (receivedNotification.groupKey == ATTENDANCE_GROUP) {
      print('Notification displayed in background');

      // Try to announce if possible (may not work in terminated state)
      if (receivedNotification.title != null &&
          receivedNotification.body != null) {
        try {
          await AttendanceNotificationController().announceNotification(
              receivedNotification.title.toString(), receivedNotification.body.toString());
        } catch (e) {
          print("Background TTS error: $e");
        }
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print('Background action received from custom group 208');
    if (receivedAction.groupKey == ATTENDANCE_GROUP) {
      print('Notification dismissed');
    }
  }

  // Create a notification
  Future<bool> showNotification({
    required int id,
    required String title,
    required String body,
    required String channelKey,
    String? summary,
    Map<String, String>? payload,
    NotificationLayout layout = NotificationLayout.Default,
    NotificationCategory? category,
    bool playSound = true,
    bool enableVibration = true,
    bool shouldAnnounce = true,
  }) async {
    if (shouldAnnounce) {
      await _announceNotification(title, body);
    }

    // Send a silent notification to ensure background processing
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id + 1000, // Different ID to avoid conflicts
        channelKey: channelKey,
        title: null,
        body: null,
        payload: {
          'notificationId': id.toString(),
          'title': title,
          'body': body,
          'isBackground': 'true',
        },
        displayOnBackground: true,
        displayOnForeground: false,
        wakeUpScreen: true,
      ),
    );

    // Send the actual visible notification
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        summary: summary,
        category: category,
        payload: payload,
        notificationLayout: layout,
        wakeUpScreen: true,
        criticalAlert: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
    );
  }

  // Method to announce notification via TTS
  Future<void> _announceNotification(String title, String body) async {
    try {
      String announcement = "$title. $body";
      await flutterTts.speak(announcement);
    } catch (e) {
      print("TTS Error: $e");
    }
  }

  // Method to cancel specific notification
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
    await AwesomeNotifications()
        .cancel(id + 1000); // Also cancel the silent notification
  }

  // Method to cancel  notifications by channel
  Future<void> cancelNotificationsByChannel(String channelKey) async {
    await AwesomeNotifications().cancelNotificationsByChannelKey(channelKey);
  }

  // Method to cancel all the notifications
  Future<void> cancelAllNOtifications() async {
    await AwesomeNotifications().cancelAll();
  }

  // Request notification permissions, including critical alerts for background
  Future<bool> requestPermission() async {
    return await AwesomeNotifications()
        .requestPermissionToSendNotifications(permissions: [
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
      NotificationPermission
          .CriticalAlert, // This is important for background delivery
      NotificationPermission.FullScreenIntent,
    ]);
  }

  // Dispose resources
  void dispose() {
    flutterTts.stop();
  }

  // Add this method to test TTS notification
  void testTTSNotification() async {
    const String testTitle = 'TTS Test';
    const String testBody = 'This is a test of the voice notification system.';
    print('[TTS Debug] Triggering TTS: $testTitle - $testBody');
    await _announceNotification(testTitle, testBody);
    print('[TTS Debug] TTS should have spoken the test message.');
  }

  // Make announceNotification public for use in notification handlers
  Future<void> announceNotification(String title, String body) async {
    try {
      String announcement = "$title. $body";
      await flutterTts.speak(announcement);
    } catch (e) {
      print("TTS Error: $e");
    }
  }

  // Set up notification action handler to trigger TTS when notification is received or tapped
  // static Future<void> setupNotificationTTSHandler() async {
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: (ReceivedAction action) async {
  //       if (action.channelKey == AttendanceNotificationController.beforeCheckInChannelKey) {
  //         await AttendanceNotificationController().announceNotification(
  //           action.title ?? '', action.body ?? '');
  //       }
  //     },
  //     // You can add other listeners if needed
  //   );
  // }
  // static Future<void> setupNotificationsTTSHandler() async {
  //   AwesomeNotifications().setListeners(
  //       onActionReceivedMethod: (ReceivedAction action) async {
  //     // Play TTS for alerts and break reminders
  //     if (action.channelKey == 'alerts' ||
  //         action.channelKey == AttendanceNotificationController.breakExceedReminderChannelKey ||
  //         action.channelKey == AttendanceNotificationController.breakExceedChannelKey) {
  //       await AttendanceNotificationController().announceNotification(
  //           action.title ?? '', action.body ?? '');
  //     }
  //   });
  //   // .
  // }
}
