// import 'package:get/get.dart';
// import 'package:ferry/ferry.dart';
// import 'geofence_service.dart';
// import 'geofence_constants.dart';
//
// void exampleUsage(Client ferryClient) async {
//   // Register the service with GetX
//   final geofenceService = Get.put(GeofenceNewService());
//
//   // Fetch geofences from the API
//   await geofenceService.fetchGeofencesFromApi(
//     domain: "your_domain",
//     searchFields: {"category": listAllGeofenceCategory},
//   );
//
//   // Example user geofence ID and location point
//   String? userGeofenceId = "some-geofence-id";
//   Map<String, dynamic> userLocationPoint = {"lat": 12.9716, "lng": 77.5946};
//
//   // Match the user's geofence or set location fallback
//   geofenceService.setUserGeofenceOrLocation(
//     userGeofenceId: userGeofenceId,
//     userLocationPoint: userLocationPoint,
//   );
//
//   // Access the matched geofence (if any)
//   final matched = geofenceService.userGeofence.value;
//   if (matched != null) {
//     final map = matched.data?.value as Map<String, dynamic>?;
//     print('Matched geofence name: \\${map?['name']}');
//   } else {
//     print('No geofence matched, using location fallback.');
//   }
// }