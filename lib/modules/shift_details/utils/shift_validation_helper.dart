import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../models/check_in_validation.dart';
import '../models/shift_model.dart';
import '../models/client_working_hour_model.dart';

class ShiftValidationHelper {
  static const String _tag = 'ShiftValidationHelper';

  /// Main validation method for check-in button
  static CheckInValidation openCheckInButton({
    required bool isIndividualUser,
    bool isTeamUser = false,
    List<int?>? selectedMembersId,
    required Shift? shiftDetails,
    required ClientWorkingHour? workingHours,
    required int lastCheckOutTime,
    required List<dynamic>? teamMembers, // For team validation
  }) {
    CheckInValidation checkInValidation = CheckInValidation();
    
    debugPrint('$_tag: Validating check-in for individual: $isIndividualUser, team: $isTeamUser');

    // Get current time
    final localNow = DateTime.now();
    debugPrint('CHECK-IN DEBUG: Current time: $localNow');

    // Check shift-specific timing first
    if (shiftDetails != null) {
      debugPrint('CHECK-IN DEBUG: Shift start: ${shiftDetails.startTime}, end: ${shiftDetails.endTime}, buffer: ${shiftDetails.bufferTime}');
      debugPrint('$_tag: Using shift-based validation');
      return _validateShiftTime(
        shiftDetails: shiftDetails,
        localNow: localNow,
        lastCheckOutTime: lastCheckOutTime,
        isIndividualUser: isIndividualUser,
        isTeamUser: isTeamUser,
        selectedMembersId: selectedMembersId,
        teamMembers: teamMembers,
      );
    }

    // Fallback to client working hours
    if (workingHours != null) {

      debugPrint('$_tag: Using client working hours validation');
      return _validateClientWorkingHours(
        workingHours: workingHours,
        localNow: localNow,
        lastCheckOutTime: lastCheckOutTime,
        isIndividualUser: isIndividualUser,
        isTeamUser: isTeamUser,
        selectedMembersId: selectedMembersId,
        teamMembers: teamMembers,
      );
    }

    debugPrint('$_tag: No shift or working hours data available');
    return checkInValidation;
  }

  /// Validate based on shift timing
  static CheckInValidation _validateShiftTime({
    required Shift shiftDetails,
    required DateTime localNow,
    required int lastCheckOutTime,
    required bool isIndividualUser,
    required bool isTeamUser,
    List<int?>? selectedMembersId,
    List<dynamic>? teamMembers,
  }) {
    CheckInValidation checkInValidation = CheckInValidation();

    // Parse start and end times
    debugPrint('CHECK-IN DEBUG: Raw shift start (UTC): [33m${shiftDetails.startTime}[0m, Raw shift end (UTC): [33m${shiftDetails.endTime}[0m');
    final startTime = _parseDateTime(shiftDetails.startTime ?? '');
    DateTime endTime;
    
    if (getMillisecondsFromTime(shiftDetails.startTime ?? '') >
        getMillisecondsFromTime(shiftDetails.endTime ?? '')) {
      endTime = _parseDateTime(shiftDetails.endTime ?? '').add(const Duration(days: 1));
    } else {
      endTime = _parseDateTime(shiftDetails.endTime ?? '');
    }
    debugPrint('CHECK-IN DEBUG: Converted localStart: [32m$startTime[0m, localEnd: [32m$endTime[0m');
    debugPrint('CHECK-IN DEBUG: Device timezone offset: [36m${DateTime.now().timeZoneOffset}[0m');

    if (isIndividualUser) {
      if (_restrictedByShiftTime(
        lastCheckOutTime: lastCheckOutTime,
        now: localNow,
        startTime: startTime,
        endTime: endTime,
        shiftDetails: shiftDetails,
        checkInValidation: checkInValidation,
      )) {
        checkInValidation.isValidTime = true;
        checkInValidation.expectedStartTime = getMillisecondsFromTime(shiftDetails.startTime ?? '');
        checkInValidation.expectedEndTime = getMillisecondsFromTime(shiftDetails.endTime ?? '');
        return checkInValidation;
      }

      checkInValidation.expectedEndTime = getMillisecondsFromTime(shiftDetails.endTime ?? '');
      checkInValidation.expectedStartTime = getMillisecondsFromTime(shiftDetails.startTime ?? '');
      return checkInValidation;
    }

    if (isTeamUser && teamMembers != null) {
      debugPrint('$_tag: Validating team members for shift');
      final List<String> inRestrictedUser = [];
      
      for (var member in teamMembers) {
        final memberId = member['userId'];
        final memberName = member['userName'];
        final memberCheckOutTime = member['checkOutTime'] ?? 0;
        
        debugPrint('$_tag: Validating member $memberName (ID: $memberId)');
        
        if (selectedMembersId != null && selectedMembersId.contains(memberId)) {
          debugPrint('$_tag: Selected member $memberName');
          
          if (_restrictedByShiftTime(
            lastCheckOutTime: memberCheckOutTime,
            now: localNow,
            startTime: startTime,
            endTime: endTime,
            shiftDetails: shiftDetails,
            checkInValidation: checkInValidation,
          )) {
            debugPrint('$_tag: Non-restricted member: $memberName');
          } else {
            inRestrictedUser.add(memberName);
            debugPrint('$_tag: Restricted member: $memberName');
          }
        }
      }
      
      if (inRestrictedUser.isEmpty) {
        checkInValidation.isValidTime = true;
        return checkInValidation;
      } else {
        checkInValidation.inRestrictedUser = inRestrictedUser;
        return checkInValidation;
      }
    }

    return checkInValidation;
  }

