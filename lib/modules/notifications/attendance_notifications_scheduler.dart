import 'dart:developer';

import 'package:ticks_new/controllers/attendance_controller.dart';
import 'package:ticks_new/utils/user_status_enum.dart';
import 'package:ticks_new/modules/notifications/helper/attendance_notification_calculation.dart';
import 'package:ticks_new/modules/notifications/attendance_notifications_controller.dart';
import 'package:ticks_new/modules/notifications/notification_manager.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:ticks_new/models/user_data_singleton.dart';

class AttendanceNotificationsScheduler {
  static manageAttendanceNotification(
      {required String currentStatus,
      required String newStatus,
      bool isIndividualUser = true}) {
    if (currentStatus == UserStatus.Offline.name.toUpperCase() &&
        newStatus == UserStatus.Online.name.toUpperCase()) {
      handleUserCheckInActionNotifications(isIndividualUser: isIndividualUser);
    }

    if (currentStatus == UserStatus.Online.name.toUpperCase() &&
        newStatus == UserStatus.Offline.name.toUpperCase()) {
      handleUserCheckOutActionNotifications(isIndividualUser: isIndividualUser);
    }

    if (currentStatus == UserStatus.Online.name.toUpperCase() &&
        newStatus == UserStatus.Break.name.toUpperCase()) {
      scheduleBreakStartNotifications(isIndividualUser: isIndividualUser);
    }

    if (currentStatus == UserStatus.Break.name.toUpperCase() &&
        newStatus == UserStatus.Online.name.toUpperCase()) {
      scheduleBreakEndNotifications(isIndividualUser: isIndividualUser);
    }
  }

  static scheduleBreakStartNotifications({bool isIndividualUser = true}) async {
    // For testing: force allowed break duration to 1 minute (60,000 ms)
    int allowedBreakDuration = 60000; // 1 minute in ms

    if (isIndividualUser) {
      var attendanceIndividualController =
          Get.find<AttendanceController>();

      log("user times ---- >> TESTING 1 MIN BREAK");

      allowedBreakDuration -=
          attendanceIndividualController.totalBreakDurationObs.value;

      log("allowed break time ---- >>> $allowedBreakDuration");
    }

    if (allowedBreakDuration > 0) {
      int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      int breakEndTime = currentTime + allowedBreakDuration;
      int warningTime = breakEndTime - (30 * 1000); // 30 seconds before break ends

      log("Break end time: \\${DateTime.fromMillisecondsSinceEpoch(breakEndTime)} ---- breakEndTime time  --- $breakEndTime ---- breakEndTime remainder -- \\${breakEndTime.remainder(100000)}");
      log("Break warning time: \\${DateTime.fromMillisecondsSinceEpoch(warningTime)} ---- warning time  --- $warningTime ---- warning remainder -- \\${warningTime.remainder(100000)}");

      // Warning notification 30 seconds before break ends, with voice
      await NotificationManager().scheduleNotification(
        id: warningTime.remainder(100000) + 1,
        title: "Break Almost Over!",
        body:
            "Hey \\${UserDataSingleton().displayName.isNotEmpty ? UserDataSingleton().displayName : 'User'}, you have 30 seconds left in your break. Wrap it up!",
        scheduledDate: DateTime.fromMillisecondsSinceEpoch(warningTime),
        channel: AttendanceNotificationController.breakExceedReminderChannelKey,
        shouldAnnounce: true, // Voice
      );

      // Break exceeded notification, with voice
      await NotificationManager().scheduleNotification(
        id: breakEndTime.remainder(100000) + 2,
        title: "Break Time Over!",
        body:
            "Hey \\${UserDataSingleton().displayName.isNotEmpty ? UserDataSingleton().displayName : 'User'}, your allowed break time is up. Get back to work!",
        scheduledDate: DateTime.fromMillisecondsSinceEpoch(breakEndTime),
        channel: AttendanceNotificationController.breakExceedChannelKey,
        shouldAnnounce: true, // Voice
      );
    }
  }

  static scheduleBreakEndNotifications({bool isIndividualUser = true}) async {
    var userTimes = triggerAttendanceNotificationCalculation(
        isIndividualUser: isIndividualUser, isTeamUser: !isIndividualUser);

    await NotificationManager().cancelNotificationsInChannel(
        AttendanceNotificationController.breakExceedChannelKey);

    await NotificationManager().cancelNotificationsInChannel(
        AttendanceNotificationController.breakExceedReminderChannelKey);
  }

