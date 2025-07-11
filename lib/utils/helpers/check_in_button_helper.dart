import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import '../../models/fetch_user_attendance_status.dart';
import '../../utils/user_status_enum.dart';
import '../../modules/shift_details/controllers/shift_details_controller.dart';
import '../../modules/shift_details/models/check_in_validation.dart';

class CheckInValidation {
  bool isValidTime;
  int? expectedEndTime;
  int? expectedStartTime;
  bool is24Hrs;
  bool isCompeletedAttendance;

  CheckInValidation({
    this.isValidTime = false,
    this.expectedEndTime,
    this.expectedStartTime,
    this.is24Hrs = false,
    this.isCompeletedAttendance = false,
  });
}

CheckInValidation openCheckInButton({bool isIndividualUser = false}) {
  CheckInValidation checkInValidation = CheckInValidation();
  var controller;

  int lastCheckOutTime = 0;

  if (isIndividualUser) {
    controller = Get.find<AttendanceController>();
    lastCheckOutTime =
        controller.fetchUserAttendanceStatus.value?.checkOutTime ?? 0;
  }

  // Use the new ShiftDetailsController for validation
  try {
    final shiftController = Get.find<ShiftDetailsController>();
    final shiftValidation = shiftController.validateIndividualCheckIn(
      lastCheckOutTime: lastCheckOutTime,
    );

    // Convert the new validation to the old format for compatibility
    checkInValidation.isValidTime = shiftValidation.isValidTime;
    checkInValidation.expectedStartTime = shiftValidation.expectedStartTime;
    checkInValidation.expectedEndTime = shiftValidation.expectedEndTime;
    checkInValidation.is24Hrs = shiftValidation.is24Hrs;
    checkInValidation.isCompeletedAttendance = shiftValidation.isCompeletedAttendance;

    debugPrint('🔍 Shift validation result: ${shiftValidation.toJson()}');
  } catch (e) {
    debugPrint('⚠️ Error using ShiftDetailsController, falling back to old logic: $e');
    
    // Fallback to old logic if shift controller is not available
    final status = controller.fetchUserAttendanceStatus.value;
    checkInValidation.expectedStartTime = status?.expectedCheckInTime;
    checkInValidation.expectedEndTime = status?.expectedCheckOutTime;
    checkInValidation.is24Hrs = false;
    checkInValidation.isValidTime = true;
    checkInValidation.isCompeletedAttendance = status?.checkOutTime != null;
  }

  return checkInValidation;
}

// Enhanced action button helper from awesometicks
class ActionButtonHelper {
  static bool canCheckIn(AttendanceController controller) {
    final currentStatus = controller.currentUserStatus.value;
    final validation = openCheckInButton(isIndividualUser: true);
    
    // Can check in if offline and within valid time or 24hr shift
    return (currentStatus == UserStatus.Offline || currentStatus == null) &&
           (validation.isValidTime || validation.is24Hrs);
  }

  static bool canCheckOut(AttendanceController controller) {
    final currentStatus = controller.currentUserStatus.value;
    return currentStatus == UserStatus.Online;
  }

  static bool canTakeBreak(AttendanceController controller) {
    final currentStatus = controller.currentUserStatus.value;
    final attendance = controller.fetchUserAttendanceStatus.value;
    
    // Can take break if online and has remaining break time
    if (currentStatus != UserStatus.Online) return false;
    
    final totalBreakDuration = controller.totalBreakDurationObs.value;
    final allowedBreak = attendance?.allowedBreak ?? 0;
    
    return allowedBreak > totalBreakDuration;
  }

  static bool canEndBreak(AttendanceController controller) {
    final currentStatus = controller.currentUserStatus.value;
    return currentStatus == UserStatus.Break;
  }

  static String getActionButtonColor(String buttonStatus) {
    switch (buttonStatus) {
      case 'ONLINE':
        return 'green';
      case 'OFFLINE':
        return 'red';
      case 'BREAK':
        return 'orange';
      default:
        return 'green';
    }
  }

  static String getStatusMessage(UserStatus status, AttendanceController controller) {
    final validation = openCheckInButton(isIndividualUser: true);
    
    switch (status) {
      case UserStatus.Offline:
        if (validation.isCompeletedAttendance) {
          return "Great job! You've completed your shift for today.";
        } else if (validation.is24Hrs) {
          return "Time to check in and begin your shift. \nLet's go!.";
        } else if (validation.isValidTime) {
          return "Please check in to start your shift.";
        } else {
          return "Oops! Your work shift hasn't started yet.\nPlease check in at the correct time.";
        }
      case UserStatus.Break:
        final duration = Duration(milliseconds: controller.currentBreakDurationObs.value);
        final minutes = duration.inMinutes.remainder(60);
        final seconds = duration.inSeconds.remainder(60);
        return 'Enjoy your break! Break time: ${minutes}m ${seconds}s.';
      case UserStatus.Online:
        return 'You are on duty! Keep up the great work.';
      default:
        return '';
    }
  }

  static IconData getStatusIcon(UserStatus status) {
    switch (status) {
      case UserStatus.Offline:
        return Icons.info_outline_rounded;
      case UserStatus.Break:
        return Icons.pause_circle_outline;
      case UserStatus.Online:
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline_rounded;
    }
  }

  static Color getStatusColor(UserStatus status, AttendanceController controller) {
    final validation = openCheckInButton(isIndividualUser: true);
    
    switch (status) {
      case UserStatus.Offline:
        return validation.isValidTime ? Colors.blue : Colors.red;
      case UserStatus.Break:
        return Colors.orange;
      case UserStatus.Online:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
} 