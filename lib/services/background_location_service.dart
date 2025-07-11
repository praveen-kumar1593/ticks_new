import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticks_new/models/geofence_location.dart';

@pragma('vm:entry-point')
class BackgroundLocationService {
  static Timer? _locationTimer;
  static Timer? _backgroundTimer;
  static bool _isTracking = false;
  static StreamSubscription<Position>? _locationStream;
  
  // Background tracking settings
  static const Duration _backgroundInterval = Duration(minutes: 15); // Less frequent in background
  static const Duration _foregroundInterval = Duration(minutes: 5); // More frequent in foreground
  static const Duration _geofenceCheckInterval = Duration(minutes: 2); // Check geofence more frequently
  
  static Future<void> initializeService() async {
    try {
      // Initialize notifications for geofence events only
      await _initializeNotifications();
      
      // Restore tracking state from storage
      await _restoreTrackingState();
      
      print('Background location service initialized successfully');
    } catch (e) {
      print('Error initializing background location service: $e');
    }
  }
  
  static Future<void> _restoreTrackingState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wasTracking = prefs.getBool('background_location_tracking') ?? false;
      
      if (wasTracking) {
        print('Restoring background location tracking state');
        await startLocationTracking();
      }
    } catch (e) {
      print('Error restoring tracking state: $e');
    }
  }
  
  static Future<void> _initializeNotifications() async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      
      // Create geofence notification channel
      const AndroidNotificationChannel geofenceChannel = AndroidNotificationChannel(
        'geofence_channel',
        'Geofence Notifications',
        description: 'Notifications for geofence events',
        importance: Importance.high,
      );
      
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(geofenceChannel);
      
      print('Notification channels initialized successfully');
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }
  
  // Start location tracking with background support
  static Future<void> startLocationTracking() async {
    if (_isTracking) {
      print('Location tracking is already active');
      return;
    }
    
    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        return;
      }
      
      // Request background location permission for Android
      if (permission == LocationPermission.whileInUse) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always) {
          print('Background location permission not granted');
          // Continue with foreground-only tracking
        }
      }
      
      // Start multiple tracking methods
      await _startForegroundTracking();
      await _startBackgroundTracking();
      await _startGeofenceMonitoring();
      
      // Save tracking state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('background_location_tracking', true);
      await prefs.setInt('tracking_start_time', DateTime.now().millisecondsSinceEpoch);
      
      _isTracking = true;
      print('Location tracking started successfully (background enabled)');
    } catch (e) {
      print('Error starting location tracking: $e');
    }
  }
  
  // Foreground tracking (when app is active)
  static Future<void> _startForegroundTracking() async {
    try {
      // Get initial location
      await _getCurrentLocation();
      
      // Start periodic updates for foreground
      _locationTimer = Timer.periodic(_foregroundInterval, (timer) {
        _getCurrentLocation();
      });
      
      print('Foreground location tracking started');
    } catch (e) {
      print('Error starting foreground tracking: $e');
    }
  }
  
  // Background tracking (when app is in background or terminated)
  static Future<void> _startBackgroundTracking() async {
    try {
      // Use location stream for continuous background updates
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50, // Update every 50 meters
        timeLimit: Duration(minutes: 10), // Timeout after 10 minutes
      );
      
      _locationStream = Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position position) {
        _handleLocationUpdate(position);
      }, onError: (e) {
        print('Error in location stream: $e');
        // Fallback to periodic updates
        _startPeriodicBackgroundUpdates();
      });
      
      print('Background location stream started');
    } catch (e) {
      print('Error starting background tracking: $e');
      // Fallback to periodic updates
      _startPeriodicBackgroundUpdates();
    }
  }
  
  // Fallback periodic background updates
  static void _startPeriodicBackgroundUpdates() {
    _backgroundTimer = Timer.periodic(_backgroundInterval, (timer) {
      _getCurrentLocation();
    });
    print('Periodic background updates started');
  }
  
  // Geofence monitoring
  static Future<void> _startGeofenceMonitoring() async {
    try {
      // Check geofence status periodically
      Timer.periodic(_geofenceCheckInterval, (timer) {
        _checkGeofenceStatusFromCurrentLocation();
      });
      
      print('Geofence monitoring started');
    } catch (e) {
      print('Error starting geofence monitoring: $e');
    }
  }
  
  // Handle location updates from stream
  static Future<void> _handleLocationUpdate(Position position) async {
    try {
      final locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'altitude': position.altitude,
        'speed': position.speed,
        'speedAccuracy': position.speedAccuracy,
        'heading': position.heading,
        'altitudeAccuracy': position.altitudeAccuracy,
        'headingAccuracy': position.headingAccuracy,
        'timestamp': position.timestamp?.millisecondsSinceEpoch,
        'isMocked': position.isMocked,
        'source': 'background_stream',
      };
      
      print('Background location update: $locationData');
      
      // Save location data
      await _saveLocationData(locationData);
      
      // Check geofence
      await _checkGeofenceStatus(position);
      
    } catch (e) {
      print('Error handling location update: $e');
    }
  }
  
  // Stop location tracking
  static Future<void> stopLocationTracking() async {
    _locationTimer?.cancel();
    _backgroundTimer?.cancel();
    _locationStream?.cancel();
    _locationTimer = null;
    _backgroundTimer = null;
    _locationStream = null;
    _isTracking = false;
    
    // Save tracking state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('background_location_tracking', false);
    
    print('Location tracking stopped');
  }
  
  // Get current location
  static Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      final locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'altitude': position.altitude,
        'speed': position.speed,
        'speedAccuracy': position.speedAccuracy,
        'heading': position.heading,
        'altitudeAccuracy': position.altitudeAccuracy,
        'headingAccuracy': position.headingAccuracy,
        'timestamp': position.timestamp?.millisecondsSinceEpoch,
        'isMocked': position.isMocked,
        'source': 'periodic_update',
      };
      
      print('Location update: $locationData');
      
      // Save location data
      await _saveLocationData(locationData);
      
      // Check geofence
      await _checkGeofenceStatus(position);
      
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
  
  // Check geofence status from current location
  static Future<void> _checkGeofenceStatusFromCurrentLocation() async {
    try {
      final currentLocation = await getCurrentLocation();
      if (currentLocation != null) {
        final position = Position(
          latitude: currentLocation['latitude'],
          longitude: currentLocation['longitude'],
          timestamp: DateTime.fromMillisecondsSinceEpoch(currentLocation['timestamp']),
          accuracy: currentLocation['accuracy'] ?? 0,
          altitude: currentLocation['altitude'] ?? 0,
          heading: currentLocation['heading'] ?? 0,
          speed: currentLocation['speed'] ?? 0,
          speedAccuracy: currentLocation['speedAccuracy'] ?? 0,
          altitudeAccuracy: currentLocation['altitudeAccuracy'] ?? 0,
          headingAccuracy: currentLocation['headingAccuracy'] ?? 0,
          isMocked: currentLocation['isMocked'] ?? false,
        );
        
        await _checkGeofenceStatus(position);
      }
    } catch (e) {
      print('Error checking geofence status from current location: $e');
    }
  }
  
  static Future<void> _saveLocationData(Map<String, dynamic> locationData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationHistory = prefs.getStringList('location_history') ?? [];
      
      // Add new location to history
      locationHistory.add(jsonEncode(locationData));
      
      // Keep only last 200 locations (increased for background tracking)
      if (locationHistory.length > 200) {
        locationHistory.removeAt(0);
      }
      
      await prefs.setStringList('location_history', locationHistory);
      
      // Save current location
      await prefs.setString('current_location', jsonEncode(locationData));
      
      // Save last update time
      await prefs.setInt('last_location_update', DateTime.now().millisecondsSinceEpoch);
      
    } catch (e) {
      print('Error saving location data: $e');
    }
  }
  
  static Future<void> _checkGeofenceStatus(Position position) async {
    try {
      // Get geofence data from storage
      final prefs = await SharedPreferences.getInstance();
      final geofenceData = prefs.getString('geofence_data');
      
      if (geofenceData != null) {
        final geofences = jsonDecode(geofenceData) as List;
        
        for (var geofence in geofences) {
          final geofenceLocation = GeofenceLocation.fromJson(geofence);
          final distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            geofenceLocation.latitude,
            geofenceLocation.longitude,
          );
          
          final isInside = distance <= geofenceLocation.radius;
          final wasInside = prefs.getBool('geofence_${geofenceLocation.id}_inside') ?? false;
          
          if (isInside != wasInside) {
            // Geofence status changed
            await prefs.setBool('geofence_${geofenceLocation.id}_inside', isInside);
            
            final event = {
              'geofenceId': geofenceLocation.id,
              'geofenceName': geofenceLocation.name,
              'isInside': isInside,
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'distance': distance,
              'source': 'background_check',
            };
            
            print('Geofence event: $event');
            
            // Save geofence event
            final geofenceEvents = prefs.getStringList('geofence_events') ?? [];
            geofenceEvents.add(jsonEncode(event));
            
            if (geofenceEvents.length > 100) { // Increased for background tracking
              geofenceEvents.removeAt(0);
            }
            
            await prefs.setStringList('geofence_events', geofenceEvents);
            
            // Show notification for geofence change
            await _showGeofenceNotification(geofenceLocation, isInside);
          }
        }
      }
    } catch (e) {
      print('Error checking geofence status: $e');
    }
  }
  
  static Future<void> _showGeofenceNotification(GeofenceLocation geofence, bool isInside) async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      
      // Create geofence notification channel
      const AndroidNotificationChannel geofenceChannel = AndroidNotificationChannel(
        'geofence_channel',
        'Geofence Notifications',
        description: 'Notifications for geofence events',
        importance: Importance.high,
      );
      
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(geofenceChannel);
      
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'geofence_channel',
        'Geofence Notifications',
        channelDescription: 'Notifications for geofence events',
        importance: Importance.high,
        showWhen: true,
      );
      
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        'Geofence Update',
        isInside 
            ? 'You entered ${geofence.name}'
            : 'You left ${geofence.name}',
        platformChannelSpecifics,
      );
    } catch (e) {
      print('Error showing geofence notification: $e');
    }
  }
  
  // Start background service (simplified version)
  static Future<void> startBackgroundService() async {
    await startLocationTracking();
  }
  
  // Stop background service
  static Future<void> stopBackgroundService() async {
    await stopLocationTracking();
  }
  
  // Get current location from storage
  static Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationData = prefs.getString('current_location');
      
      if (locationData != null) {
        return jsonDecode(locationData) as Map<String, dynamic>;
      }
      
      return null;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }
  
  // Get location history
  static Future<List<Map<String, dynamic>>> getLocationHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationHistory = prefs.getStringList('location_history') ?? [];
      
      return locationHistory
          .map((location) => jsonDecode(location) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error getting location history: $e');
      return [];
    }
  }
  
  // Get geofence events
  static Future<List<Map<String, dynamic>>> getGeofenceEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final geofenceEvents = prefs.getStringList('geofence_events') ?? [];
      
      return geofenceEvents
          .map((event) => jsonDecode(event) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error getting geofence events: $e');
      return [];
    }
  }
  
  // Save geofence data
  static Future<void> saveGeofenceData(List<GeofenceLocation> geofences) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final geofenceData = geofences.map((geofence) => geofence.toJson()).toList();
      await prefs.setString('geofence_data', jsonEncode(geofenceData));
      print('Geofence data saved: ${geofences.length} geofences');
    } catch (e) {
      print('Error saving geofence data: $e');
    }
  }
  
  // Clear all stored data
  static Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('location_history');
      await prefs.remove('current_location');
      await prefs.remove('geofence_events');
      await prefs.remove('geofence_data');
      await prefs.remove('background_location_tracking');
      await prefs.remove('tracking_start_time');
      await prefs.remove('last_location_update');
      
      // Clear all geofence status flags
      final keys = prefs.getKeys();
      for (var key in keys) {
        if (key.startsWith('geofence_') && key.endsWith('_inside')) {
          await prefs.remove(key);
        }
      }
      
      print('All background location data cleared');
    } catch (e) {
      print('Error clearing background location data: $e');
    }
  }
  
  // Check if tracking is active
  static bool get isTracking => _isTracking;
  
  // Get tracking statistics
  static Future<Map<String, dynamic>> getTrackingStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final trackingStartTime = prefs.getInt('tracking_start_time');
      final lastUpdateTime = prefs.getInt('last_location_update');
      final locationHistory = prefs.getStringList('location_history') ?? [];
      final geofenceEvents = prefs.getStringList('geofence_events') ?? [];
      
      return {
        'isTracking': _isTracking,
        'trackingStartTime': trackingStartTime,
        'lastUpdateTime': lastUpdateTime,
        'totalLocations': locationHistory.length,
        'totalGeofenceEvents': geofenceEvents.length,
        'trackingDuration': trackingStartTime != null 
            ? DateTime.now().millisecondsSinceEpoch - trackingStartTime 
            : 0,
      };
    } catch (e) {
      print('Error getting tracking stats: $e');
      return {};
    }
  }
} 