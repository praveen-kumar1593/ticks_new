import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import '../../utils/user_status_enum.dart';
import '../../services/biometric/biometric_service.dart';

class ConfirmationDialogHelper {
  static void showConfirmationDialog({
    required BuildContext context,
    required AttendanceController controller,
    required UserStatus userStatus,
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleConfirmation(context, controller, userStatus);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  static void _handleConfirmation(
    BuildContext context,
    AttendanceController controller,
    UserStatus userStatus,
  ) {
    BiometricFeature(
      context: context,
      onSuccess: () async {
        await controller.updateUserStatus(newStatus: userStatus);
      },
    ).checkAndAuthenticate();
  }
}

// Helper function to match awesometicks API
void confirmationDialogForBtn(
  BuildContext context,
  AttendanceController controller, {
  required UserStatus userStatus,
  required String title,
  required String content,
  required IconData icon,
  required Color color,
}) {
  ConfirmationDialogHelper.showConfirmationDialog(
    context: context,
    controller: controller,
    userStatus: userStatus,
    title: title,
    content: content,
    icon: icon,
    color: color,
  );
} 