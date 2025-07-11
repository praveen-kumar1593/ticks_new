import 'package:flutter/services.dart';

class NativeMethodChannel {
  static const MethodChannel _channel = MethodChannel('attendance_channel');

  static Future<void> startLocationService() async {
    try {
      await _channel.invokeMethod('startLocationService');
      print('Native location service started');
    } catch (e) {
      print('Error starting native location service: $e');
    }
  }

  static Future<void> stopLocationService() async {
    try {
      await _channel.invokeMethod('stopLocationService');
      print('Native location service stopped');
    } catch (e) {
      print('Error stopping native location service: $e');
    }
  }

  static Future<void> updateJobStatus({
    required String status,
    required String domain,
    required String emailid,
    required String mobile,
    required String identifier,
    required String name,
    required List<String> skills,
    required String type,
    required String username,
    required List<Map<String, dynamic>> geoFenceList,
  }) async {
    try {
      await _channel.invokeMethod('updateJobStatus', {
        'status': status,
        'domain': domain,
        'emailid': emailid,
        'mobile': mobile,
        'identifier': identifier,
        'name': name,
        'skills': skills,
        'type': type,
        'username': username,
        'geoFenceList': geoFenceList,
      });
      print('Native job status updated: $status');
    } catch (e) {
      print('Error updating native job status: $e');
    }
  }
} 