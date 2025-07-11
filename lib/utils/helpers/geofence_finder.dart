import 'package:geolocator/geolocator.dart';
import '../../models/geofence_location.dart';

class GeofenceFinder {
  static bool isPositionInsideGeofence(
      Position position, List<GeofenceLocation> geofences) {
    for (var geofence in geofences) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        geofence.latitude,
        geofence.longitude,
      );
      if (distance <= geofence.radius) {
        return true;
      }
    }
    return false;
  }

  static GeofenceLocation? findCurrentGeofence(
      Position position, List<GeofenceLocation> geofences) {
    for (var geofence in geofences) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        geofence.latitude,
        geofence.longitude,
      );
      if (distance <= geofence.radius) {
        return geofence;
      }
    }
    return null;
  }

  static Future<Position> getLiveLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static List<GeofenceLocation> findNearbyLocations(
      Position position, List<GeofenceLocation> geofences,
      {double radius = 5000}) {
    return geofences.where((geofence) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        geofence.latitude,
        geofence.longitude,
      );
      return distance <= radius;
    }).toList();
  }
} 