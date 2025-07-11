import 'dart:convert';

import 'package:ticks_new/modules/geofence/geofence_new_service.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/helpers/geofence_finder.dart' show GeofenceFinder;

/// Returns a tuple: (canCheckIn, geofenceName)
Future<Map<String, dynamic>> canUserCheckInOrOut() async {
  // 1. Get the assigned geofence ID for the user
  final String? assignedGeofenceId = await getAssignedGeofenceIdentifier(); // Use the helper function provided earlier

  // 2. Get the user's current location
  final position = await GeofenceFinder.getLiveLocation();
  final userLat = position.latitude;
  final userLng = position.longitude;

  // 3. Set geofence in the service (this will update userGeofence.value)
  final geofenceService = Get.find<GeofenceNewService>();
  geofenceService.setUserGeofenceOrLocation(
    userGeofenceId: assignedGeofenceId,
    userLocationPoint: {'lat': userLat, 'lng': userLng},
  );

  // 4. Check if user is allowed to check in/out
  final matched = geofenceService.userGeofence.value;
  String geoFenceName = '';
  bool canCheckIn = true;

  if (assignedGeofenceId != null && assignedGeofenceId.isNotEmpty) {
    if (matched == null) {
      // User is OUTSIDE the assigned geofence
      canCheckIn = false;
      geoFenceName = '';
    } else {
      // User is inside, allow check-in/check-out
      final map = matched.data?.value as Map<String, dynamic>?;
      geoFenceName = map?['name'] ?? '';
      canCheckIn = true;
    }
  } else {
    // No assigned geofence, allow check-in/check-out as per your business rule
    canCheckIn = true;
    geoFenceName = '';
  }

  return {
    'canCheckIn': canCheckIn,
    'geofenceName': geoFenceName,
    'userLat': userLat,
    'userLng': userLng,
  };
}
// Future<String?> getAssignedGeofenceIdentifier() async {
//   final prefs = await SharedPreferences.getInstance();
//   final findAssigneeJson = prefs.getString('findAssignee');
//   if (findAssigneeJson != null) {
//     final assigneeMap = jsonDecode(findAssigneeJson) as Map<String, dynamic>;
//     if (assigneeMap['geofence'] is Map) {
//       return assigneeMap['geofence']['identifier']?.toString();
//     }
//     // fallback for other possible keys
//     return assigneeMap['geofenceId']?.toString() ?? assigneeMap['geofence_id']?.toString();
//   }
//   return null;
// }
Future<String?> getAssignedGeofenceIdentifier() async {
  final prefs = await SharedPreferences.getInstance();
  final findAssigneeJson = prefs.getString('findAssignee');
  if (findAssigneeJson != null) {
    final assigneeMap = jsonDecode(findAssigneeJson) as Map<String, dynamic>;

    // Check if geofence exists and has identifier
    if (assigneeMap['geofence'] != null && assigneeMap['geofence'] is Map) {
      final geofenceData = assigneeMap['geofence'] as Map<String, dynamic>;
      final identifier = geofenceData['identifier']?.toString();
      print('Found geofence identifier: $identifier'); // Debug print
      return identifier;
    }

    // Fallback for other possible keys
    return assigneeMap['geofenceId']?.toString() ?? assigneeMap['geofence_id']?.toString();
  }
  return null;
}