import 'package:get/get.dart';
import '../models/geofence_location.dart';

class GeofenceService extends GetxController {
  final Rx<Map<String, dynamic>?> userGeoFenceData = Rx<Map<String, dynamic>?>(null);
  final Rx<Map<String, dynamic>?> allGeofenceData = Rx<Map<String, dynamic>?>(null);

  void setUserGeofenceData(Map<String, dynamic> data) {
    userGeoFenceData.value = data;
  }

  void setAllGeofenceData(Map<String, dynamic> data) {
    allGeofenceData.value = data;
  }

  void clearGeofenceData() {
    userGeoFenceData.value = null;
    allGeofenceData.value = null;
  }
  
  Map<String, dynamic>? getAllGeofenceData() {
    return allGeofenceData.value;
  }
  
  List<GeofenceLocation> getGeofenceLocations() {
    if (allGeofenceData.value != null && allGeofenceData.value!['data'] != null) {
      final data = allGeofenceData.value!['data'] as List;
      return data.map((item) => GeofenceLocation.fromJson(item)).toList();
    }
    return [];
  }
}

List<Map<String, dynamic>> getGeofenceData(GeofenceService geofenceService) {
  if (geofenceService.userGeoFenceData.value != null) {
    return [geofenceService.userGeoFenceData.value!];
  } else if (geofenceService.allGeofenceData.value != null &&
             geofenceService.allGeofenceData.value!['data'] != null) {
    return List<Map<String, dynamic>>.from(geofenceService.allGeofenceData.value!['data']);
  }
  return [];
} 