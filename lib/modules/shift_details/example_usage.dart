// Example usage of ShiftDetailsController
// Add this to your main.dart or where you initialize your app

import 'package:get/get.dart';
import 'controllers/shift_details_controller.dart';

/// Example: How to register the ShiftDetailsController
void registerShiftDetailsController() {
  // Register the controller as a permanent singleton
  Get.put(ShiftDetailsController(), permanent: true);
  
  print('✅ ShiftDetailsController registered successfully');
}

/// Example: How to use the controller in your existing attendance flow
void exampleUsageInAttendance() {
  final shiftController = Get.find<ShiftDetailsController>();
  
  // The controller will automatically fetch shift details on init
  // You can also manually fetch or refresh:
  
  // Fetch shift details (will use cache if available)
  shiftController.fetchShiftDetails();
  
  // Force refresh from network
  shiftController.fetchShiftDetails(forceRefresh: true);
  
  // Check if user can check in
  final canCheckIn = shiftController.canIndividualCheckIn(
    lastCheckOutTime: DateTime.now().millisecondsSinceEpoch - 3600000, // 1 hour ago
  );
  
  print('Can check in: $canCheckIn');
  
  // Get shift information for attendance payload
  final shiftInfo = shiftController.getShiftInfo();
  final workingHours = shiftController.getCurrentDayWorkingHours();
  
  print('Shift info: $shiftInfo');
  print('Working hours: $workingHours');
}

/// Example: How to integrate with your existing attendance controller
void exampleIntegrationWithAttendanceController() {
  // In your existing attendance controller, you can now use:
  final shiftController = Get.find<ShiftDetailsController>();
  
  // Before marking attendance, validate the time
  final validation = shiftController.validateIndividualCheckIn(
    lastCheckOutTime: getLastCheckOutTime(), // Your existing method
  );
  
  if (validation.isValidTime) {
    // Proceed with attendance marking
    markAttendance();
  } else {
    // Show error message
    showError('Invalid time for check-in');
  }
}

/// Example: How to use in UI
void exampleUIUsage() {
  // In your widget:
  /*
  class AttendanceScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final shiftController = Get.find<ShiftDetailsController>();
      
      return Obx(() {
        if (shiftController.isLoading.value) {
          return CircularProgressIndicator();
        }
        
        final shiftInfo = shiftController.getShiftInfo();
        
        return Column(
          children: [
            if (shiftInfo['hasData']) ...[
              Text('Shift: ${shiftInfo['name']}'),
              Text('Time: ${shiftInfo['startTime']} - ${shiftInfo['endTime']}'),
            ],
            ElevatedButton(
              onPressed: () {
                final canCheckIn = shiftController.canIndividualCheckIn(
                  lastCheckOutTime: getLastCheckOutTime(),
                );
                
                if (canCheckIn) {
                  performCheckIn();
                } else {
                  showError('Cannot check in at this time');
                }
              },
              child: Text('Check In'),
            ),
          ],
        );
      });
    }
  }
  */
}

// Helper functions (replace with your actual implementations)
int getLastCheckOutTime() {
  // Your existing method to get last checkout time
  return DateTime.now().millisecondsSinceEpoch - 3600000;
}

void markAttendance() {
  // Your existing attendance marking logic
  print('Marking attendance...');
}

void showError(String message) {
  // Your existing error display logic
  print('Error: $message');
}

void performCheckIn() {
  // Your existing check-in logic
  print('Performing check-in...');
} 