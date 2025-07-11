import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../graphql/__generated__/fetchUserAttendanceStatus.data.gql.dart';
import '../graphql/__generated__/fetchUserAttendanceStatus.req.gql.dart';
import '../models/fetch_user_attendance_status.dart';
import '../models/geofence_location.dart';
import '../models/user_data_singleton.dart';
import '../modules/geofence/canusercheckin_screen.dart';
import '../modules/geofence/geofence_new_service.dart';
import '../modules/notifications/attendance_notifications_controller.dart';
import '../modules/notifications/notification_manager.dart';
import '../services/attendance_location_service.dart';
import '../services/geofence_service.dart';
import '../services/shared_preferences_services.dart';
import '../services/mqtt_publish_method.dart';
import '../services/individual_attendance_service.dart';
import '../services/notifications_scheduler.dart';
import '../services/background_location_service.dart';
import '../utils/constants.dart';
import '../utils/extensions/user_status_extension.dart';
import '../utils/helpers/geofence_finder.dart';
import '../utils/helpers/individual_attendance_helpers.dart';
import '../utils/helpers/attendance_notification_calculation.dart';
import '../utils/helpers/common_snackbar.dart';
import '../utils/user_status_enum.dart';
import '../services/graphql_client_services.dart';
import '../modules/shift_details/controllers/shift_details_controller.dart';
import '../services/storage_services.dart';
import 'auth_controller.dart';
import '../services/api_services.dart';
import 'package:ticks_new/modules/geofence/geofence_service.dart';
import '../modules/firebase/notification_service.dart';
import 'package:ticks_new/modules/notifications/attendance_notifications_scheduler.dart' hide AttendanceNotificationsScheduler;


class AttendanceController extends GetxController {
  final AuthController _authController = Get.put(AuthController());
  final GraphQLClientService _apiClient = Get.find<GraphQLClientService>();
  final GeofenceService geoFenceServices = Get.find<GeofenceService>();
  final SharedPrefrencesServices _preferencesServices = Get.find<SharedPrefrencesServices>();
  final IndividualAttendanceService _individualAttendanceService = IndividualAttendanceService();
  final ApiServices _apiServices = Get.find<ApiServices>();
  late final IndividualAttendanceHelpers _individualAttendanceHelpers;
  final GeofenceNewService geofenceService = Get.find<GeofenceNewService>();

  // Observable variables
  final Rx<FetchUserAttendanceStatus?> fetchUserAttendanceStatus =
      Rx<FetchUserAttendanceStatus?>(null);
  final RxBool isMarkAttendanceLoading = false.obs;
  final RxBool isFetchingStatus = false.obs;
  final RxBool isOnline = false.obs;
  final RxBool isOffline = false.obs;
  final RxBool isBreak = false.obs;
  final RxBool isForceCheckOut = false.obs;
  final RxBool isOfflineSync = false.obs;
  final RxBool isLocationEnabled = false.obs;
  final RxBool isGeofenceEnabled = false.obs;
  final RxBool isNotificationEnabled = false.obs;
  final RxBool isConnectivityAvailable = true.obs;

  // Additional properties for compatibility
  final RxBool isInGeofence = false.obs;
  final RxString currentGeofenceName = ''.obs;
  final RxBool isLoading = true.obs;
  final Rx<UserStatus> currentUserStatus = UserStatus.Offline.obs;
  final Rx<int> totalWorkDuration = 0.obs;
  final Rx<int> totalBreakDurationObs = 0.obs;
  final Rx<int> numberOfBreaksObs = 0.obs;
  final Rx<int> currentBreakDurationObs = 0.obs;
  final RxList attendanceLog = <dynamic>[].obs;
  Timer? _workDurationTimer;
  Timer? _currentBreakTimer;

  // Work time details
  final Rx<Map<String, dynamic>?> workTimeDetails = Rx<Map<String, dynamic>?>(null);

  // Connectivity stream
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  StreamSubscription<Position>? _positionStreamSubscription;

  final RxString errorMessage = ''.obs;

  // Enhanced UI state management (from awesometicks)
  RxBool openConfirmationUI = false.obs;
  RxString confirmationMessage = "".obs;
  RxString whichActionButton = "".obs;

  String get currentDate => DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

  // Helper methods for compatibility
  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  bool canMarkAttendance() {
    return isLocationEnabled.value && isGeofenceEnabled.value;
  }
  final geofenceServices = Get.find<GeofenceNewService>();
  String? assignedGeofenceId;

// Try to get from user/session/assignee model if you have it
// For example, if you store the findAssignee response in GeofenceNewService:

  @override
 Future <void> onInit() async {
    super.onInit();
    _individualAttendanceHelpers = IndividualAttendanceHelpers(this);

    // Listen to authentication status changes
    ever(_authController.isAuthenticated, (bool isAuthenticated) {
      if (isAuthenticated) {
        print("✅ Auth state confirmed in AttendanceController. Initializing services...");
        _initializeServices();
      } else {
        print("❌ Auth state lost in AttendanceController. Clearing data...");
        // Optionally, clear attendance data if the user logs out
        clearAttendanceData();
      }
    });

    // Initial check in case the controller is initialized after the user is already authenticated
    if (_authController.isAuthenticated.value) {
       print("✅ AttendanceController initialized, user is already authenticated. Initializing services...");
      _initializeServices();
    }

    _startConnectivityMonitoring();

    print('[AttendanceController] onInit called');
    final userDomain = UserDataSingleton().domain;
    print('[AttendanceController] userDomain: $userDomain');
   // if (userDomain != null && userDomain.isNotEmpty) {
      print('[AttendanceController] About to call fetchGeofencesFromApi');
      await geofenceService.fetchGeofencesDirectHttp(domain:"buildingdemo");
   // }
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    _positionStreamSubscription?.cancel();
    _workDurationTimer?.cancel();
    _currentBreakTimer?.cancel();
    super.onClose();
  }

  Future<void> _initializeServices() async {
    try {
      // Wait for SharedPreferencesServices to be initialized
      final sharedPrefs = Get.find<SharedPrefrencesServices>();
      await sharedPrefs.init();

      await _initializeLocationServices();
      await _initializeGeofenceServices();
      await _initializeNotificationServices();
      await getCombinedCurrentIndividualStatus();
      _startBackgroundServices();
      _startLocationMonitoring(); // Start monitoring location
    } catch (e) {
      debugPrint('Error initializing attendance services: $e');
    }
  }

