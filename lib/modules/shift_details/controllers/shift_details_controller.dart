import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/client_working_hour_model.dart';
import '../models/get_assignee_work_time_details_model.dart';
import '../models/check_in_validation.dart';
import '../models/shift_model.dart';
import '../services/shift_details_service.dart';
import '../utils/shift_validation_helper.dart';

class ShiftDetailsController extends GetxController {
  static const String _tag = 'ShiftDetailsController';

  // Services
  final ShiftDetailsService _shiftDetailsService = ShiftDetailsService();

  // Observables
  final Rx<GetAssigneeWorkTimeDetailsModel?> shiftDetails = Rx<GetAssigneeWorkTimeDetailsModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<CheckInValidation?> lastValidation = Rx<CheckInValidation?>(null);

  // Getters
  GetAssigneeWorkTimeDetailsModel? get getShiftDetails => shiftDetails.value;
  Shift? get shift => shiftDetails.value?.shift;
  ClientWorkingHour? get clientWorkingHour => shiftDetails.value?.clientWorkingHour;
  bool get hasShiftData => shiftDetails.value != null;
  bool get hasShift => shift != null;
  bool get hasClientWorkingHour => clientWorkingHour != null;

  @override
  void onInit() {
    super.onInit();
    debugPrint('$_tag: Initializing ShiftDetailsController');
    fetchShiftDetails();
  }

  @override
  void onClose() {
    debugPrint('$_tag: Disposing ShiftDetailsController');
    super.onClose();
  }