  /// Validate based on client working hours
  static CheckInValidation _validateClientWorkingHours({
    required ClientWorkingHour workingHours,
    required DateTime localNow,
    required int lastCheckOutTime,
    required bool isIndividualUser,
    required bool isTeamUser,
    List<int?>? selectedMembersId,
    List<dynamic>? teamMembers,
  }) {
    CheckInValidation checkInValidation = CheckInValidation();

    final today = localNow.weekday; // Monday = 1, Sunday = 7

    final startTimeMillis = workingHours.getStartTimeForDay(today);
    final endTimeMillis = workingHours.getEndTimeForDay(today);

    debugPrint('$_tag: Validating day: $today. Start: $startTimeMillis, End: $endTimeMillis');

    if (startTimeMillis == null || endTimeMillis == null) {
      debugPrint('$_tag: Today is leave day');
      return checkInValidation;
    }

    if (startTimeMillis == 0 && endTimeMillis == 0) {
      debugPrint('$_tag: 24 hours working time for CHECK-IN');
      checkInValidation.is24Hrs = true;
      checkInValidation.isValidTime = true;
      return checkInValidation;
    }

    if (isIndividualUser) {
      final startTime = DateTime.utc(localNow.year, localNow.month, localNow.day)
          .add(Duration(milliseconds: startTimeMillis));
      final endTime = DateTime.utc(localNow.year, localNow.month, localNow.day)
          .add(Duration(milliseconds: endTimeMillis));

      if (_restrictedByClientWorkHours(
        now: localNow,
        startTime: startTime,
        endTime: endTime,
        lastCheckOutTime: lastCheckOutTime,
        workingHours: workingHours,
        checkInValidation: checkInValidation,
      )) {
        checkInValidation.isValidTime = true;
        checkInValidation.expectedStartTime = startTime.millisecondsSinceEpoch;
        checkInValidation.expectedEndTime = endTime.millisecondsSinceEpoch;
        return checkInValidation;
      } else {
        checkInValidation.expectedStartTime = startTime.millisecondsSinceEpoch;
        checkInValidation.expectedEndTime = endTime.millisecondsSinceEpoch;
        return checkInValidation;
      }
    }

    if (isTeamUser && teamMembers != null) {
      debugPrint('$_tag: Validating team members for client working hours');
      final List<String> inRestrictedUser = [];
      
      for (var member in teamMembers) {
        final memberId = member['userId'];
        final memberName = member['userName'];
        final memberCheckOutTime = member['checkOutTime'] ?? 0;
        
        debugPrint('$_tag: Validating member $memberName (ID: $memberId)');
        
        if (selectedMembersId != null && selectedMembersId.contains(memberId)) {
          debugPrint('$_tag: Selected member $memberName');
          
          final startTime = DateTime.utc(localNow.year, localNow.month, localNow.day)
              .add(Duration(milliseconds: startTimeMillis));

          final endTime = (endTimeMillis < startTimeMillis)
              ? DateTime.utc(localNow.year, localNow.month, localNow.day)
                  .add(Duration(milliseconds: endTimeMillis))
                  .add(const Duration(days: 1))
              : DateTime.utc(localNow.year, localNow.month, localNow.day)
                  .add(Duration(milliseconds: endTimeMillis));

          if (_restrictedByClientWorkHours(
            now: localNow,
            startTime: startTime,
            endTime: endTime,
            lastCheckOutTime: memberCheckOutTime,
            workingHours: workingHours,
            checkInValidation: checkInValidation,
          )) {
            debugPrint('$_tag: Non-restricted member: $memberName');
          } else {
            inRestrictedUser.add(memberName);
            debugPrint('$_tag: Restricted member: $memberName');
          }
        }
      }
      
      if (inRestrictedUser.isEmpty) {
        checkInValidation.isValidTime = true;
        return checkInValidation;
      } else {
        checkInValidation.inRestrictedUser = inRestrictedUser;
        return checkInValidation;
      }
    }

    return checkInValidation;
  }

