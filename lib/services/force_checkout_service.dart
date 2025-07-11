import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';
import 'api_services.dart';
import 'dart:async';
import '../modules/shift_details/controllers/shift_details_controller.dart';

class ForceCheckoutService extends GetxService {
  Timer? _forceCheckoutTimer;
  bool _forceCheckoutEnabled = false;
  String? _forceCheckoutTime; // e.g., "18:00"

  /// Call this to initialize force checkout monitoring after login/session ready
  Future<void> initialize({required String domain, required String name, required BuildContext context}) async {
    print('[ForceCheckoutService] Initializing force checkout check...');
    final themeData = await Get.find<ApiServices>().fetchAppThemeDirect(domain: domain, name: name);
    if (themeData == null) {
      print('[ForceCheckoutService] No theme data found. Skipping force checkout setup.');
      return;
    }
    // Example: Check for force checkout flag in theme data
    final attendanceConfig = themeData['ATTENDANCE_CONFIGURATION'];
    if (attendanceConfig != null) {
      _forceCheckoutEnabled = attendanceConfig['FORCE_CHECKOUT'] == true;
      print('[ForceCheckoutService] FORCE_CHECKOUT: $_forceCheckoutEnabled');
      if (_forceCheckoutEnabled) {
        // Fetch shift end time from user's shift info
        final shiftInfo = Get.find<ShiftDetailsController>().getShiftInfo();
        final endTimeUtc = shiftInfo['endTime']; // e.g., "18:00" or UTC string
        if (endTimeUtc != null) {
          final localEnd = convertUtcToLocalTime(context, endTimeUtc); // returns DateTime
          final forceCheckoutTime = TimeOfDay(hour: localEnd.hour, minute: localEnd.minute);
          print('[ForceCheckoutService] Using user shift end time (local): ${forceCheckoutTime.format(context)}');
          _startForceCheckoutMonitor(forceCheckoutTime);
        } else {
          print('[ForceCheckoutService] No endTime found in shiftInfo.');
        }
      }
    } else {
      print('[ForceCheckoutService] ATTENDANCE_CONFIGURATION not found in theme data.');
    }
  }

  void _startForceCheckoutMonitor(TimeOfDay forceCheckoutTime) {
    print('[ForceCheckoutService] Starting force checkout monitor for ${forceCheckoutTime.hour}:${forceCheckoutTime.minute} (+15 min grace)');
    _forceCheckoutTimer?.cancel();
    _forceCheckoutTimer = Timer.periodic(Duration(minutes: 1), (_) {
      final now = TimeOfDay.now();
      final forceTimeWithGrace = _addMinutes(forceCheckoutTime, 15);
      if (_isAfter(now, forceTimeWithGrace)) {
        print('[ForceCheckoutService] Time is after force checkout time + 15 min. Triggering force checkout.');
        triggerForceCheckout();
        _forceCheckoutTimer?.cancel();
      }
    });
  }

  bool _isAfter(TimeOfDay now, TimeOfDay target) {
    return now.hour > target.hour || (now.hour == target.hour && now.minute >= target.minute);
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutesToAdd) {
    final totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    final newHour = (totalMinutes ~/ 60) % 24;
    final newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  void triggerForceCheckout() {
    print('[ForceCheckoutService] Forcing user checkout due to theme policy!');
    Get.find<AttendanceController>().forceCheckoutUser();
  }

  @override
  void onClose() {
    _forceCheckoutTimer?.cancel();
    super.onClose();
  }
}

/// Helper to convert UTC time string to local DateTime
DateTime convertUtcToLocalTime(BuildContext context, String utcTime) {
  // If utcTime is just "HH:mm", treat as today in UTC
  if (utcTime.length == 5 && utcTime.contains(':')) {
    final now = DateTime.now().toUtc();
    final parts = utcTime.split(':');
    final dt = DateTime.utc(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    return dt.toLocal();
  }
  // If utcTime is a full ISO string, parse and convert
  final dt = DateTime.parse(utcTime).toLocal();
  return dt;
} 