  /// Fetch shift details from network or cache
  Future<void> fetchShiftDetails({bool forceRefresh = false}) async {
    try {
      debugPrint('$_tag: Fetching shift details (forceRefresh: $forceRefresh)');
      
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final data = await _shiftDetailsService.getShiftDetails(forceRefresh: forceRefresh);
      
      if (data != null) {
        shiftDetails.value = data;
        debugPrint('$_tag: Shift details loaded successfully');
        debugPrint('$_tag: Has shift: ${hasShift}');
        debugPrint('$_tag: Has client working hour: ${hasClientWorkingHour}');
      } else {
        hasError.value = true;
        errorMessage.value = 'Failed to load shift details';
        debugPrint('$_tag: Failed to load shift details');
      }

    } catch (e, stackTrace) {
      debugPrint('$_tag: Error fetching shift details: $e');
      debugPrint('$_tag: Stack trace: $stackTrace');
      
      hasError.value = true;
      errorMessage.value = 'Error loading shift details: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate check-in for individual user
  CheckInValidation validateIndividualCheckIn({required int lastCheckOutTime}) {
    debugPrint('$_tag: Validating individual check-in');
    
    final validation = ShiftValidationHelper.openCheckInButton(
      isIndividualUser: true,
      shiftDetails: shift,
      workingHours: clientWorkingHour,
      lastCheckOutTime: lastCheckOutTime,
      teamMembers: null,
    );

   // lastValidation.value = validation;
    
    debugPrint('$_tag: Individual validation result: ${validation.toJson()}');
    return validation;
  }

  /// Validate check-in for team users
  CheckInValidation validateTeamCheckIn({
    required List<int?> selectedMembersId,
    required List<dynamic> teamMembers,
  }) {
    debugPrint('$_tag: Validating team check-in for ${selectedMembersId.length} members');
    
    final validation = ShiftValidationHelper.openCheckInButton(
      isIndividualUser: false,
      isTeamUser: true,
      selectedMembersId: selectedMembersId,
      shiftDetails: shift,
      workingHours: clientWorkingHour,
      lastCheckOutTime: 0, // Not used for team validation
      teamMembers: teamMembers,
    );

    lastValidation.value = validation;
    
    debugPrint('$_tag: Team validation result: ${validation.toJson()}');
    return validation;
  }

  /// Check if individual user can check in
  bool canIndividualCheckIn({required int lastCheckOutTime}) {
    final validation = validateIndividualCheckIn(lastCheckOutTime: lastCheckOutTime);
    return validation.isValidTime;
  }

  /// Check if team can check in
  bool canTeamCheckIn({
    required List<int?> selectedMembersId,
    required List<dynamic> teamMembers,
  }) {
    final validation = validateTeamCheckIn(
      selectedMembersId: selectedMembersId,
      teamMembers: teamMembers,
    );
    return validation.isValidTime;
  }

  /// Get shift information for display
  Map<String, dynamic> getShiftInfo() {
    if (!hasShiftData) {
      return {
        'hasData': false,
        'message': 'No shift data available',
      };
    }

    if (hasShift) {
      return {
        'hasData': true,
        'type': 'shift',
        'name': shift?.name ?? 'Unknown Shift',
        'startTime': shift?.startTime ?? 'N/A',
        'endTime': shift?.endTime ?? 'N/A',
        'bufferTime': shift?.bufferTime ?? 0,
        'allowedBreak': shift?.allowedBreak ?? 0,
        'description': shift?.description ?? '',
      };
    }
    debugPrint('ShiftInfo: ${shift?.toJson()}');

    if (hasClientWorkingHour) {
      return {
        'hasData': true,
        'type': 'client_working_hour',
        'name': clientWorkingHour?.name ?? 'Client Working Hours',
        'bufferTime': clientWorkingHour?.bufferTime ?? 0,
        'allowedBreak': clientWorkingHour?.allowedBreak ?? 0,
      };
    }

    return {
      'hasData': false,
      'message': 'No valid shift or working hour data',
    };
  }

  /// Get current day's working hours
  Map<String, dynamic> getCurrentDayWorkingHours() {
    if (!hasClientWorkingHour) {
      return {
        'hasData': false,
        'message': 'No client working hour data',
      };
    }

    final now = DateTime.now();
    final today = now.weekday; // Monday = 1, Sunday = 7

    final startTimeMillis = clientWorkingHour!.getStartTimeForDay(today);
    final endTimeMillis = clientWorkingHour!.getEndTimeForDay(today);

    if (startTimeMillis == null || endTimeMillis == null) {
      return {
        'hasData': false,
        'message': 'Today is a leave day',
      };
    }

    if (startTimeMillis == 0 && endTimeMillis == 0) {
      return {
        'hasData': true,
        'type': '24_hours',
        'message': '24 hours working time',
      };
    }

    // Convert milliseconds to time strings
    final startTime = _millisecondsToTimeString(startTimeMillis);
    final endTime = _millisecondsToTimeString(endTimeMillis);

    return {
      'hasData': true,
      'type': 'regular',
      'startTime': startTime,
      'endTime': endTime,
      'startTimeMillis': startTimeMillis,
      'endTimeMillis': endTimeMillis,
    };
  }

  /// Clear shift details (for logout)
  void clearShiftDetails() {
    shiftDetails.value = null;
    lastValidation.value = null;
    hasError.value = false;
    errorMessage.value = '';
    debugPrint('$_tag: Shift details cleared');
  }

  /// Clear cache
  Future<void> clearCache() async {
    await _shiftDetailsService.clearCache();
    debugPrint('$_tag: Cache cleared');
  }

  /// Get cache status
  Future<Map<String, dynamic>> getCacheStatus() async {
    return await _shiftDetailsService.getCacheStatus();
  }

  /// Convert milliseconds to time string (HH:mm)
  String _millisecondsToTimeString(int milliseconds) {
    final hours = (milliseconds / (1000 * 60 * 60)).floor();
    final minutes = ((milliseconds % (1000 * 60 * 60)) / (1000 * 60)).floor();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Refresh shift details
  Future<void> refresh() async {
    await fetchShiftDetails(forceRefresh: true);
  }

  /// Get validation summary
  String getValidationSummary() {
    final validation = lastValidation.value;
    if (validation == null) {
      return 'No validation performed';
    }

    if (validation.isValidTime) {
      return '✅ Valid time for check-in';
    }

    if (validation.is24Hrs) {
      return '✅ 24-hour shift - always valid';
    }

    if (validation.isCompeletedAttendance) {
      return '❌ Attendance already completed for today';
    }

    if (validation.inRestrictedUser != null && validation.inRestrictedUser!.isNotEmpty) {
      return '❌ Restricted users: ${validation.inRestrictedUser!.join(', ')}';
    }

    return '❌ Invalid time for check-in';
  }
} 