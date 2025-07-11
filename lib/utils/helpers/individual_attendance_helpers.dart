import 'package:flutter/material.dart';
import '../../controllers/attendance_controller.dart';
import '../../utils/user_status_enum.dart';

class IndividualAttendanceHelpers {
  final AttendanceController controller;

  IndividualAttendanceHelpers(this.controller);

  void openCheckInButton(bool isCheckIn) {
    debugPrint("🔘 openCheckInButton called with isCheckIn: $isCheckIn");
    // This method can be used to control UI state for check-in button
    // For now, we'll just log the action
  }

  UserStatus handleIndividualAttendance(UserStatus status) {
    debugPrint("🎯 handleIndividualAttendance called with status: $status");
    
    // Determine the next status based on current status
    final currentStatus = controller.fetchUserAttendanceStatus.value?.currentStatus;
    
    switch (status) {
      case UserStatus.Online:
        if (currentStatus == null || currentStatus.toUpperCase() == 'OFFLINE') {
          return UserStatus.Online; // Check in
        } else if (currentStatus.toUpperCase() == 'BREAK') {
          return UserStatus.Online; // Resume from break
        }
        break;
      case UserStatus.Offline:
        if (currentStatus?.toUpperCase() == 'ONLINE' || currentStatus?.toUpperCase() == 'BREAK') {
          return UserStatus.Offline; // Check out
        }
        break;
      case UserStatus.Break:
        if (currentStatus?.toUpperCase() == 'ONLINE') {
          return UserStatus.Break; // Start break
        }
        break;
    }
    
    // Return the requested status if no specific logic applies
    return status;
  }

  String? getAttendanceId() {
    // Get attendance ID from current status
    final attendanceId = controller.fetchUserAttendanceStatus.value?.attendanceId;
    debugPrint("🆔 Getting attendance ID: $attendanceId");
    return attendanceId?.toString();
  }

  String? getLatestOngoingBreakId() {
    // Get the latest ongoing break ID
    final breaks = controller.fetchUserAttendanceStatus.value?.attendanceBreak;
    if (breaks != null && breaks.isNotEmpty) {
      // Find the latest break that hasn't ended (endTime is null)
      final ongoingBreak = breaks.lastWhere(
        (break_) => break_.endTime == null,
        orElse: () => breaks.last,
      );
      debugPrint("☕ Getting latest break ID: ${ongoingBreak.breakId}");
      return ongoingBreak.breakId?.toString();
    }
    debugPrint("☕ No breaks found");
    return null;
  }

  // Helper method to check if user can perform a specific action
  bool canPerformAction(UserStatus action) {
    final currentStatus = controller.fetchUserAttendanceStatus.value?.currentStatus;
    
    switch (action) {
      case UserStatus.Online:
        return currentStatus == null || 
               currentStatus.toUpperCase() == 'OFFLINE' ||
               currentStatus.toUpperCase() == 'BREAK';
      case UserStatus.Offline:
        return currentStatus?.toUpperCase() == 'ONLINE' ||
               currentStatus?.toUpperCase() == 'BREAK';
      case UserStatus.Break:
        return currentStatus?.toUpperCase() == 'ONLINE';
    }
  }

  // Helper method to get the next logical status
  UserStatus? getNextLogicalStatus() {
    final currentStatus = controller.fetchUserAttendanceStatus.value?.currentStatus;
    
    if (currentStatus == null || currentStatus.toUpperCase() == 'OFFLINE') {
      return UserStatus.Online; // Check in
    } else if (currentStatus.toUpperCase() == 'ONLINE') {
      return UserStatus.Offline; // Check out
    } else if (currentStatus.toUpperCase() == 'BREAK') {
      return UserStatus.Online; // Resume from break
    }
    
    return null;
  }

} 