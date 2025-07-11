# Shift Details Module

A comprehensive Flutter module for managing shift details, working hours, and attendance validation. This module provides a complete solution for handling shift-based and client working hour-based attendance validation.

## ✅ **Status: Ready to Use**

The module is **fully integrated** with your existing GraphQL setup and ready for use. All generated files are available and the service is configured to work with your Ferry GraphQL client.

## 📁 Module Structure

```
lib/modules/shift_details/
├── models/
│   ├── check_in_validation.dart
│   ├── shift_model.dart
│   ├── client_working_hour_model.dart
│   └── get_assignee_work_time_details_model.dart
├── services/
│   └── shift_details_service.dart
├── controllers/
│   └── shift_details_controller.dart
├── utils/
│   └── shift_validation_helper.dart
├── widgets/
│   └── shift_details_widget.dart
├── example_usage.dart
└── README.md
```

## 🚀 Quick Start

### 1. Register the Controller

In your `main.dart` or app initialization:

```dart
import 'package:get/get.dart';
import 'modules/shift_details/controllers/shift_details_controller.dart';

void main() {
  // Register the shift details controller
  Get.put(ShiftDetailsController(), permanent: true);
  
  runApp(MyApp());
}
```

### 2. Use the Controller

```dart
import 'package:get/get.dart';
import 'modules/shift_details/controllers/shift_details_controller.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shiftController = Get.find<ShiftDetailsController>();
    
    return Obx(() {
      if (shiftController.isLoading.value) {
        return CircularProgressIndicator();
      }
      
      // Use shift data
      final shiftInfo = shiftController.getShiftInfo();
      return Text('Shift: ${shiftInfo['name']}');
    });
  }
}
```

## 📋 Components

### Models

#### `CheckInValidation`
Represents the result of attendance validation:
- `isValidTime`: Whether the current time is valid for check-in
- `expectedStartTime`: Expected start time in milliseconds
- `expectedEndTime`: Expected end time in milliseconds
- `is24Hrs`: Whether it's a 24-hour shift
- `isCompeletedAttendance`: Whether attendance is already completed
- `inRestrictedUser`: List of restricted users (for team validation)

#### `Shift`
Represents shift information:
- `identifier`, `name`, `description`
- `startTime`, `endTime` (HH:mm format)
- `duration`, `domain`, `status`
- `allowedBreak`, `bufferTime` (in milliseconds)

#### `ClientWorkingHour`
Represents client working hours for each day of the week:
- Daily start/end times (in milliseconds)
- `allowedBreak`, `bufferTime`
- Helper methods for getting times by weekday

#### `GetAssigneeWorkTimeDetailsModel`
Main model containing both shift and client working hour data.

### Services

#### `ShiftDetailsService`
Handles data fetching and caching:
- ✅ **Fully integrated** with your existing Ferry GraphQL client
- Fetches shift details from GraphQL using generated code
- Caches data in SharedPreferences
- Provides cache management methods
- Handles offline/online scenarios

### Controllers

#### `ShiftDetailsController`
Main controller using GetX for state management:
- Manages shift details state
- Provides validation methods
- Handles loading and error states
- Offers utility methods for UI

### Utils

#### `ShiftValidationHelper`
Static utility class for validation logic:
- `openCheckInButton()`: Main validation method
- Handles both individual and team validation
- Supports shift-based and client working hour-based validation
- Includes buffer time calculations

## 🔧 Usage Examples

### Basic Usage

```dart
final controller = Get.find<ShiftDetailsController>();

// Fetch shift details
await controller.fetchShiftDetails();

// Check if user can check in
bool canCheckIn = controller.canIndividualCheckIn(
  lastCheckOutTime: lastCheckOutTime,
);

// Get shift information
final shiftInfo = controller.getShiftInfo();
```

### Validation

```dart
// Individual validation
final validation = controller.validateIndividualCheckIn(
  lastCheckOutTime: DateTime.now().millisecondsSinceEpoch - 3600000,
);

if (validation.isValidTime) {
  // Proceed with check-in
} else {
  // Show error message
}

// Team validation
final teamValidation = controller.validateTeamCheckIn(
  selectedMembersId: [1, 2, 3],
  teamMembers: teamMembersList,
);
```

### Working Hours

```dart
// Get today's working hours
final workingHours = controller.getCurrentDayWorkingHours();

if (workingHours['hasData']) {
  if (workingHours['type'] == '24_hours') {
    // 24-hour shift
  } else {
    // Regular hours
    final startTime = workingHours['startTime'];
    final endTime = workingHours['endTime'];
  }
}
```

