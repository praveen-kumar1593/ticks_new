import 'dart:async';
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  Future<bool> _checkAndRequestPermission() async {
    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _checkAndRequestService() async {
    var serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<void> startLocationTracking() async {
    final hasPermission = await _checkAndRequestPermission();
    if (!hasPermission) {
      print("Location permission not granted.");
      return;
    }

    final serviceEnabled = await _checkAndRequestService();
    if (!serviceEnabled) {
      print("Location service not enabled.");
      return;
    }

    // To receive location when application is in background you have to enable it
    await _location.enableBackgroundMode(enable: true);

    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
      // Here you can handle the location update, e.g., send it to your API
      print('Location Update: ${currentLocation.latitude}, ${currentLocation.longitude}');
    });
  }

  Future<void> stopLocationTracking() async {
    await _locationSubscription?.cancel();
    await _location.enableBackgroundMode(enable: false);
  }

  Future<bool> isServiceRunning() async {
    return await _location.serviceEnabled();
  }
} 