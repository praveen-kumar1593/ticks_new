import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/r_colors.dart';
import '../constants/custom_text_style.dart';
import '../controllers/attendance_controller.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.find<AttendanceController>();

    return Scaffold(
      backgroundColor: RColors.backGroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildHistoryList(attendanceController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: RColors.orange,
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: RColors.pureWhite,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Attendance History',
                style: CustomTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: RColors.pureWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Track your attendance records',
            style: CustomTextStyle(
              fontSize: 16,
              color: RColors.pureWhite.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(AttendanceController controller) {
    return Obx(() {
      final history = controller.attendanceLog;
      
      if (history.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history_outlined,
                size: 64,
                color: RColors.darkGrey,
              ),
              const SizedBox(height: 16),
              Text(
                'No attendance history yet',
                style: CustomTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: RColors.darkGrey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your attendance records will appear here',
                style: CustomTextStyle(
                  fontSize: 14,
                  color: RColors.fadedGreyText,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return _buildHistoryCard(item, index);
        },
      );
    });
  }

  Widget _buildHistoryCard(Map<String, dynamic> item, int index) {
    final date = item['date'] != null
        ? DateTime.fromMillisecondsSinceEpoch(item['date'])
        : DateTime.now();
    final checkIn = item['checkInTime'] != null
        ? DateTime.fromMillisecondsSinceEpoch(item['checkInTime'])
        : null;
    final checkOut = item['checkOutTime'] != null
        ? DateTime.fromMillisecondsSinceEpoch(item['checkOutTime'])
        : null;
    final workDuration = item['workDuration'] != null
        ? Duration(milliseconds: item['workDuration'])
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: RColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, MMM d, yyyy').format(date),
                  style: CustomTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RColors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: RColors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Day ${index + 1}',
                    style: CustomTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: RColors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTimeInfo(
                    'Check In',
                    checkIn != null ? DateFormat('hh:mm a').format(checkIn) : '--:--',
                    Icons.login,
                    RColors.blue,
                  ),
                ),
                Expanded(
                  child: _buildTimeInfo(
                    'Check Out',
                    checkOut != null ? DateFormat('hh:mm a').format(checkOut) : '--:--',
                    Icons.logout,
                    RColors.darkRed,
                  ),
                ),
                Expanded(
                  child: _buildTimeInfo(
                    'Work Hours',
                    workDuration != null ? _formatDuration(workDuration) : '--:--',
                    Icons.access_time,
                    RColors.darkGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: CustomTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: RColors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: CustomTextStyle(
            fontSize: 12,
            color: RColors.fadedGreyText,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$hours:$minutes';
  }
} 