  Future<void> _initializeLocationServices() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showSnackBar('Location services are disabled', type: 'error');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showSnackBar('Location permissions are denied', type: 'error');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showSnackBar('Location permissions are permanently denied', type: 'error');
        return;
      }

      isLocationEnabled.value = true;
      debugPrint('Location services initialized successfully');
    } catch (e) {
      debugPrint('Error initializing location services: $e');
    }
  }

  Future<void> _initializeGeofenceServices() async {
    try {
      geoFenceServices.setAllGeofenceData({
        'data': [
          {
            'id': '1',
            'name': 'Office Location',
            'latitude': 12.9716,
            'longitude': 77.5946,
            'radius': 100.0,
          }
        ]
      });

      isGeofenceEnabled.value = true;
      
      // Save geofence data to background service storage
      await saveGeofenceDataToBackground();
      
      debugPrint('Geofence services initialized successfully');
    } catch (e) {
      debugPrint('Error initializing geofence services: $e');
    }
  }

  Future<void> _initializeNotificationServices() async {
    try {
      isNotificationEnabled.value = true;
      debugPrint('Notification services initialized successfully');
    } catch (e) {
      debugPrint('Error initializing notification services: $e');
    }
  }
// ... existing code ...
  // Make announceNotification public for use in notification handlers
  // Future<void> announceNotification(String title, String body) async {
  //   try {
  //     String announcement = "$title. $body";
  //     await flutterTts.speak(announcement);
  //   } catch (e) {
  //     print("TTS Error: $e");
  //   }
  // }
  //
  // // Set up notification action handler to trigger TTS when notification is received or tapped
  // static Future<void> setupNotificationTTSHandler() async {
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: (ReceivedAction action) async {
  //       if (action.channelKey == AttendanceNotificationController.beforeCheckInChannelKey) {
  //         await AttendanceNotificationController().announceNotification(
  //             action.title ?? '', action.body ?? '');
  //       }
  //     },
  //     // You can add other listeners if needed
  //   );
  // }
// ... existing code ...
  void _startBackgroundServices() {
    _startConnectivityMonitoring();
    _startOfflineSyncMonitoring();
    _startRealTimeSync();
    _startBackgroundLocationTracking().catchError((e) {
      print('[AttendanceController] Error starting background location tracking: $e');
    });
  }

  void _startConnectivityMonitoring() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      bool wasOnline = isConnectivityAvailable.value;
      isConnectivityAvailable.value = result != ConnectivityResult.none;
      
      debugPrint('🌐 Connectivity changed: $result (was: ${wasOnline ? 'online' : 'offline'})');
      
      // If we just came back online, sync offline data
      if (!wasOnline && isConnectivityAvailable.value) {
        debugPrint('🔄 Coming back online - syncing offline data');
        _syncOfflineData();
      }
      
      // Update UI based on connectivity
      if (isConnectivityAvailable.value) {
        isOnline.value = true;
        isOffline.value = false;
      } else {
        isOnline.value = false;
        isOffline.value = true;
      }
    });
  }

  void _startOfflineSyncMonitoring() {
    ever(isConnectivityAvailable, (bool isOnline) {
      if (isOnline) {
        _syncOfflineData();
      }
    });
  }

  void _startRealTimeSync() {
    Timer.periodic(const Duration(minutes: 5), (timer) {
      if (isConnectivityAvailable.value) {
        getCombinedCurrentIndividualStatus();
      }
    });
  }

  Future<void> _syncOfflineData() async {
    if (!isConnectivityAvailable.value) return;

    try {
      isOfflineSync.value = true;
      debugPrint('🔄 Starting offline data sync...');

      List<Map<String, dynamic>> offlineRecords = await _individualAttendanceService.getOfflineAttendanceRecords();

      if (offlineRecords.isNotEmpty) {
        debugPrint('📱 Found ${offlineRecords.length} offline records to sync');

        Map<String, dynamic> result = await _individualAttendanceService.syncIndividualOfflineRecordsToNetworkV2(
          forceCheckOut: false,
          dataPayload: {},
        );

        if (result['success'] == true) {
          debugPrint('✅ Offline data synced successfully');
          showSnackBar(result['message'], type: 'success');
          
          // Refresh attendance status after successful sync
          await getCombinedCurrentIndividualStatus();
        } else {
          debugPrint('❌ Failed to sync offline data: ${result['message']}');
          showSnackBar(result['message'], type: 'error');
        }
      } else {
        debugPrint('📱 No offline records to sync');
      }

      isOfflineSync.value = false;
    } catch (e) {
      debugPrint('❌ Error in offline sync: $e');
      isOfflineSync.value = false;
      showSnackBar('Error syncing offline data', type: 'error');
    }
  }

  Future<void> getCombinedCurrentIndividualStatus() async {
    print("[AttendanceController] Loading started");
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Check authentication status first
      final storageService = Get.find<StorageService>();
      final authToken = await storageService.getAuthToken();
      print("[AttendanceController] Auth token: ${authToken != null ? 'Present' : 'Missing'}");

      if (authToken == null || authToken.isEmpty) {
        errorMessage.value = "Authentication required. Please login again.";
        print("[AttendanceController] No auth token found");
        return;
      }

      // Check user data
      final userData = Get.find<UserDataSingleton>();
      print("[AttendanceController] User data - ID: ${userData.userId}, Name: ${userData.displayName}");
      print("[AttendanceController] User data - UserName: ${userData.userNameString}, Domain: ${userData.domain}");
      print("[AttendanceController] User data - UserType: ${userData.userType}, Role: ${userData.role}");

      if (userData.userId.isEmpty) {
        errorMessage.value = "User data not found. Please retry.";
        print("[AttendanceController] No user data found - userId is empty");
        print("[AttendanceController] User data singleton state: ${userData.toJson()}");
        return;
      }

      print("[AttendanceController] Fetching attendance...");
      var result = await _individualAttendanceService
          .getInitialIndividualStatusCombined()
          .timeout(const Duration(seconds: 10), onTimeout: () {
        print("[AttendanceController] Service call timed out");
        throw Exception("Attendance service timed out");
      });
      print("[AttendanceController] Service response: $result");
      print("[AttendanceController] Service response type: ${result.runtimeType}");
      print("[AttendanceController] Service response is null: ${result == null}");

      if (result != null && result['fetchUserAttendanceStatus'] != null) {
        print("[AttendanceController] Processing attendance data...");
        print("[AttendanceController] fetchUserAttendanceStatus: ${result['fetchUserAttendanceStatus']}");

        try {
          final parsed = FetchUserAttendanceStatus.fromJson(result['fetchUserAttendanceStatus']);
          print("[AttendanceController] Parsed data: $parsed");

          fetchUserAttendanceStatus.value = parsed;
          currentUserStatus.value = _parseStatus(parsed.currentStatus);
          print("[AttendanceController] Current user status: ${currentUserStatus.value}");

          calculateAndUpdateWorkDuration();
          startWorkDurationTimer();
          calculateTotalBreaks(parsed);
          calculateCurrentBreakDuration(parsed);
          startCurrentBreakTimer(parsed);

          print("[AttendanceController] Data processing completed successfully");
        } catch (parseError) {
          print("[AttendanceController] Error parsing attendance data: $parseError");
          errorMessage.value = "Error parsing attendance data: $parseError";
          fetchUserAttendanceStatus.value = null;
          currentUserStatus.value = UserStatus.Offline;
        }
      } else {
        print("[AttendanceController] No valid attendance data found");
        print("[AttendanceController] Result keys: ${result?.keys}");
        errorMessage.value = "No attendance data found. Please check your connection and try again.";
        fetchUserAttendanceStatus.value = null;
        currentUserStatus.value = UserStatus.Offline;
      }
    } catch (err, trace) {
      errorMessage.value = "Error fetching attendance status: ${err.toString()}";
      print("[AttendanceController] Error: $err\nStack: $trace");
      fetchUserAttendanceStatus.value = null;
      currentUserStatus.value = UserStatus.Offline;
    } finally {
      print("[AttendanceController] Loading ended");
      isLoading.value = false;
      update();
    }
  }

  void calculateAndUpdateWorkDuration() {
    if (fetchUserAttendanceStatus.value == null) return;

    var status = fetchUserAttendanceStatus.value!;
    if (status.checkInTime == null) return;

    // Debug the raw timestamps
    // debugPrint('[WorkDurationDebug] Raw checkInTime: ${status.checkInTime}');
    // debugPrint('[WorkDurationDebug] Raw checkOutTime: ${status.checkOutTime}');
    
    // Convert timestamps to proper format if needed
    int checkInTimeMillis = _validateAndFixTimestamp(status.checkInTime!);
    int? checkOutTimeMillis = status.checkOutTime != null ? _validateAndFixTimestamp(status.checkOutTime!) : null;
    
    // debugPrint('[WorkDurationDebug] Normalized checkInTime: $checkInTimeMillis');
    // debugPrint('[WorkDurationDebug] Normalized checkOutTime: $checkOutTimeMillis');
    
    // Validate timestamps are not in the future
    final now = DateTime.now().millisecondsSinceEpoch;
    if (checkInTimeMillis > now) {
      debugPrint('[WorkDurationDebug] ⚠️ Check-in time is in the future, using current time');
      checkInTimeMillis = now;
    }
    
    int endTimeMillis;
    if (status.currentStatus == UserStatus.Online.name.toUpperCase()) {
      endTimeMillis = now;
    } else if (status.currentStatus == UserStatus.Offline.name.toUpperCase()) {
      endTimeMillis = checkOutTimeMillis ?? checkInTimeMillis;
      if (endTimeMillis > now) {
        debugPrint('[WorkDurationDebug] ⚠️ Check-out time is in the future, using current time');
        endTimeMillis = now;
      }
    } else if (status.currentStatus == UserStatus.Break.name.toUpperCase()) {
      var latestBreak = status.attendanceBreak?.lastWhere(
            (breakItem) => breakItem.startTime != null && breakItem.endTime == null,
        orElse: () => AttendanceBreak(
            breakId: null,
            startTime: checkInTimeMillis,
            endTime: null,
            duration: null),
      );
      endTimeMillis = latestBreak?.startTime ?? checkInTimeMillis;
      if (endTimeMillis > now) {
        debugPrint('[WorkDurationDebug] ⚠️ Break start time is in the future, using current time');
        endTimeMillis = now;
      }
    } else {
      endTimeMillis = checkInTimeMillis;
    }

    // Calculate total break duration
    int totalBreakDuration = status.attendanceBreak?.fold<int>(
      0,
          (int sum, breakItem) => sum + ((breakItem.duration ?? 0) as int),
    ) ?? 0;

    int totalDurationMillis = endTimeMillis - checkInTimeMillis;
    
    // Ensure we don't have negative durations
    if (totalDurationMillis < 0) {
      debugPrint('[WorkDurationDebug] ⚠️ Negative duration detected, setting to 0');
      totalDurationMillis = 0;
    }
    
    totalWorkDuration.value = totalDurationMillis - totalBreakDuration;
    
    // Ensure work duration is not negative
    if (totalWorkDuration.value < 0) {
      debugPrint('[WorkDurationDebug] ⚠️ Negative work duration detected, setting to 0');
      totalWorkDuration.value = 0;
    }

    // If work duration is unreasonably large (more than 24 hours), create a reasonable fallback
    const maxReasonableDuration = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
    if (totalWorkDuration.value > maxReasonableDuration) {
     // debugPrint('[WorkDurationDebug] ⚠️ Work duration is unreasonably large, creating fallback');
      
      // Create a reasonable work duration based on current time
      final currentHour = DateTime.now().hour;
      int fallbackDuration;
      
      if (currentHour < 9) {
        // Before 9 AM, assume work just started
        fallbackDuration = 0;
      } else if (currentHour < 17) {
        // Between 9 AM and 5 PM, assume work started at 9 AM
        final workStartTime = DateTime.now().copyWith(hour: 9, minute: 0, second: 0, millisecond: 0);
        fallbackDuration = DateTime.now().difference(workStartTime).inMilliseconds;
      } else {
        // After 5 PM, assume 8 hours of work
        fallbackDuration = 8 * 60 * 60 * 1000; // 8 hours
      }
      
      totalWorkDuration.value = fallbackDuration;
     // debugPrint('[WorkDurationDebug] Fallback work duration: ${fallbackDuration}ms');
    }

    // Add debug prints
    // debugPrint('[WorkDurationDebug] checkInTime: ${checkInTimeMillis}');
    // debugPrint('[WorkDurationDebug] checkOutTime: ${checkOutTimeMillis}');
    // debugPrint('[WorkDurationDebug] endTimeMillis: ${endTimeMillis}');
    // debugPrint('[WorkDurationDebug] totalBreakDuration: ${totalBreakDuration}');
    // debugPrint('[WorkDurationDebug] totalDurationMillis: ${totalDurationMillis}');
    // debugPrint('[WorkDurationDebug] totalWorkDuration: ${totalWorkDuration.value}');
    
    // Convert to human readable format for debugging
    final duration = Duration(milliseconds: totalWorkDuration.value);
   // debugPrint('[WorkDurationDebug] Work duration (human): ${duration.inHours}h ${duration.inMinutes.remainder(60)}m');
  }
  
  // Helper method to normalize timestamps
  int _normalizeTimestamp(int timestamp) {
    // If timestamp is in seconds (10 digits), convert to milliseconds
    if (timestamp.toString().length == 10) {
      return timestamp * 1000;
    }
    // If timestamp is already in milliseconds (13 digits), return as is
    else if (timestamp.toString().length == 13) {
      return timestamp;
    }
    // For any other format, assume it's already in milliseconds
    else {
      return timestamp;
    }
  }

  // Helper method to validate and fix timestamps
  int _validateAndFixTimestamp(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final normalizedTimestamp = _normalizeTimestamp(timestamp);
    
    // If timestamp is in the future, it's likely a backend issue
    if (normalizedTimestamp > now) {
      debugPrint('[WorkDurationDebug] ⚠️ Future timestamp detected: $normalizedTimestamp');
      debugPrint('[WorkDurationDebug] ⚠️ Current time: $now');
      
      // Try to convert from a different timezone or format
      // Sometimes backend sends timestamps in a different timezone
      final futureDate = DateTime.fromMillisecondsSinceEpoch(normalizedTimestamp);
      debugPrint('[WorkDurationDebug] ⚠️ Future date: $futureDate');
      
      // If it's more than 1 year in the future, it's definitely wrong
      if (futureDate.year > DateTime.now().year + 1) {
        debugPrint('[WorkDurationDebug] ⚠️ Timestamp is more than 1 year in future, using current time');
        return now;
      }
      
      // If it's within a reasonable future range, try to adjust it
      // This might be a timezone issue or date calculation error
      final timeDifference = normalizedTimestamp - now;
      final daysDifference = timeDifference / (1000 * 60 * 60 * 24);
      
      if (daysDifference > 365) {
        // More than a year difference, definitely wrong
        debugPrint('[WorkDurationDebug] ⚠️ Timestamp is ${daysDifference.toStringAsFixed(1)} days in future, using current time');
        return now;
      } else {
        // Within a year, might be a timezone issue, use current time
        debugPrint('[WorkDurationDebug] ⚠️ Timestamp is ${daysDifference.toStringAsFixed(1)} days in future, using current time');
        return now;
      }
    }
    
    return normalizedTimestamp;
  }

  void startWorkDurationTimer() {
    _workDurationTimer?.cancel();
    if (currentUserStatus.value == UserStatus.Online) {
      calculateAndUpdateWorkDuration(); // Initial calculation
      _workDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        calculateAndUpdateWorkDuration();
      });
    }
  }

  void stopWorkDurationTimer() {
    _workDurationTimer?.cancel();
    _workDurationTimer = null;
  }

  void calculateTotalBreaks(FetchUserAttendanceStatus attendanceStatus) {
    int totalBreakDuration = 0;
    int numberOfBreaks = attendanceStatus.attendanceBreak?.length ?? 0;

    if (attendanceStatus.attendanceBreak != null) {
      // Sum up all break durations
      for (var breakItem in attendanceStatus.attendanceBreak!) {
        if (breakItem.duration != null) {
          totalBreakDuration += breakItem.duration as int;
        }
      }
    }

    // Update the observables
    totalBreakDurationObs.value = totalBreakDuration;
    numberOfBreaksObs.value = numberOfBreaks;
  }

  void calculateCurrentBreakDuration(
      FetchUserAttendanceStatus attendanceStatus) {
    if (attendanceStatus.currentStatus == UserStatus.Break.name.toUpperCase() &&
        attendanceStatus.allowedBreak != null) {
      // Find the latest break with no endTime (ongoing break)
      final latestBreak = attendanceStatus.attendanceBreak!.lastWhere(
            (breakItem) => breakItem.endTime == null,
      );

      // Calculate the duration of the ongoing break
      int currentBreakDuration = DateTime.now().toUtc().millisecondsSinceEpoch -
          latestBreak.startTime as int;
      currentBreakDurationObs.value = currentBreakDuration;
    } else {
      currentBreakDurationObs.value = 0; // User is not on a break
    }
  }

  void startCurrentBreakTimer(FetchUserAttendanceStatus attendanceStatus) {
    // Stop the timer if it's already running
    stopCurrentBreakTimer();

    // Start a new timer
    _currentBreakTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (attendanceStatus.currentStatus ==
          UserStatus.Break.name.toUpperCase()) {
        calculateCurrentBreakDuration(attendanceStatus);
      } else {
        stopCurrentBreakTimer();
      }
    });
  }

  void stopCurrentBreakTimer() {
    _currentBreakTimer?.cancel();
    _currentBreakTimer = null;
  }

  UserStatus _parseStatus(String? status) {
    switch (status) {
      case "ONLINE":
        return UserStatus.Online;
      case "BREAK":
        return UserStatus.Break;
      case "NO_ATTENDANCE":
      case "OFFLINE":
      default:
        return UserStatus.Offline;
    }
  }
  Future<String?> getAssignedGeofenceIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    final findAssigneeJson = prefs.getString('findAssignee');
    if (findAssigneeJson != null) {
      final assigneeMap = jsonDecode(findAssigneeJson) as Map<String, dynamic>;
      if (assigneeMap['geofence'] is Map) {
        return assigneeMap['geofence']['identifier']?.toString();
      }
      // fallback for other possible keys
      return assigneeMap['geofenceId']?.toString() ?? assigneeMap['geofence_id']?.toString();
    }
    return null;
  }

  Future<String?> getAssignedGeofenceId() async {
    final prefs = await SharedPreferences.getInstance();
    final findAssigneeJson = prefs.getString('findAssignee');
    if (findAssigneeJson != null) {
      final assigneeMap = jsonDecode(findAssigneeJson) as Map<String, dynamic>;
      // Try common keys: 'geofenceId', 'geofence_id'
      return assigneeMap['geofenceId']?.toString() ?? assigneeMap['geofence_id']?.toString();
    }
    return null;
  }
  // Enhanced updateUserStatus method with confirmation UI support
  Future<void> updateUserStatus({
    required UserStatus newStatus,
    bool isForceCheckOut = false,
    int? forceCheckOutTime,
  }) async {
    print('DEBUG: updateUserStatus START - newStatus: ${newStatus.name}');
    print('DEBUG: Current user status: ${currentUserStatus.value?.name}');
    
    // Use a specific loading state for this action so the whole screen doesn't rebuild.
    isMarkAttendanceLoading.value = true;
    print('DEBUG: Loading set to true');
    
    try {
      print('DEBUG: Starting geofence validation logic');
      
      // --- Place the new logic here ---
      bool allowCheckoutAnywhere = false;
      if (newStatus == UserStatus.Offline) {
        print('DEBUG: Processing checkout logic');
        final shiftController = Get.find<ShiftDetailsController>();
        final shiftInfo = shiftController.getShiftInfo();
        final endTimeStr = shiftInfo['endTime'];
        if (endTimeStr != null) {
          final now = DateTime.now();
          final parts = endTimeStr.split(':');
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1]);
          // Ignore seconds if present
          DateTime localEnd = DateTime(now.year, now.month, now.day, hour, minute);
          final graceEnd = localEnd.add(const Duration(minutes: 15));
          print('[CheckoutDebug] endTimeStr: $endTimeStr');
          print('[CheckoutDebug] Now: $now');
          print('[CheckoutDebug] localEnd: $localEnd');
          print('[CheckoutDebug] graceEnd: $graceEnd');
          print('[CheckoutDebug] isAfter: \\${now.isAfter(graceEnd)}');
          if (now.isAfter(graceEnd)) {
            print('[CheckoutDebug] Allowing checkout from any location (after grace period)');
            allowCheckoutAnywhere = true;
          }
        }
      }
      
      print('DEBUG: About to check geofence validation');
      if (!(newStatus == UserStatus.Offline && allowCheckoutAnywhere)) {
        print('DEBUG: Calling canUserCheckInOrOut()');
        final result = await canUserCheckInOrOut();
        print('DEBUG: canUserCheckInOrOut result: $result');
        if (!result['canCheckIn']) {
          print('DEBUG: Geofence validation failed - showing error');
          showSnackBar('You must be inside your assigned geofence to check in/out.', type: 'error');
          return;
        }
      }
      print('DEBUG: Geofence validation passed');
      
      debugPrint('✅ Action initiated for status: ${newStatus.name}');

      print('DEBUG: Getting assigned geofence identifier');
      final assignedGeofenceId = await getAssignedGeofenceIdentifier(); // from shared prefs or your model
      print('DEBUG: Assigned geofence ID: $assignedGeofenceId');
      
      print('DEBUG: Getting live location');
      final position = await GeofenceFinder.getLiveLocation();
      final userLat = position.latitude;
      final userLng = position.longitude;
      print('DEBUG: User location: $userLat, $userLng');

      print('DEBUG: Setting up geofence service');
      final geofenceService = Get.find<GeofenceNewService>();
      if (geofenceService.allGeofenceData.value == null) {
        print('DEBUG: Geofence data is null - showing error');
        showSnackBar('Loading geofence data, please wait...', type: 'info');
        return;
      }
      
      print('DEBUG: Setting user geofence');
      geofenceService.setUserGeofenceOrLocation(
        userGeofenceId: assignedGeofenceId,
        userLocationPoint: {'lat': userLat, 'lng': userLng},
      );

      String geoFenceName = '';
      final matched = geofenceService.userGeofence.value;
      if (matched != null) {
        final map = matched.data?.value as Map<String, dynamic>?;
        geoFenceName = map?['name'] ?? '';
      }
      print('DEBUG: Geofence name: $geoFenceName');

      print('DEBUG: Gathering attendance data');
      // Gather all necessary data before sending.
      final hasInternet = isConnectivityAvailable.value;
      print('DEBUG: Internet connectivity: $hasInternet');
      
      final user = Get.find<UserDataSingleton>();
      final attendanceId = _individualAttendanceHelpers.getAttendanceId();
      print('DEBUG: Attendance ID: $attendanceId');
      
      print('DEBUG: Getting current location');
      final currentLocation = await AttendanceLocationService().getUserCurrentLocation();
      print('DEBUG: Current location: $currentLocation');
      
      final geofenceListRaw = geoFenceServices.allGeofenceData.value?['data'] as List<dynamic>? ?? [];
      final geofenceList = geofenceListRaw.map((e) => GeofenceLocation.fromMap(e)).toList();
      final geofence = GeofenceFinder.findCurrentGeofence(position, geofenceList);
      String? breakId;

      if (newStatus == UserStatus.Break) {
        breakId = DateTime.now().millisecondsSinceEpoch.toString();
      } else if (newStatus == UserStatus.Online && currentUserStatus.value == UserStatus.Break) {
        breakId = _individualAttendanceHelpers.getLatestOngoingBreakId();
      }
      print('DEBUG: Break ID: $breakId');

      print('DEBUG: Getting shift information');
      // Get shift information for the attendance payload
      Map<String, dynamic> shiftInfo = {};
      try {
        final shiftController = Get.find<ShiftDetailsController>();
        shiftInfo = shiftController.getShiftInfo();
        debugPrint('🔍 Shift info for attendance: $shiftInfo');
      } catch (e) {
        debugPrint('⚠️ Could not get shift info: $e');
      }

      print('DEBUG: Preparing attendance payload');
      Map<String, dynamic> attendanceData = {

       // "userId": user.userId,
        "newStatus": newStatus.name.toUpperCase(),
        "statusSince": isForceCheckOut
            ? forceCheckOutTime
            : DateTime.now().toUtc().millisecondsSinceEpoch,
        "locationName": currentLocation['locationName'] ?? "",
        "location": currentLocation['locationCoordinates'] ?? "",
        "attendanceId": int.tryParse(attendanceId ?? '0'),
        //"attendanceId": attendanceId == null ? null : int.tryParse(attendanceId),
        "breakId": int.tryParse(breakId ?? ''),
        "geofence": geoFenceName,
        "batteryLevel": await MqttPublishMethod().getBatteryLevel(),
        "deviceId": await fetchTheUniqueDeviceId(),
        // Add shift information
        "shiftId": shiftInfo['hasData'] ? shiftInfo['identifier'] : null,
        "shiftName": shiftInfo['hasData'] ? shiftInfo['name'] : null,
        "shiftType": shiftInfo['hasData'] ? shiftInfo['type'] : null,
        "bufferTime": shiftInfo['hasData'] ? shiftInfo['bufferTime'] : null,
        "allowedBreak": shiftInfo['hasData'] ? shiftInfo['allowedBreak'] : null,
      };

      debugPrint('📤 Attendance payload with shift info: $attendanceData');

      print('DEBUG: About to make API call');
      if (hasInternet) {
        print('DEBUG: Making network API call');
        final result = await _individualAttendanceService.markUserAttendanceToNetwork(
          dataToNetwork: attendanceData,
        );
        print('DEBUG: Network API result: $result');
        if (result['success']) {
          print('DEBUG: Network API success - showing success message');
          showSnackBar(result['message'], type: 'success');
        } else {
          print('DEBUG: Network API failed - result: $result');
          //showSnackBar(result['message'], type: 'error');
        }
      } else {
        print('DEBUG: No internet - saving to local');
        await _individualAttendanceService.markUserAttendanceToLocal(
          dataToLocal: attendanceData
        );
        showSnackBar('Offline. Action saved.', type: 'info');
      }

      print('DEBUG: API call completed - starting notification scheduling');
      // --- Notification Scheduling ---
      final now = DateTime.now();
      if (newStatus == UserStatus.Online) {
        print('DEBUG: Scheduling notifications for Online status');
        // Schedule check-out and break reminders if you have shift info
        // Example: 6:00 PM check-out, 1:00 PM break
        // Replace with actual times from shiftInfo if available
        DateTime? checkOutTime;
        DateTime? breakStartTime;
        if (shiftInfo['hasData'] == true) {
          // Parse shift end and break start from shiftInfo
          final today = DateTime(now.year, now.month, now.day);
          if (shiftInfo['shiftEnd'] != null) {
            final endParts = (shiftInfo['shiftEnd'] as String).split(":");
            checkOutTime = DateTime(today.year, today.month, today.day, int.parse(endParts[0]), int.parse(endParts[1]));
          }
          if (shiftInfo['breakStart'] != null) {
            final breakParts = (shiftInfo['breakStart'] as String).split(":");
            breakStartTime = DateTime(today.year, today.month, today.day, int.parse(breakParts[0]), int.parse(breakParts[1]));
          }
        }
        if (checkOutTime != null) {
          scheduleCheckOutReminder(checkOutTime);
        }
        if (breakStartTime != null) {
          scheduleBreakReminder(breakStartTime);
        }
      } else if (newStatus == UserStatus.Break) {
        print('DEBUG: Scheduling notifications for Break status');
        // Schedule break reminder 15 min after break starts
        scheduleBreakReminder(now);
        // --- ADDED: Trigger break notification logic for testing ---
        print('DEBUG: Calling manageAttendanceNotification for Break');
        AttendanceNotificationsScheduler.manageAttendanceNotification(
          currentStatus: UserStatus.Online.name.toUpperCase(),
          newStatus: UserStatus.Break.name.toUpperCase(),
          isIndividualUser: true,
        );
      } else if (newStatus == UserStatus.Offline) {
        print('DEBUG: Scheduling notifications for Offline status');
        // Optionally cancel all scheduled notifications on check-out
        // AwesomeNotifications().cancelAll();

        // Schedule check-in reminder for the next shift
        DateTime? nextCheckInTime;
        if (shiftInfo['hasData'] == true && shiftInfo['shiftStart'] != null) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final startParts = (shiftInfo['shiftStart'] as String).split(":");
          nextCheckInTime = DateTime(today.year, today.month, today.day, int.parse(startParts[0]), int.parse(startParts[1]));
          // If check-in time is already past for today, schedule for tomorrow
          if (nextCheckInTime.isBefore(now)) {
            nextCheckInTime = nextCheckInTime.add(const Duration(days: 1));
          }
          scheduleCheckInReminder(nextCheckInTime);
        }
      }
      print('DEBUG: Notification scheduling completed');
      // --- End Notification Scheduling ---

    } catch (e) {
      print('DEBUG: ERROR in updateUserStatus: $e');
      print('DEBUG: Error stack trace: ${StackTrace.current}');
      debugPrint('❌ CRITICAL Error in updateUserStatus: $e');
     // showSnackBar('Could not update status: $e', type: 'error');
    } finally {
      print('DEBUG: Starting final cleanup');
      // After the action, ALWAYS perform a full, clean refresh.
      // This is the safest way to ensure the UI is in sync.
      print('DEBUG: Calling getCombinedCurrentIndividualStatus');
      await getCombinedCurrentIndividualStatus();
      print('DEBUG: Status refresh completed');
      
      // Add debug prints after refresh
      if (fetchUserAttendanceStatus.value != null) {
        debugPrint('[CheckInDebug] New attendanceId:  [32m${fetchUserAttendanceStatus.value!.attendanceId} [0m');
        debugPrint('[CheckInDebug] New checkInTime:  [32m${fetchUserAttendanceStatus.value!.checkInTime} [0m');
      }
      
      print('DEBUG: Setting loading to false');
      isMarkAttendanceLoading.value = false;
      print('DEBUG: updateUserStatus END');
    }
  }

  // Enhanced methods for confirmation UI
  void showConfirmationDialog(String action, String message) {
    openConfirmationUI.value = true;
    confirmationMessage.value = message;
    whichActionButton.value = action;
  }

  void hideConfirmationDialog() {
    openConfirmationUI.value = false;
    confirmationMessage.value = "";
    whichActionButton.value = "";
  }

  Future<void> confirmAction() async {
    switch (whichActionButton.value) {
      case "ONLINE":
        hideConfirmationDialog();
        await updateUserStatus(newStatus: UserStatus.Online);
        break;
      case "OFFLINE":
        hideConfirmationDialog();
        await updateUserStatus(newStatus: UserStatus.Offline);
        break;
      case "BREAK":
        hideConfirmationDialog();
        await updateUserStatus(newStatus: UserStatus.Break);
        break;
    }
  }

  Future<bool> _checkInternetConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      return false;
    }
  }

  Future<void> forceCheckOut() async {
    try {
      isForceCheckOut.value = true;
      await updateUserStatus(newStatus: UserStatus.Offline, isForceCheckOut: true);
    } finally {
      isForceCheckOut.value = false;
    }
  }

  Future<void> getWorkTimeDetails() async {
    try {
      workTimeDetails.value = {
        'shiftStart': '09:00',
        'shiftEnd': '18:00',
        'breakStart': '13:00',
        'breakEnd': '14:00',
        'is24HourShift': false,
      };
    } catch (e) {
      debugPrint('Error fetching work time details: $e');
    }
  }

  bool canCheckIn() {
    final currentStatus = fetchUserAttendanceStatus.value?.currentStatus;
    return currentStatus == null || currentStatus.toUpperCase() == 'OFFLINE';
  }

  bool canCheckOut() {
    final currentStatus = fetchUserAttendanceStatus.value?.currentStatus;
    return currentStatus != null && currentStatus.toUpperCase() == 'ONLINE';
  }

  bool canTakeBreak() {
    final currentStatus = fetchUserAttendanceStatus.value?.currentStatus;
    return currentStatus != null && currentStatus.toUpperCase() == 'ONLINE';
  }

  String getCurrentStatusText() {
    final status = fetchUserAttendanceStatus.value?.currentStatus;
    if (status == null) return 'Not Checked In';

    switch (status.toUpperCase()) {
      case 'ONLINE':
        return 'Checked In';
      case 'OFFLINE':
        return 'Checked Out';
      case 'BREAK':
        return 'On Break';
      default:
        return status;
    }
  }

  Color getCurrentStatusColor() {
    final status = fetchUserAttendanceStatus.value?.currentStatus;
    if (status == null) return Colors.grey;

    switch (status.toUpperCase()) {
      case 'ONLINE':
        return Colors.green;
      case 'OFFLINE':
        return Colors.red;
      case 'BREAK':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  UserStatus? _getNewStatus(String? currentStatus) {
    if (currentStatus == null) return null;
    switch (currentStatus.toUpperCase()) {
      case 'ONLINE':
        return UserStatus.Offline;
      case 'OFFLINE':
        return UserStatus.Online;
      case 'BREAK':
        return UserStatus.Online;
      default:
        return null;
    }
  }

  void updateAndSyncStatus(UserStatus status) {
    markAttendance(status);
  }

  void handleCheckIn() {
    final newStatus =
        _individualAttendanceHelpers.handleIndividualAttendance(UserStatus.Online);
    markAttendance(newStatus);
  }

  void handleCheckOut() {
    _individualAttendanceHelpers.openCheckInButton(false);
  }

  void handleBreak() {
    if (currentUserStatus.value == UserStatus.Break) {
      final newStatus = _individualAttendanceHelpers
          .handleIndividualAttendance(UserStatus.Online);
      markAttendance(newStatus);
    } else {
      final newStatus =
          _individualAttendanceHelpers.handleIndividualAttendance(UserStatus.Break);
      markAttendance(newStatus);
    }
  }

  void syncOfflineRecord(Map<String, dynamic> record) {
    // ... (existing implementation)
  }

  // UI update methods
  void onCheckInPressed() {
    final newStatus =
        _individualAttendanceHelpers.handleIndividualAttendance(UserStatus.Online);
    markAttendance(newStatus);
  }

  void onCheckOutPressed() {
    _individualAttendanceHelpers.openCheckInButton(false);
  }

  void onBreakPressed() {
    if (currentUserStatus.value == UserStatus.Break) {
      final newStatus = _individualAttendanceHelpers
          .handleIndividualAttendance(UserStatus.Online);
      markAttendance(newStatus);
    } else {
      final newStatus =
          _individualAttendanceHelpers.handleIndividualAttendance(UserStatus.Break);
      markAttendance(newStatus);
    }
  }

  void onForceCheckoutPressed() {
    // ... (existing implementation)
  }

  Future<void> _updateNearbyLocations() async {
    try {
      final currentPosition = await GeofenceFinder.getLiveLocation();
      final geofenceList = getGeofenceData(geoFenceServices)
          .map((e) => GeofenceLocation.fromMap(e))
          .toList();
      final nearbyGeofences = GeofenceFinder.findNearbyLocations(currentPosition, geofenceList);
      // Update UI or state with nearbyGeofences
    } catch (e) {
      debugPrint('Error updating nearby locations: $e');
    }
  }

  Future<void> markAttendance(UserStatus status) async {
    // Placeholder implementation
    debugPrint("markAttendance called with status: $status");
  }

  Future<void> _startBackgroundLocationTracking() async {
    try {
      print('[AttendanceController] Starting background location tracking');
      await BackgroundLocationService.startLocationTracking();
      
    } catch (e) {
      print('[AttendanceController] Error starting background location tracking: $e');
    }
  }
  
  void _handleBackgroundLocationUpdate(Map<String, dynamic> locationData) {
    try {
      // Update current location
      final latitude = locationData['latitude'] as double?;
      final longitude = locationData['longitude'] as double?;
      final accuracy = locationData['accuracy'] as double?;
      final timestamp = locationData['timestamp'] as int?;
      
      if (latitude != null && longitude != null) {
        // Update geofence status
        _updateGeofenceStatus(latitude, longitude);
        
        // Update location-based attendance status
        _updateLocationBasedAttendance(latitude, longitude, accuracy);
      }
    } catch (e) {
      print('[AttendanceController] Error handling background location update: $e');
    }
  }
  
  void _updateGeofenceStatus(double latitude, double longitude) {
    try {
      // Check if user is inside any geofence
      final geofences = geoFenceServices.getGeofenceLocations();
      
      for (var geofence in geofences) {
        final distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          geofence.latitude,
          geofence.longitude,
        );
        
        final isInside = distance <= geofence.radius;
        final wasInside = isInGeofence.value;
        
        if (isInside != wasInside) {
          isInGeofence.value = isInside;
          currentGeofenceName.value = isInside ? geofence.name : '';
          
          print('[AttendanceController] Geofence status changed: ${isInside ? 'Inside' : 'Outside'} ${geofence.name}');
          
          // Show notification for geofence change
          _showGeofenceNotification(geofence.name, isInside);
        }
      }
    } catch (e) {
      print('[AttendanceController] Error updating geofence status: $e');
    }
  }
  
  void _updateLocationBasedAttendance(double latitude, double longitude, double? accuracy) {
    try {
      // Update location-based attendance logic
      // This could include checking if user is at work location
      // and updating attendance status accordingly
      
      if (isInGeofence.value) {
        // User is inside geofence, can mark attendance
        if (currentUserStatus.value == UserStatus.Offline) {
          print('[AttendanceController] User is inside geofence and can check in');
        }
      } else {
        // User is outside geofence
        if (currentUserStatus.value == UserStatus.Online) {
          print('[AttendanceController] User is outside geofence');
        }
      }
    } catch (e) {
      print('[AttendanceController] Error updating location-based attendance: $e');
    }
  }
  
  void _showGeofenceNotification(String geofenceName, bool isInside) {
    try {
      // Show local notification for geofence change
      final message = isInside 
          ? 'You entered $geofenceName'
          : 'You left $geofenceName';
      
      print('[AttendanceController] Geofence notification: $message');
      
      // You can integrate with your notification service here
      // For now, just log the message
    } catch (e) {
      print('[AttendanceController] Error showing geofence notification: $e');
    }
  }
  
  // Public methods to control background location tracking
  Future<void> startBackgroundLocationTracking() async {
    await _startBackgroundLocationTracking();
  }
  
  Future<void> stopBackgroundLocationTracking() async {
    try {
      await BackgroundLocationService.stopLocationTracking();
      print('[AttendanceController] Background location tracking stopped');
    } catch (e) {
      print('[AttendanceController] Error stopping background location tracking: $e');
    }
  }
  
  // Get current location from background service
  Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      return await BackgroundLocationService.getCurrentLocation();
    } catch (e) {
      print('[AttendanceController] Error getting current location: $e');
      return null;
    }
  }
  
  // Get location history from background service
  Future<List<Map<String, dynamic>>> getLocationHistory() async {
    try {
      return await BackgroundLocationService.getLocationHistory();
    } catch (e) {
      print('[AttendanceController] Error getting location history: $e');
      return [];
    }
  }
  
  // Get geofence events from background service
  Future<List<Map<String, dynamic>>> getGeofenceEvents() async {
    try {
      return await BackgroundLocationService.getGeofenceEvents();
    } catch (e) {
      print('[AttendanceController] Error getting geofence events: $e');
      return [];
    }
  }
  
  // Save geofence data to background service storage
  Future<void> saveGeofenceDataToBackground() async {
    try {
      final geofences = geoFenceServices.getGeofenceLocations();
      await BackgroundLocationService.saveGeofenceData(geofences);
      print('[AttendanceController] Geofence data saved to background service');
    } catch (e) {
      print('[AttendanceController] Error saving geofence data to background service: $e');
    }
  }
  
  // Clear all background location data
  Future<void> clearBackgroundLocationData() async {
    try {
      await BackgroundLocationService.clearAllData();
      print('[AttendanceController] Background location data cleared');
    } catch (e) {
      print('[AttendanceController] Error clearing background location data: $e');
    }
  }
  
  // Get tracking statistics
  Future<Map<String, dynamic>> getTrackingStats() async {
    try {
      return await BackgroundLocationService.getTrackingStats();
    } catch (e) {
      print('[AttendanceController] Error getting tracking stats: $e');
      return {};
    }
  }

  void clearAttendanceData() {
    fetchUserAttendanceStatus.value = null;
    isMarkAttendanceLoading.value = false;
    currentUserStatus.value = UserStatus.Offline;
    totalWorkDuration.value = 0;
    _workDurationTimer?.cancel();
    _currentBreakTimer?.cancel();
    attendanceLog.clear();
    errorMessage.value = '';
  }

  void _startLocationMonitoring() {
    // Stop any existing stream
    _positionStreamSubscription?.cancel();

    // Define location settings
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    // Start listening to the position stream
    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        print("📍 Location Update: ${position.latitude}, ${position.longitude}");
        
        // Check if user is inside any geofence
        final geofences = geoFenceServices.getGeofenceLocations();
        print("Checking geofences: $geofences");
        bool currentlyInGeofence = false;
        String geofenceName = '';

        for (var geofence in geofences) {
          double distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            geofence.latitude,
            geofence.longitude,
          );
          print("Distance to geofence '${geofence.name}': $distance, radius: ${geofence.radius}");
          if (distance <= geofence.radius) {
            currentlyInGeofence = true;
            geofenceName = geofence.name;
            break; 
          }
        }

        // Update the reactive variables
        if (isInGeofence.value != currentlyInGeofence) {
          isInGeofence.value = currentlyInGeofence;
          currentGeofenceName.value = geofenceName;
          print("Geofence status changed: ${isInGeofence.value ? 'ENTERED' : 'EXITED'} ${currentGeofenceName.value}");
          // Show notification on geofence entry/exit
          NotificationManager().showImmediateNotification(
            id: isInGeofence.value ? 1001 : 1002,
            title: isInGeofence.value ? 'Entered Geofence' : 'Left Geofence',
            body: isInGeofence.value
                ? 'You are now inside the allowed area.'
                : 'You have exited the allowed area.',
            channel: 'alerts',
          );
          // You might want to show a snackbar here
          Get.snackbar(
            'Geofence Alert', 
            "You have ${isInGeofence.value ? 'entered' : 'exited'} ${currentGeofenceName.value}",
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      onError: (error) {
        print("Error listening to location stream: $error");
        isInGeofence.value = false; // Assume outside on error
      },
    );
  }

  // --- Notification Scheduling Helpers ---
  void scheduleCheckInReminder(DateTime checkInTime) {
    final notificationTime = checkInTime.subtract(const Duration(minutes: 5));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Check-In Reminder',
        body: 'Your check-in time is in 5 minutes!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }

  void scheduleBreakReminder(DateTime breakStartTime) {
    final notificationTime = breakStartTime.add(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Break Reminder',
        body: 'Your break has exceeded 15 minutes. Please return!',
        notificationLayout: NotificationLayout.Default,



      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
   // AttendanceNotificationController().announceNotification(title, body);
  }

  void scheduleCheckOutReminder(DateTime checkOutTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: checkOutTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Check-Out Reminder',
        body: 'It\'s time to check out!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: checkOutTime),
    );
  }

  void scheduleVoiceCheckInReminder(DateTime shiftStartTime) {
    final notificationTime = shiftStartTime.subtract(const Duration(minutes: 1));
    NotificationManager().scheduleNotification(
      id: notificationTime.millisecondsSinceEpoch.remainder(100000),
      title: 'Check-In Reminder',
      body: 'Your shift is about to start. Please get ready to check in!',
      scheduledDate: notificationTime,
      channel: AttendanceNotificationController.beforeCheckInChannelKey,
      shouldAnnounce: true, // This will trigger TTS/voice
    );
  }

  // --- TEST Notification Scheduling Helpers (for quick testing) ---
  void testScheduleCheckInReminder() {
    final notificationTime = DateTime.now().add(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Check-In Reminder (Test)',
        body: 'This is a test check-in reminder!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }

  void testScheduleBreakReminder() {
    final notificationTime = DateTime.now().add(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Break Reminder (Test)',
        body: 'This is a test break reminder!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }

  void testScheduleCheckOutReminder() {
    final notificationTime = DateTime.now().add(const Duration(minutes: 2));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'alerts',
        title: 'Check-Out Reminder (Test)',
        body: 'This is a test check-out reminder!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }
  // --- END TEST Notification Scheduling Helpers ---

  // Add this method to allow force checkout from ForceCheckoutService
  void forceCheckoutUser() {
    print('[AttendanceController] forceCheckoutUser called: Forcing user checkout!');
    updateUserStatus(newStatus: UserStatus.Offline, isForceCheckOut: true);
    print('[AttendanceController] User status set to Offline via updateUserStatus.');
  }
}