### UI Integration

```dart
// Use the provided widget
ShiftDetailsWidget()

// Or build custom UI
Obx(() {
  final controller = Get.find<ShiftDetailsController>();
  
  return Column(
    children: [
      if (controller.hasShiftData) ...[
        Text('Shift: ${controller.shift?.name}'),
        Text('Time: ${controller.shift?.startTime} - ${controller.shift?.endTime}'),
      ],
      if (controller.lastValidation.value?.isValidTime == true)
        ElevatedButton(
          onPressed: () => performCheckIn(),
          child: Text('Check In'),
        ),
    ],
  );
});
```

## 🔄 Integration with Existing Code

### Replace Existing Validation

Instead of using your existing validation logic:

```dart
// Old way
CheckInValidation openCheckInButton({...}) {
  // Your existing validation logic
}

// New way
final controller = Get.find<ShiftDetailsController>();
final validation = controller.validateIndividualCheckIn(
  lastCheckOutTime: lastCheckOutTime,
);
```

### Update Attendance Payload

```dart
// Get shift details for attendance payload
final shiftInfo = controller.getShiftInfo();
final workingHours = controller.getCurrentDayWorkingHours();

final attendancePayload = {
  'userId': userId,
  'newStatus': status,
  'date': DateTime.now().toIso8601String(),
  'location': location,
  'locationName': locationName,
  'geofence': geofence,
  'attendanceId': attendanceId,
  'breakId': breakId,
  'statusSince': statusSince,
  'batteryLevel': batteryLevel,
  'deviceId': deviceId,
  // Add shift information
  'shiftId': shiftInfo['hasData'] ? shiftInfo['identifier'] : null,
  'shiftName': shiftInfo['hasData'] ? shiftInfo['name'] : null,
  'workingHoursType': workingHours['type'],
};
```

## ✅ **GraphQL Integration Complete**

The module is **fully integrated** with your existing GraphQL setup:

- ✅ Uses existing `getAssigneeWorkTimeDetails.graphql` query
- ✅ Uses generated Ferry GraphQL code
- ✅ Integrates with your existing Ferry client
- ✅ Handles all data conversion automatically
- ✅ No additional code generation needed

### How it works:

1. **Uses existing query**: The module uses your existing `lib/graphql/getAssigneeWorkTimeDetails.graphql` file
2. **Generated code**: Uses the already generated files in `lib/graphql/__generated__/`
3. **Ferry client**: Integrates with your existing Ferry GraphQL client
4. **Data conversion**: Automatically converts GraphQL data to your models

## 🧪 Testing

### Test Validation Logic

```dart
// Test individual validation
final validation = controller.validateIndividualCheckIn(
  lastCheckOutTime: DateTime.now().millisecondsSinceEpoch - 3600000,
);
print('Validation result: ${validation.toJson()}');

// Test team validation
final teamValidation = controller.validateTeamCheckIn(
  selectedMembersId: [1, 2],
  teamMembers: [
    {'userId': 1, 'userName': 'John', 'checkOutTime': 0},
    {'userId': 2, 'userName': 'Jane', 'checkOutTime': 0},
  ],
);
```

### Test Cache

```dart
// Check cache status
final cacheStatus = await controller.getCacheStatus();
print('Cache status: $cacheStatus');

// Clear cache
await controller.clearCache();
```

## 📱 Widget Usage

The module includes a complete widget for testing and demonstration:

```dart
// Navigate to the shift details widget
Get.to(() => ShiftDetailsWidget());
```

This widget provides:
- Shift information display
- Working hours information
- Validation status
- Action buttons for testing
- Cache management

## 🔍 Debugging

Enable debug logs by checking the console output. All components include detailed logging:

- `ShiftDetailsController`: Controller lifecycle and state changes
- `ShiftDetailsService`: Network and cache operations
- `ShiftValidationHelper`: Validation logic and decisions

## 📝 Notes

1. **✅ GraphQL Integration**: Fully integrated with your existing Ferry GraphQL setup
2. **Dependencies**: All required dependencies are already in your `pubspec.yaml`
3. **Error Handling**: The module includes comprehensive error handling and fallback mechanisms
4. **Performance**: Data is cached to minimize network requests and improve performance
5. **Offline Support**: The module works offline using cached data when available

## 🚀 **Ready to Use**

The module is **completely ready** for integration with your existing attendance system. Simply:

1. Register the controller in your `main.dart`
2. Use the controller methods in your existing attendance flow
3. Test with the provided widget

No additional setup or code generation required! 