  static scheduleBeforeCheckinNotification({required int scheduledTime}) async {
    await NotificationManager().scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(1000),
      title: "Test Notification",
      body: "Test notification so ignore it.",
      scheduledDate: DateTime.now(),
      channel: AttendanceNotificationController.beforeCheckInChannelKey,
    );
  }

  // here have to compare the ideal checkin button and then cancel the missed attendance notification and then have to schedule 2 notifications for the check out
  static handleUserCheckInActionNotifications(
      {bool isIndividualUser = true}) async {
    var userTimes = triggerAttendanceNotificationCalculation(
        isIndividualUser: isIndividualUser, isTeamUser: !isIndividualUser);

    int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;

    log("here im in this 22 ---- userTimes ==== > $userTimes --- current time --- $currentTime");

    // cancellation of missedcheckin Attendance notification if  missedcheckin time greater
    if (userTimes.missedCheckInTime != null) {
      if (userTimes.missedCheckInTime! >= currentTime) {
        await NotificationManager().cancelNotificationsInChannel(
            AttendanceNotificationController.missedCheckInChannelKey);
      }
    }

    // have to schedule the check out 2 notifications
    if (userTimes.priorCheckOutTime != null &&
        userTimes.missedCheckOutTime != null) {
      print(
          "converted current time to date ===== >>> \\${DateTime.fromMillisecondsSinceEpoch(userTimes.priorCheckOutTime!)} ");

      await NotificationManager().scheduleNotification(
        id: 33,
        title: "Wrap Up! Your Shift is Ending Soon.",
        body:
            "Hey \\${UserDataSingleton().displayName.isNotEmpty ? UserDataSingleton().displayName : 'User'}, your shift is almost over! Wrap up your work and don't forget to check out on time",
        scheduledDate:
            DateTime.fromMillisecondsSinceEpoch(userTimes.priorCheckOutTime!),
        channel: AttendanceNotificationController.beforeCheckOutChannelKey,
      );

      await NotificationManager().scheduleNotification(
        id: 44,
        title: "Did You Forget to Check Out?",
        body:
            "Hey \\${UserDataSingleton().displayName.isNotEmpty ? UserDataSingleton().displayName : 'User'}, your shift has ended, but we didn't receive your checkout. Please mark it now to ensure accurate work hours!",
        scheduledDate:
            DateTime.fromMillisecondsSinceEpoch(userTimes.missedCheckOutTime!),
        channel: AttendanceNotificationController.missedCheckOutChannelKey,
      );
    }
  }

  void checkScheduledNotifications() async {
    List scheduledNotifications =
        await AwesomeNotifications().listScheduledNotifications();

    for (var notification in scheduledNotifications) {
      print("ID: \\${notification.content?.id}");
      print("Title: \\${notification.content?.title}");
      print("Body: \\${notification.content?.body}");
      print("Scheduled Time: \\${notification.schedule?.toMap()}");
    }
  }

  // here have to compare the ideal checkin button and then cancel the missed attendance notification and then have to schedule 2 notifications for the next checkin
  static handleUserCheckOutActionNotifications(
      {bool isIndividualUser = true}) async {
    var userTimes = triggerAttendanceNotificationCalculation(
        isIndividualUser: isIndividualUser, isTeamUser: !isIndividualUser);

    int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;

    // cancellation of missed checkout Attendance notification if  missedcheckout time greater
    if (userTimes.missedCheckOutTime != null) {
      if (userTimes.missedCheckOutTime! >= currentTime) {
        await NotificationManager().cancelNotificationsInChannel(
            AttendanceNotificationController.missedCheckOutChannelKey);
      }
    }

    if (userTimes.priorCheckOutTime != null) {
      if (userTimes.priorCheckOutTime! >= currentTime) {
        await NotificationManager().cancelNotificationsInChannel(
          AttendanceNotificationController.beforeCheckOutChannelKey,
        );
      }
    }

    if (userTimes.nextDayPriorCheckInTime != null &&
        userTimes.nextDayMissedCheckInTime != null) {
      print(
          "converted current time to date ===== >>> \\${DateTime.fromMillisecondsSinceEpoch(userTimes.nextDayPriorCheckInTime!)} ");

      await NotificationManager().scheduleNotification(
        id: 55,
        title: "Your Shift is About to Start!",
        body:
            " Hey \\${UserDataSingleton().displayName.isNotEmpty ? UserDataSingleton().displayName : 'User'}, your shift will start soon. Don't forget to check in on time and have a great day at work!",
        scheduledDate: DateTime.fromMillisecondsSinceEpoch(
            userTimes.nextDayPriorCheckInTime!),
        channel: AttendanceNotificationController.beforeCheckInChannelKey,
      );

      await NotificationManager().scheduleNotification(
        id: 66,
        title: "Attendance Alert: Action Needed",
        body:
            "Oops! It looks like you haven't marked your attendance yet. If you're running late, check in now to avoid penalties.",
        scheduledDate: DateTime.fromMillisecondsSinceEpoch(
            userTimes.nextDayMissedCheckInTime!),
        channel: AttendanceNotificationController.missedCheckInChannelKey,
      );
    }
  }
}
