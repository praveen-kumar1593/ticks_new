import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/attendance_controller.dart';
import '../../shift_details/models/check_in_validation.dart';
import '../../shift_details/utils/shift_validation_helper.dart';



class AttendanceNotificationCalculation {
  int? priorCheckInTime;
  int? missedCheckInTime;
  int? allowedBreak;

  int? priorCheckOutTime;
  int? missedCheckOutTime;
  int? nextDayPriorCheckInTime;
  int? nextDayMissedCheckInTime;

  AttendanceNotificationCalculation({
    this.priorCheckInTime,
    this.missedCheckInTime,
    this.allowedBreak,
    this.priorCheckOutTime,
    this.missedCheckOutTime,
    this.nextDayPriorCheckInTime,
    this.nextDayMissedCheckInTime,
  });

  @override
  String toString() {
    return 'AttendanceNotificationCalculation{priorCheckInTime: $priorCheckInTime, missedCheckInTime: $missedCheckInTime, allowedBreak: $allowedBreak, priorCheckOutTime: $priorCheckOutTime, missedCheckOutTime: $missedCheckOutTime, nextDayPriorCheckInTime: $nextDayPriorCheckInTime, nextDayMissedCheckInTime: $nextDayMissedCheckInTime}';
  }
}

AttendanceNotificationCalculation triggerAttendanceNotificationCalculation(
    {bool isIndividualUser = false, bool isTeamUser = false}) {
  AttendanceNotificationCalculation attendanceNotificationCalculation =
      AttendanceNotificationCalculation();

  var controller;

  if (isIndividualUser) {
    controller = Get.find<AttendanceController>();
  }
  // if (isTeamUser) {
  //   controller = Get.find<AttendanceTeamController>();
  // }

  final shiftDetails = controller.getAssigneeWorkTimeDetailsModel.value?.shift;
  final clientWorkingHour =
      controller.getAssigneeWorkTimeDetailsModel.value?.clientWorkingHour;

  final localNow = DateTime.now();
  final currentDay = localNow.weekday; // 1 for Monday, 7 for Sunday

  // First try to use shift details
  if (shiftDetails != null) {
    final startTime = parseDateTime(shiftDetails.startTime);
    var endTime = parseDateTime(shiftDetails.endTime);
    if (ShiftValidationHelper.getMillisecondsFromTime(shiftDetails.startTime) >
        ShiftValidationHelper.getMillisecondsFromTime(shiftDetails.endTime)) {
      endTime =
          parseDateTime(shiftDetails.endTime).add(const Duration(days: 1));
    }

    attendanceNotificationCalculation.priorCheckInTime = startTime
        .subtract(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.missedCheckInTime = startTime
        .add(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.priorCheckOutTime = endTime
        .subtract(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.missedCheckOutTime = endTime
        .add(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.nextDayPriorCheckInTime = startTime
        .add(const Duration(days: 1))
        .subtract(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.nextDayMissedCheckInTime = startTime
        .add(const Duration(days: 1))
        .add(Duration(milliseconds: shiftDetails.bufferTime ?? 900000))
        .millisecondsSinceEpoch;

    attendanceNotificationCalculation.allowedBreak =
        shiftDetails.allowedBreak ?? 0;
  }
  // If no shift details, fallback to client working hours
  else if (clientWorkingHour != null) {
    // Get start and end time for the current day
    final currentStartEndTime =
        getClientWorkingHoursForDay(currentDay, clientWorkingHour);
    int? startTimeMillis = currentStartEndTime["startTime"];
    int? endTimeMillis = currentStartEndTime["endTime"];

    attendanceNotificationCalculation.allowedBreak =
        clientWorkingHour.allowedBreak ?? 0;

    // Only process if the current day has valid working hours (not null and not 0)
    if (startTimeMillis != null &&
        startTimeMillis > 0 &&
        endTimeMillis != null &&
        endTimeMillis > 0) {
      // Convert milliseconds to DateTime
      final now = DateTime.now();
      final startTime = DateTime.utc(
        now.year,
        now.month,
        now.day,
        0,
        0,
        0,
      ).add(Duration(milliseconds: startTimeMillis));

      var endTime = DateTime.utc(
        now.year,
        now.month,
        now.day,
        0,
        0,
        0,
      ).add(Duration(milliseconds: endTimeMillis));

      // Handle overnight shifts
      if (startTimeMillis > endTimeMillis) {
        endTime = endTime.add(const Duration(days: 1));
      }

      // Calculate notification times
      attendanceNotificationCalculation.priorCheckInTime = startTime
          .subtract(
              Duration(milliseconds: clientWorkingHour.bufferTime ?? 600000))
          .millisecondsSinceEpoch;

      attendanceNotificationCalculation.missedCheckInTime = startTime
          .add(Duration(milliseconds: clientWorkingHour.bufferTime ?? 600000))
          .millisecondsSinceEpoch;

      attendanceNotificationCalculation.priorCheckOutTime = endTime
          .subtract(
              Duration(milliseconds: clientWorkingHour.bufferTime ?? 600000))
          .millisecondsSinceEpoch;

      attendanceNotificationCalculation.missedCheckOutTime = endTime
          .add(Duration(milliseconds: clientWorkingHour.bufferTime ?? 600000))
          .millisecondsSinceEpoch;

      // Get next day's day of week
      final nextDay = getNextDay(
          currentDay: currentDay, clientWorkingHour: clientWorkingHour);

      if (nextDay["nextDay"] != -1) {
        // Only proceed if a valid working day is found
        final nextStartEndTime =
            getClientWorkingHoursForDay(nextDay["nextDay"]!, clientWorkingHour);
        int? nextDayStartTimeMillis = nextStartEndTime["startTime"];
        int? nextDayEndTimeMillis = nextStartEndTime["endTime"];

        // Calculate next day notification times if next day has valid working hours
        if (nextDayStartTimeMillis != null &&
            nextDayStartTimeMillis > 0 &&
            nextDayEndTimeMillis != null &&
            nextDayEndTimeMillis > 0) {
          final nextDayStartTime = DateTime.utc(
            now.year,
            now.month,
            now.day,
            0,
            0,
            0,
          )
              .add(Duration(days: nextDay["daysLooped"]!)) // Add days first
              .add(Duration(
                  milliseconds: nextDayStartTimeMillis)); // Then add time

          int bufferTimeMillis =
              clientWorkingHour.bufferTime ?? 600000; // Default to 10 mins

          attendanceNotificationCalculation.nextDayPriorCheckInTime =
              nextDayStartTime
                  .subtract(Duration(milliseconds: bufferTimeMillis))
                  .millisecondsSinceEpoch;

          attendanceNotificationCalculation.nextDayMissedCheckInTime =
              nextDayStartTime
                  .add(Duration(milliseconds: bufferTimeMillis))
                  .millisecondsSinceEpoch;
        }
      }
    }
  }

  return attendanceNotificationCalculation;
}

Map<String, int?> getNextDay(
    {required int currentDay, required dynamic clientWorkingHour}) {
  for (int i = 1; i <= 7; i++) {
    int nextDay = (currentDay + i) % 7 == 0 ? 7 : (currentDay + i) % 7;
    final nextStartEndTime =
        getClientWorkingHoursForDay(nextDay, clientWorkingHour);

    int? nextDayStartTimeMillis = nextStartEndTime["startTime"];
    int? nextDayEndTimeMillis = nextStartEndTime["endTime"];

    // If the day has working hours, return it
    if (nextDayStartTimeMillis != null && nextDayEndTimeMillis != null) {
      return {"nextDay": nextDay, "daysLooped": i};
    }
  }
  return {"nextDay": -1, "daysLooped": 0};
}

Map<String, int?> getClientWorkingHoursForDay(
    int currentDay, dynamic clientWorkingHour) {
  switch (currentDay) {
    case 1: // Monday
      return {
        "startTime": clientWorkingHour.mondayStartTime,
        "endTime": clientWorkingHour.mondayEndTime
      };
    case 2: // Tuesday
      return {
        "startTime": clientWorkingHour.tuesdayStartTime,
        "endTime": clientWorkingHour.tuesdayEndTime
      };
    case 3: // Wednesday
      return {
        "startTime": clientWorkingHour.wednesdayStartTime,
        "endTime": clientWorkingHour.wednesdayEndTime
      };
    case 4: // Thursday
      return {
        "startTime": clientWorkingHour.thursdayStartTime,
        "endTime": clientWorkingHour.thursdayEndTime
      };
    case 5: // Friday
      return {
        "startTime": clientWorkingHour.fridayStartTime,
        "endTime": clientWorkingHour.fridayEndTime
      };
    case 6: // Saturday
      return {
        "startTime": clientWorkingHour.saturdayStartTime,
        "endTime": clientWorkingHour.saturdayEndTime
      };
    case 7: // Sunday
      return {
        "startTime": clientWorkingHour.sundayStartTime,
        "endTime": clientWorkingHour.sundayEndTime
      };
    default:
      return {"startTime": null, "endTime": null}; // Invalid day case
  }
}
