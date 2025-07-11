class AttendanceNotificationCalculation {
  final int? missedCheckOutTime;
  final int? missedCheckInTime;
  final int? breakReminderTime;

  AttendanceNotificationCalculation({
    this.missedCheckOutTime,
    this.missedCheckInTime,
    this.breakReminderTime,
  });
}

AttendanceNotificationCalculation triggerAttendanceNotificationCalculation({
  required bool isIndividualUser,
  required bool isTeamUser,
}) {
  final now = DateTime.now();
  
  // Calculate missed checkout time (8 hours from now)
  final missedCheckOutTime = now.add(const Duration(hours: 8)).millisecondsSinceEpoch;
  
  // Calculate missed check-in time (30 minutes from now)
  final missedCheckInTime = now.add(const Duration(minutes: 30)).millisecondsSinceEpoch;
  
  // Calculate break reminder time (1 hour from now)
  final breakReminderTime = now.add(const Duration(hours: 1)).millisecondsSinceEpoch;

  return AttendanceNotificationCalculation(
    missedCheckOutTime: missedCheckOutTime,
    missedCheckInTime: missedCheckInTime,
    breakReminderTime: breakReminderTime,
  );
} 