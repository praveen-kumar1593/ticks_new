import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticks_new/controllers/attendance_controller.dart';
import 'package:ticks_new/controllers/auth_controller.dart';
import 'package:ticks_new/utils/user_status_enum.dart';
import 'package:ticks_new/models/user_data_singleton.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../modules/shift_details/controllers/shift_details_controller.dart';
import '../modules/notifications/notification_manager.dart';
import '../modules/notifications/attendance_notifications_controller.dart';

class NewAttendanceScreen extends StatefulWidget {
  @override
  State<NewAttendanceScreen> createState() => _NewAttendanceScreenState();
}

class _NewAttendanceScreenState extends State<NewAttendanceScreen> {
  final AttendanceController _attendanceController = Get.put(AttendanceController());
  final AuthController _authController = Get.find();
  final UserDataSingleton _userData = UserDataSingleton();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Rebuild every 30 seconds to trigger validation and UI updates
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      print('Timer triggered at ${DateTime.now()}');
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shiftInfo = Get.find<ShiftDetailsController>().getShiftInfo();
      final now = DateTime.now();
      final startTimeStr = shiftInfo['startTime'];
      if (startTimeStr != null) {
        final parts = startTimeStr.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        int second = parts.length > 2 ? int.parse(parts[2]) : 0;
        DateTime shiftStart = DateTime.utc(now.year, now.month, now.day, hour, minute, second).toLocal();
        print('Scheduling voice check-in reminder for $shiftStart');
        _attendanceController.scheduleVoiceCheckInReminder(shiftStart);
      }
    });
    _refreshUserData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  Future<void> _refreshUserData() async {
    await Get.find<AuthController>().checkAuthStatus();
    await _attendanceController.getCombinedCurrentIndividualStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(() {
                if (_attendanceController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_attendanceController.fetchUserAttendanceStatus.value != null) {
                  return _buildMainContent(context);
                } else if (_userData.userId.isEmpty) {
                  // Auto-refresh if userId is empty
                  Future.microtask(() async {
                    await Get.find<AuthController>().checkAuthStatus();
                    await _attendanceController.getCombinedCurrentIndividualStatus();
                  });
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'User data not found. Trying to refresh...',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await Get.find<AuthController>().checkAuthStatus();
                            await _attendanceController.getCombinedCurrentIndividualStatus();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          _attendanceController.errorMessage.value.isNotEmpty 
                              ? _attendanceController.errorMessage.value 
                              : 'Unable to load attendance data',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _attendanceController.getCombinedCurrentIndividualStatus(),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFFFA726),
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Attendance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _attendanceController.currentDate,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            child: const Text('History'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildUserInfoCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            _buildSummaryCard(context),
           // --- TEST NOTIFICATION BUTTONS START ---
            Card(
              color: Colors.yellow[50],
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Test Notifications',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Get.put(AttendanceNotificationController()).testTTSNotification(),
                      child: Text('Test Voice Notification'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final scheduled = now.add(const Duration(minutes: 1));
                        await NotificationManager().scheduleNotification(
                          id: now.millisecondsSinceEpoch.remainder(100000),
                          title: 'Check-In Reminder',
                          body: 'This is a test check-in reminder notification.',
                          scheduledDate: scheduled,
                          channel: AttendanceNotificationController.beforeCheckInChannelKey,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Check-In Reminder scheduled for 1 min later')),
                        );
                      },
                      child: const Text('Test Check-In Reminder'),
                    ),
                    // const SizedBox(height: 8),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final now = DateTime.now();
                    //     final scheduled = now.add(const Duration(minutes: 1));
                    //     await NotificationManager().scheduleNotification(
                    //       id: now.millisecondsSinceEpoch.remainder(100000) + 1,
                    //       title: 'Break Reminder',
                    //       body: 'This is a test break reminder notification.',
                    //       scheduledDate: scheduled,
                    //       channel: AttendanceNotificationController.breakExceedReminderChannelKey,
                    //     );
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Break Reminder scheduled for 1 min later')),
                    //     );
                    //   },
                    //   child: const Text('Test Break Reminder'),
                    // ),
                    // const SizedBox(height: 8),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final now = DateTime.now();
                    //     final scheduled = now.add(const Duration(minutes: 2));
                    //     await NotificationManager().scheduleNotification(
                    //       id: now.millisecondsSinceEpoch.remainder(100000) + 2,
                    //       title: 'Check-Out Reminder',
                    //       body: 'This is a test check-out reminder notification.',
                    //       scheduledDate: scheduled,
                    //       channel: AttendanceNotificationController.beforeCheckOutChannelKey,
                    //     );
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Check-Out Reminder scheduled for 2 min later')),
                    //     );
                    //   },
                    //   child: const Text('Test Check-Out Reminder'),
                    // ),
                  ],
                ),
              ),
            ),
         //   --- TEST NOTIFICATION BUTTONS END ---
            const SizedBox(height: 16),
            _buildHistoryTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFFFA726),
              child: Text(
                _userData.displayName.isNotEmpty ? _userData.displayName[0] : '',
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${_userData.displayName}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => _buildStatusChip(_attendanceController.currentUserStatus.value)),
                  const SizedBox(height: 8),
                  Obx(() => _buildGeofenceStatus()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(UserStatus status) {
    String text;
    Color color;

    switch (status) {
      case UserStatus.Online:
        text = 'Online';
        color = Colors.green;
        break;
      case UserStatus.Break:
        text = 'On Break';
        color = Colors.orange;
        break;
      case UserStatus.Offline:
      default:
        text = 'Offline';
        color = Colors.red;
        break;
    }

    return Chip(
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      avatar: const Icon(Icons.circle, color: Colors.white, size: 12),
    );
  }

  Widget _buildGeofenceStatus() {
    final isInGeofence = _attendanceController.isInGeofence.value;
    final geofenceName = _attendanceController.currentGeofenceName.value;

    return Row(
      children: [
        Icon(
          isInGeofence ? Icons.location_on : Icons.location_off,
          color: isInGeofence ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            isInGeofence ? "In Geofence: $geofenceName" : "Outside Geofence",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Obx(() {
      final status = _attendanceController.currentUserStatus.value;
      final isLoading = _attendanceController.isMarkAttendanceLoading.value;

      bool canCheckIn = status == UserStatus.Offline;
      bool canCheckOut = status == UserStatus.Online || status == UserStatus.Break;
      bool canTakeBreak = status == UserStatus.Online;
      bool canResume = status == UserStatus.Break;

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Builder(builder: (context) {
              bool canCheckInFinal = canCheckIn;
              final shiftInfo = Get.find<ShiftDetailsController>().getShiftInfo();
              final now = DateTime.now();
              final startTimeStr = shiftInfo['startTime'];
              final endTimeStr = shiftInfo['endTime'];
              DateTime? localStart;
              DateTime? localEnd;
              DateTime? graceEnd;
              if (startTimeStr != null && endTimeStr != null) {
                final partsStart = startTimeStr.split(':');
                final partsEnd = endTimeStr.split(':');
                int hourStart = int.parse(partsStart[0]);
                int minuteStart = int.parse(partsStart[1]);
                int secondStart = partsStart.length > 2 ? int.parse(partsStart[2]) : 0;
                int hourEnd = int.parse(partsEnd[0]);
                int minuteEnd = int.parse(partsEnd[1]);
                int secondEnd = partsEnd.length > 2 ? int.parse(partsEnd[2]) : 0;

                localStart = DateTime.utc(now.year, now.month, now.day, hourStart, minuteStart, secondStart).toLocal();
                localEnd = DateTime.utc(now.year, now.month, now.day, hourEnd, minuteEnd, secondEnd).toLocal();
                graceEnd = localEnd.add(const Duration(minutes: 15));

               // canCheckInFinal = now.isAfter(localStart) && now.isBefore(graceEnd);
                canCheckInFinal = status == UserStatus.Offline && now.isAfter(localStart) && now.isBefore(graceEnd);
              }
              print('DEBUG: status=$status, isLoading=$isLoading');
              print('DEBUG: now=$now, localStart=$localStart, localEnd=$localEnd, graceEnd=$graceEnd');
              print('DEBUG: canCheckInFinal=$canCheckInFinal');
              return _buildButton(
                context,
                icon: Icons.login,
                label: 'Check In',
                onPressed: canCheckInFinal && !isLoading
                    ? () async {
                  print('DEBUG: Button pressed, canCheckInFinal=$canCheckInFinal, isLoading=$isLoading');
                  final confirmed = await showConfirmationDialog(context, 'check in');
                  print('DEBUG: Confirmation result: $confirmed');
                  if (confirmed && canCheckInFinal) {
                    print('DEBUG: Calling updateUserStatus...');
                    await _attendanceController.updateUserStatus(newStatus: UserStatus.Online);
                    print('DEBUG: updateUserStatus completed');
                  } else {
                    print('DEBUG: Not calling updateUserStatus. confirmed=$confirmed, canCheckInFinal=$canCheckInFinal');
                  }
                }
                    : null,
                color: const Color(0xFF4CAF50),
              );
            }),
            _buildButton(
              context,
              icon: Icons.coffee,
              label: canResume ? 'Resume' : 'Break',
              onPressed: (canTakeBreak || canResume) && !isLoading
                  ? () {
                      if (canResume) {
                        _attendanceController.updateUserStatus(newStatus: UserStatus.Online);
                      } else {
                        _attendanceController.updateUserStatus(newStatus: UserStatus.Break);
                      }
                    }
                  : null,
              color: const Color(0xFFFB8C00),
            ),
            _buildButton(
              context,
              icon: Icons.logout,
              label: 'Check Out',
              onPressed: canCheckOut && !isLoading
                  ? () async {
                final confirmed = await showConfirmationDialog(context, 'check out');
                if (confirmed && canCheckOut) {
                  _attendanceController.updateUserStatus(newStatus: UserStatus.Offline);
                }
              }
                  : null,
              color: const Color(0xFFF44336),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildButton(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: onPressed != null ? color : Colors.grey.shade300,
            foregroundColor: Colors.white,
            elevation: onPressed != null ? 4 : 0,
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: onPressed != null ? Colors.black87 : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final shiftDetailsController = Get.find<ShiftDetailsController>();
    final shiftInfo = shiftDetailsController.getShiftInfo();
    final localStart = convertUtcToLocalTime(context, shiftInfo['startTime']);
    final localEnd = convertUtcToLocalTime(context, shiftInfo['endTime']);

    final attendance = _attendanceController.fetchUserAttendanceStatus.value;
    final checkInTime = attendance?.checkInTime;
    final checkOutTime = attendance?.checkOutTime;
    final workDuration = (checkInTime != null && checkOutTime != null)
        ? checkOutTime - checkInTime
        : null;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Column(
          children: [
            // First Row: Expected Start & End
            Row(
              children: [
                Expanded(
                  child: _summaryItem(
                    icon: Icons.schedule,
                    iconColor: Colors.orange,
                    label: 'Expected Start',
                    value: localStart,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: _summaryItem(
                    icon: Icons.schedule,
                    iconColor: Colors.deepOrange,
                    label: 'Expected End',
                    value: localEnd,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Second Row: Check In, Check Out, Work Duration
            Row(
              children: [
                Expanded(
                  child: _summaryItem(
                    icon: Icons.login,
                    iconColor: Colors.green,
                    label: 'Check In',
                    value: formatMillisToLocalTime(context, checkInTime),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: _summaryItem(
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    label: 'Check Out',
                    value: formatMillisToLocalTime(context, checkOutTime),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: _summaryItem(
                    icon: Icons.timer,
                    iconColor: Colors.blue,
                    label: 'Work Duration',
                    value: formatDuration(workDuration),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  String formatMillisToLocalTime(BuildContext context, int? millis) {
    if (millis == null) return '-';
    final dt = DateTime.fromMillisecondsSinceEpoch(millis).toLocal();
    final dateStr = DateFormat('d MMM yyyy').format(dt);
    final timeStr = TimeOfDay.fromDateTime(dt).format(context);
    return "$dateStr, $timeStr";
  }

  String formatDuration(int? millis) {
    if (millis == null || millis <= 0) return '-';
    final duration = Duration(milliseconds: millis);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String convertUtcToLocalTime(BuildContext context, String? utcTime) {
    if (utcTime == null) return '-';
    final parts = utcTime.split(':');
    if (parts.length < 2) return utcTime;
    final now = DateTime.now();
    final dtUtc = DateTime.utc(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    final dtLocal = dtUtc.toLocal();
    return TimeOfDay.fromDateTime(dtLocal).format(context);
  }

  DateTime getLocalTimeFromHHmm(String hhmm) {
    final now = DateTime.now();
    final parts = hhmm.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  DateTime getLocalTimeFromMillis(int millis) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day).add(Duration(milliseconds: millis));
  }

  String formatTime(BuildContext context, DateTime dt) {
    return TimeOfDay.fromDateTime(dt).format(context);
  }

  String trimSeconds(String? time) {
    if (time == null) return '-';
    final parts = time.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }
    return time;
  }

  Widget _buildSummaryItem(BuildContext context, IconData icon, String label, int? time) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFFFFA726), size: 28),
        const SizedBox(height: 4),
        Text(
          time != null ? _formatTime(context, time) : '--:--',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  Widget _buildWorkDurationSummary() {
    return Obx(() {
      final duration = Duration(milliseconds: _attendanceController.totalWorkDuration.value);
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      return Column(
        children: [
          Icon(Icons.access_time, color: Color(0xFFFFA726), size: 28),
          const SizedBox(height: 4),
          Text('$hours:$minutes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 2),
          const Text('Working Hours', style: TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      );
    });
  }

  Widget _buildHistoryTable(BuildContext context) {
    final history = _attendanceController.attendanceLog;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Check In', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Check Out', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Working Hours', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(),
            Obx(() {
              if (history.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No attendance history.'),
                );
              }
              return Column(
                children: List.generate(history.length, (index) {
                  final item = history[index];
                  final date = item['date'] != null
                      ? _formatDate(DateTime.fromMillisecondsSinceEpoch(item['date']))
                      : '--';
                  final checkIn = item['checkInTime'] != null
                      ? _formatTime(context, item['checkInTime'])
                      : '--:--';
                  final checkOut = item['checkOutTime'] != null
                      ? _formatTime(context, item['checkOutTime'])
                      : '--:--';
                  final workDuration = item['workDuration'] != null
                      ? _formatDuration(item['workDuration'])
                      : '--';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(date, style: const TextStyle(fontSize: 13))),
                        Expanded(child: Text(checkIn, style: const TextStyle(fontSize: 13))),
                        Expanded(child: Text(checkOut, style: const TextStyle(fontSize: 13))),
                        Expanded(child: Text(workDuration, style: const TextStyle(fontSize: 13, color: Colors.green))),
                      ],
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, int? milliseconds) {
    if (milliseconds == null) return '--:--';
    
    int normalizedMillis = _normalizeTimestamp(milliseconds);
    
    final now = DateTime.now().millisecondsSinceEpoch;
    if (normalizedMillis > now) {
      normalizedMillis = now;
    }
    
    final time = TimeOfDay(
      hour: (normalizedMillis / (1000 * 60 * 60)).floor() % 24,
      minute: (normalizedMillis / (1000 * 60)).floor() % 60,
    );
    return time.format(context);
  }
  
  int _normalizeTimestamp(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    
    if (timestamp.toString().length == 10) {
      final converted = timestamp * 1000;
      if (converted > now) {
        print('[TimeFormatDebug] ⚠️ Future timestamp detected after conversion, using current time');
        return now;
      }
      return converted;
    }
    else if (timestamp.toString().length == 13) {
      if (timestamp > now) {
        print('[TimeFormatDebug] ⚠️ Future timestamp detected, using current time');
        return now;
      }
      return timestamp;
    }
    else {
      if (timestamp > now) {
        print('[TimeFormatDebug] ⚠️ Future timestamp detected, using current time');
        return now;
      }
      return timestamp;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  Future<bool> showConfirmationDialog(BuildContext context, String action) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm $action'),
        content: Text('Are you sure you want to $action?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
  String _formatDuration(int milliseconds) {
    int normalizedMillis = _normalizeTimestamp(milliseconds);
    
    if (normalizedMillis < 0) {
      normalizedMillis = 0;
    }
    
    const maxDuration = 24 * 60 * 60 * 1000;
    if (normalizedMillis > maxDuration) {
      normalizedMillis = maxDuration;
    }
    
    final duration = Duration(milliseconds: normalizedMillis);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$hours:$minutes';
  }
} 