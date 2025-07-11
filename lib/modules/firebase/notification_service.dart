import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../services/shared_preferences_services.dart';
import 'notification_controller.dart';

class NotificationService {
  void showLocalNotification(
    RemoteMessage message, {
    required String channelKey,
    NotificationCalendar? notificationCalendar,
  }) {
    RemoteNotification? remoteNotification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    if (remoteNotification != null && androidNotification != null) {
      print(message.data);
      Map<String, String> payload = message.data.map(
        (key, value) => MapEntry(
          key,
          value,
        ),
      );
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: remoteNotification.hashCode,
          channelKey: channelKey,
          title: remoteNotification.title,
          body: remoteNotification.body,
          category: NotificationCategory.Status,
          fullScreenIntent: false,
          payload: payload,
        ),
        schedule: notificationCalendar,
      );
    } else {
      print("null value called");
    }
  }
  static Future<void> initializeAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'General alert notifications',
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
        ),
        NotificationChannel(
          channelKey: 'job-alerts',
          channelName: 'Job Alerts',
          channelDescription: 'Job notifications',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: 'service-request-alerts',
          channelName: 'Service Request Alerts',
          channelDescription: 'Service request notifications',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
        // Add other channels as needed
      ],
    );
  }

  Future<void> scheduleNotifyNotification({
    required int identifier,
    required String jobName,
    required DateTime notifyTime,
    required Map<String, String>? payload,
    required String channelKey,
    String durationName = "10 minutes",
    required bool isCompleteNotification,
    bool notifyMe = true,
  }) async {
    if (notifyMe) {
      print("notifyMe called");
      NotificationService().scheduleLocalNotification(
        channelKey: channelKey,
        id: identifier,
        title: "Job Reminder",
        body: isCompleteNotification
            ? '"$jobName" will be completed in $durationName'
            : '"$jobName" will start in $durationName',
        notificationCalendar: NotificationCalendar.fromDate(
          date: notifyTime,
        ),
        payload: payload,
      );
    } else {
      AwesomeNotifications().cancelSchedule(identifier.hashCode);
    }
  }

  void cancelScheduledNotfication(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  void cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  Future<List<NotificationModel>> checkScheduledNotifications() async {
    List<NotificationModel> alreadyScheduled =
        await AwesomeNotifications().listScheduledNotifications();
    return alreadyScheduled;
  }

  void scheduleLocalNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, String>? payload,
    required NotificationCalendar notificationCalendar,
    required String channelKey,
  }) {
    try {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          category: NotificationCategory.Reminder,
          locked: true,
          fullScreenIntent: true,
          payload: payload,
        ),
        schedule: notificationCalendar,
      );
    } catch (e) {
      print('schedule notification function catch bloc called');
      print(e);
    }
  }

  Future<bool> checkNotificationPermission() async {
  //  bool? notFirstTime = SharedPrefrencesServices().getFirstTimeStore();
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      // if (notFirstTime == null) {
      //   isAllowed =
      //       await AwesomeNotifications().requestPermissionToSendNotifications();
      // //  SharedPrefrencesServices().firstTimeStore();
      // }
      return isAllowed;
    }
    return isAllowed;
  }

  static String getChannelKey(String key) {
    switch (key) {
      case "JOB":
        return "job-alerts";
      case "SERVICE REQUEST":
        return "service-request-alerts";
      default:
        return "alerts";
    }
  }
} 