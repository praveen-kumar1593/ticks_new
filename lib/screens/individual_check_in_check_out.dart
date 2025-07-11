import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../controllers/attendance_controller.dart';
import '../models/user_data_singleton.dart';
import '../utils/user_status_enum.dart';
import '../utils/helpers/check_in_button_helper.dart';
import '../services/biometric/biometric_service.dart';
import '../modules/shift_details/controllers/shift_details_controller.dart';

class IndividualCheckInCheckOut extends StatelessWidget {
  IndividualCheckInCheckOut({super.key});

  final controller = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.fetchUserAttendanceStatus.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.fetchUserAttendanceStatus.value == null) {
            return _buildErrorScreen();
          } else {
            return _buildMainContent(context);
          }
        }),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unable to load attendance data',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await controller.getCombinedCurrentIndividualStatus();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeaderCard(),
          const SizedBox(height: 20),
          _buildTimeCard(),
          const SizedBox(height: 20),
          _buildBreakInfoCard(),
          const SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.person_outline,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Obx(() {
                  final status = controller.currentUserStatus.value;
                  return Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F2F5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 14,
                      color: status == UserStatus.Online
                          ? const Color(0xFF2ECC71)
                          : (status == UserStatus.Break
                              ? const Color(0xFFF39C12)
                              : Colors.grey.shade400),
                    ),
                  );
                }),
              )
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  Get.find<UserDataSingleton>().userName.value.isNotEmpty
                      ? Get.find<UserDataSingleton>().userName.value
                      : 'User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
                const SizedBox(height: 4),
                Obx(() {
                  final status = controller.currentUserStatus.value;
                  return Text(
                    status.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.5,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WORK DURATION',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final duration =
                Duration(milliseconds: controller.totalWorkDuration.value);
            String twoDigits(int n) => n.toString().padLeft(2, '0');
            final hours = twoDigits(duration.inHours);
            final minutes = twoDigits(duration.inMinutes.remainder(60));
            final seconds = twoDigits(duration.inSeconds.remainder(60));
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeItem(hours, 'Hours'),
                _buildTimeItem(minutes, 'Minutes'),
                _buildTimeItem(seconds, 'Seconds'),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeItem(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  String _formatTime(BuildContext context, int? milliseconds) {
    if (milliseconds == null) return 'N/A';
    final time = TimeOfDay(
      hour: (milliseconds / (1000 * 60 * 60)).floor() % 24,
      minute: (milliseconds / (1000 * 60)).floor() % 60,
    );
    return time.format(context);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Obx(() {
      final status = controller.currentUserStatus.value;
      final isLoading = controller.isMarkAttendanceLoading.value;
      final shiftController = Get.find<ShiftDetailsController>();
      final lastCheckOutTime = controller.fetchUserAttendanceStatus.value?.checkOutTime ?? 0;
      final canCheckIn = shiftController.canIndividualCheckIn(lastCheckOutTime: lastCheckOutTime);
      final validation = shiftController.validateIndividualCheckIn(lastCheckOutTime: lastCheckOutTime);

      if (isLoading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (status == UserStatus.Online) {
        // Check Out and Take Break should always be enabled when ONLINE
        return Row(
          children: [
            Expanded(
              child: _buildActionButton(
                label: 'Check Out',
                icon: Icons.stop_rounded,
                color: Colors.red.shade400,
                onPressed: () => _handleCheckOut(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                label: 'Take Break',
                icon: Icons.pause_rounded,
                color: Colors.orange.shade400,
                onPressed: () => _handleBreak(context),
              ),
            ),
          ],
        );
      }

      // Only apply shift validation to the Check In button
      final isCheckIn = status == UserStatus.Offline;
      String tooltipMessage = '';
      if (isCheckIn && !canCheckIn) {
        if (validation.is24Hrs) {
          tooltipMessage = 'Check-in allowed 24 hours today';
        } else if (validation.expectedStartTime != null && validation.expectedEndTime != null) {
          final startTime = _formatTime(context, validation.expectedStartTime);
          final endTime = _formatTime(context, validation.expectedEndTime);
          tooltipMessage = 'Check-in allowed from $startTime to $endTime';
        } else if (validation.expectedStartTime == null && validation.expectedEndTime == null) {
          tooltipMessage = 'Today is a leave day. Check-in not allowed.';
        } else {
          tooltipMessage = 'Check-in is not allowed at this time';
        }
      }

      // End Break should always be enabled when on break
      return Tooltip(
        message: tooltipMessage,
        child: _buildActionButton(
          label: isCheckIn ? 'Check In' : 'End Break',
          icon: Icons.play_arrow_rounded,
          color: isCheckIn ? Colors.green.shade500 : Colors.blue.shade500,
          onPressed: isCheckIn
              ? (canCheckIn ? () => _handleCheckIn(context) : null)
              : () => _handleEndBreak(context),
        ),
      );
    });
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        shadowColor: color.withOpacity(0.4),
      ),
    );
  }

  Widget _buildBreakInfoCard() {
    return Obx(() {
      final numberOfBreaks = controller.numberOfBreaksObs.value;
      final totalBreakDurationMs = controller.totalBreakDurationObs.value;
      final totalBreakDuration = Duration(milliseconds: totalBreakDurationMs);

      if (numberOfBreaks == 0) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildInfoRow(
              icon: Icons.pause_circle_outline,
              label: 'Breaks Taken',
              value: '$numberOfBreaks',
              color: Colors.orange.shade700,
            ),
            const Divider(height: 24, thickness: 0.5),
            _buildInfoRow(
              icon: Icons.timer_outlined,
              label: 'Total Break Time',
              value:
                  '${totalBreakDuration.inHours.toString().padLeft(2, '0')}:${(totalBreakDuration.inMinutes % 60).toString().padLeft(2, '0')} hrs',
              color: Colors.purple.shade700,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow(
      {required IconData icon,
      required String label,
      required String value,
      required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Future<void> _handleCheckIn(BuildContext context) async {
    final confirmed = await _showConfirmationDialog(
      context,
      'Check In',
      'Are you sure you want to check in?',
      Icons.play_arrow_rounded,
      Colors.green,
    );

    if (confirmed) {
      await controller.updateUserStatus(newStatus: UserStatus.Online);
    }
  }

  Future<void> _handleCheckOut(BuildContext context) async {
    final confirmed = await _showConfirmationDialog(
      context,
      'Check Out',
      'Are you sure you want to check out?',
      Icons.stop_rounded,
      Colors.red,
    );

    if (confirmed) {
      await controller.updateUserStatus(newStatus: UserStatus.Offline);
    }
  }

  Future<void> _handleBreak(BuildContext context) async {
    final confirmed = await _showConfirmationDialog(
      context,
      'Take Break',
      'Are you sure you want to take a break?',
      Icons.pause_rounded,
      Colors.orange,
    );

    if (confirmed) {
      await controller.updateUserStatus(newStatus: UserStatus.Break);
    }
  }

  Future<void> _handleEndBreak(BuildContext context) async {
    final confirmed = await _showConfirmationDialog(
      context,
      'End Break',
      'Are you sure you want to end your break?',
      Icons.play_arrow_rounded,
      Colors.blue,
    );

    if (confirmed) {
      await controller.updateUserStatus(newStatus: UserStatus.Online);
    }
  }

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color color,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              icon: Icon(icon, color: color, size: 48),
              title: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              content: Text(message, textAlign: TextAlign.center),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding:
                  const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child:
                            const Text('Cancel', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Confirm',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

// Status Badge Widget
Widget buildStatusBadge() {
  Color backgroundColor;
  Color textColor;
  IconData icon;

  final controller = Get.find<AttendanceController>();

  return Obx(() {
    switch (controller.currentUserStatus.value?.name.toLowerCase() ?? "") {
      case "online":
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        icon = Icons.circle;
        break;
      case "offline":
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        icon = Icons.circle;
        break;
      case "break":
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        icon = Icons.coffee;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        icon = Icons.circle;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: textColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            controller.currentUserStatus.value?.name.capitalizeFirst ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  });
} 