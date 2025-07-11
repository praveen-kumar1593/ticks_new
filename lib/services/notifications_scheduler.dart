import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AttendanceNotificationsScheduler {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  static Future<void> manageAttendanceNotification({
    required String currentStatus,
    required String newStatus,
    required bool isIndividualUser,
  }) async {
    // Cancel existing notifications
    await _notifications.cancelAll();

    if (newStatus.toUpperCase() == 'ONLINE') {
      // Schedule checkout reminder after 8 hours
      await _scheduleCheckoutReminder();
    } else if (newStatus.toUpperCase() == 'BREAK') {
      // Schedule break end reminder after 1 hour
      await _scheduleBreakEndReminder();
    }
  }

  static Future<void> _scheduleCheckoutReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'attendance_channel',
      'Attendance Notifications',
      channelDescription: 'Notifications for attendance reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // Schedule checkout reminder after 8 hours
    await _notifications.zonedSchedule(
      1,
      'Time to Check Out',
      'You have been working for 8 hours. Consider checking out.',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 8)),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> _scheduleBreakEndReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'attendance_channel',
      'Attendance Notifications',
      channelDescription: 'Notifications for attendance reminders',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // Schedule break end reminder after 1 hour
    await _notifications.zonedSchedule(
      2,
      'Break Time Reminder',
      'You have been on break for 1 hour. Consider resuming work.',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> checkScheduledNotifications() async {
    final pendingNotifications = await _notifications.pendingNotificationRequests();
    print('Pending notifications: ${pendingNotifications.length}');
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
} 