  /// Check if restricted by shift time
  static bool _restrictedByShiftTime({
    required int lastCheckOutTime,
    required DateTime now,
    required DateTime startTime,
    required DateTime endTime,
    required Shift shiftDetails,
    required CheckInValidation checkInValidation,
  }) {
    DateTime convertLastCheckOutTime = DateTime.fromMillisecondsSinceEpoch(lastCheckOutTime).toUtc();
    
    debugPrint('$_tag: Shift validation - Current: $now, Start: $startTime, End: $endTime, LastCheckout: $convertLastCheckOutTime');

    if (_isDateTimeInRange(
      current: now,
      start: startTime,
      end: endTime,
      bufferMilliseconds: shiftDetails.bufferTime ?? 0,
      lastCheckout: convertLastCheckOutTime,
      checkInValidation: checkInValidation,
    )) {
      debugPrint('$_tag: ✅ Valid shift time for CHECK-IN');
      return true;
    }

    debugPrint('$_tag: ❌ Invalid shift time for CHECK-IN');
    return false;
  }

  /// Check if restricted by client working hours
  static bool _restrictedByClientWorkHours({
    required DateTime now,
    required DateTime startTime,
    required DateTime endTime,
    required int lastCheckOutTime,
    required ClientWorkingHour workingHours,
    required CheckInValidation checkInValidation,
  }) {
    DateTime convertLastCheckOutTime = DateTime.fromMillisecondsSinceEpoch(lastCheckOutTime).toUtc();

    debugPrint('$_tag: Client hours validation - Current: $now, Start: $startTime, End: $endTime, LastCheckout: $convertLastCheckOutTime');

    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      if (!(_isDateTimeInRange(
        current: now,
        start: startTime,
        end: endTime,
        bufferMilliseconds: workingHours.bufferTime ?? 0,
        lastCheckout: convertLastCheckOutTime,
        checkInValidation: checkInValidation,
      ))) {
        return false;
      }
      debugPrint('$_tag: ✅ Valid working time for CHECK-IN');
      return true;
    }
    
    debugPrint('$_tag: ❌ Invalid working time for CHECK-IN');
    return false;
  }

  /// Check if date time is in range with buffer
  static bool _isDateTimeInRange({
    required DateTime current,
    required DateTime start,
    required DateTime end,
    required int bufferMilliseconds,
    DateTime? lastCheckout,
    required CheckInValidation checkInValidation,
  }) {
    debugPrint('CHECK-IN DEBUG: Current time: $current');
    debugPrint('CHECK-IN DEBUG: Shift start: $start, end: $end, buffer: $bufferMilliseconds');
    // Handle overnight shift (end time is on the next day)
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
      if (current.isBefore(start)) {
        current = current.add(const Duration(days: 1));
      }
      if (lastCheckout != null && lastCheckout.isBefore(start)) {
        lastCheckout = lastCheckout.add(const Duration(days: 1));
      }
    }
    if (lastCheckout != null && start.isBefore(lastCheckout)) {
      debugPrint('CHECK-IN DEBUG: ❌ Last checkout time is outside the range');
      checkInValidation.isCompeletedAttendance = true;
      return false;
    }
    final inRange = (current.isAfter(start) || current.isAtSameMomentAs(start)) && (current.isBefore(end) || current.isAtSameMomentAs(end));
    debugPrint('CHECK-IN DEBUG: Validation result: $inRange');
    return inRange;
  }

  /// Parse date time from string
  // static DateTime _parseDateTime(String timeStr) {
  //   final now = DateTime.now().toUtc();
  //   final parts = timeStr.split(':');
  //   return DateTime.utc(
  //     now.year,
  //     now.month,
  //     now.day,
  //     int.parse(parts[0]),
  //     int.parse(parts[1]),
  //   );
  // }
  static DateTime _parseDateTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    final dtUtc = DateTime.utc(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      parts.length > 2 ? int.parse(parts[2]) : 0,
    );
    return dtUtc.toLocal();
  }
  /// Get milliseconds from time string
  static int getMillisecondsFromTime(String timeStr) {
    final parts = timeStr.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return (hours * 60 * 60 * 1000) + (minutes * 60 * 1000);
  }
} 