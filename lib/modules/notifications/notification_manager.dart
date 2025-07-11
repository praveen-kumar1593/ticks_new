import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ticks_new/modules/notifications/attendance_notifications_controller.dart';
import 'package:ticks_new/services/shared_preferences_services.dart';

class NotificationManager {
  final AttendanceNotificationController _controller =
      AttendanceNotificationController();

  // Initialize and request permissions
  Future<void> initialize() async {
    await _controller.initialize();
    await _controller.requestPermission();
  }

  Future<bool> shouldAnnounce() async {
    String isSpokenNoitificaitonsEnabled =
        await SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';

    print(
        "isSpokenNoitificaitonsEnabled  ====>>> $isSpokenNoitificaitonsEnabled");

    if (isSpokenNoitificaitonsEnabled == "true") {
      return true;
    } else {
      return false;
    }
  }

  // Show an immediate notification
  Future<void> showImmediateNotification({
    required int id,
    required String title,
    required String body,
    required String channel,
    Map<String, String>? payload,
    bool shouldAnnounce = true,
  }) async {
    await _controller.showNotification(
      id: id,
      title: title,
      body: body,
      channelKey: channel,
      payload: payload,
      shouldAnnounce: shouldAnnounce,
    );
  }

  // Schedule a notification for a specific time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String channel,
    Map<String, String>? payload,
    bool shouldAnnounce = true,
  }) async {
    print(
        "scheduling notifications ------id ---  \\${id} === title -- > $title ----- body =--- $body --- date --- $scheduledDate ---- channel ---- $channel ");

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channel,
        title: title,
        body: body,
        payload: payload,
        wakeUpScreen: true,
        criticalAlert: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduledDate,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );

    // Also schedule a silent notification to ensure handling in background/terminated state
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id + 100,
        channelKey: channel,
        title: null,
        body: null,
        payload: {
          'notificationId': id.toString(),
          'title': title,
          'body': body,
          'isScheduled': 'true',
          'shouldAnnounce': shouldAnnounce.toString(),
        },
        displayOnBackground: true,
        displayOnForeground: false,
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduledDate,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }

  // Schedule a daily repeating notification
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay timeOfDay,
    required String channel,
    Map<String, String>? payload,
    bool shouldAnnounce = true,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channel,
        title: title,
        body: body,
        payload: payload,
        wakeUpScreen: true,
        criticalAlert: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      schedule: NotificationCalendar(
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
        second: 0,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );

    // Also schedule a silent notification
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id + 1000,
        channelKey: channel,
        title: null,
        body: null,
        payload: {
          'notificationId': id.toString(),
          'title': title,
          'body': body,
          'isScheduled': 'true',
          'shouldAnnounce': shouldAnnounce.toString(),
        },
        displayOnBackground: true,
        displayOnForeground: false,
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar(
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
        second: 0,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }

  // Schedule a weekly notification
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required List<int> weekdays, // 1 = Monday, 7 = Sunday
    required TimeOfDay timeOfDay,
    required String channel,
    Map<String, String>? payload,
    bool shouldAnnounce = true,
  }) async {
    for (int weekday in weekdays) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id + weekday, // Add weekday to ID to make it unique
          channelKey: channel,
          title: title,
          body: body,
          payload: payload,
          wakeUpScreen: true,
          criticalAlert: true,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
        schedule: NotificationCalendar(
          weekday: weekday,
          hour: timeOfDay.hour,
          minute: timeOfDay.minute,
          second: 0,
          repeats: true,
          preciseAlarm: true,
          allowWhileIdle: true,
        ),
      );

      // Also schedule a silent notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id + weekday + 1000,
          channelKey: channel,
          title: null,
          body: null,
          payload: {
            'notificationId': (id + weekday).toString(),
            'title': title,
            'body': body,
            'isScheduled': 'true',
            'shouldAnnounce': shouldAnnounce.toString(),
          },
          displayOnBackground: true,
          displayOnForeground: false,
          wakeUpScreen: true,
        ),
        schedule: NotificationCalendar(
          weekday: weekday,
          hour: timeOfDay.hour,
          minute: timeOfDay.minute,
          second: 0,
          repeats: true,
          preciseAlarm: true,
          allowWhileIdle: true,
        ),
      );
    }
  }

  // Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _controller.cancelNotification(id);
  }

  // Cancel all notifications in a channel
  Future<void> cancelNotificationsInChannel(channelKey) async {
    await _controller.cancelNotificationsByChannel(channelKey);
  }

  // Cancel all scheduled notifications
  Future<void> cancelAllScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  // Get all pending notification schedules
  Future<List<NotificationModel>> listScheduledNotifications() async {
    final List<NotificationModel> activeSchedules =
        await AwesomeNotifications().listScheduledNotifications();
    return activeSchedules;
  }

  // Dispose resources
  void dispose() {
    _controller.dispose();
  }
}
