import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../utils/unique_id_finder.dart';
import 'internet_services.dart';
import 'mqtt_controller.dart';

class MqttPublishMethod {
  static final MqttPublishMethod _instance = MqttPublishMethod._internal();
  
  factory MqttPublishMethod() {
    return _instance;
  }
  
  MqttPublishMethod._internal();

  var battery = Battery();
  Box? box;

  Future<int> getBatteryLevel() async {
    try {
      int batteryLevel = await battery.batteryLevel;
      return batteryLevel;
    } catch (e) {
      debugPrint('Error getting battery level: $e');
      return 0;
    }
  }

  static Future<void> publishUserAction({
    String? userId,
    String? type,
    String? domain,
    String? username,
    String? identifier,
    String? location,
    List<String>? skills,
    String? status,
    String? name,
    String? geofence,
    String? emailid,
    String? mobile,
    String? jobId,
    bool storedData = false,
  }) async {
    bool hasInternet = await InterNetServices.checkInternetConnectivity();

    Map<String, dynamic> userActionSendingData = {};
    MqttPublishMethod instance = MqttPublishMethod();
    
    try {
      instance.box = await Hive.openBox('mqtt_stored_user_action');
    } catch (e) {
      debugPrint('Error opening Hive box: $e');
      return;
    }

    if (storedData) {
      // Get all stored keys
      List<dynamic> storedKeys = instance.box!.keys.toList();

      for (var key in storedKeys) {
        var mqttData = instance.box!.get(key);
        if (mqttData != null) {
          try {
            CustomMqttController mqttController = Get.find<CustomMqttController>();
            mqttController.publishMessage(
              topic: '${CustomMqttController.liveBulkTrackingTopic}/${mqttData["id"]}',
              message: jsonEncode(mqttData),
            );
            instance.box!.delete(key);
          } catch (e) {
            debugPrint('Error publishing stored data: $e');
          }
        }
      }
      return;
    }

    if (userId != null) userActionSendingData['id'] = userId;
    if (type != null) userActionSendingData["type"] = type;
    userActionSendingData["time"] = DateTime.now().millisecondsSinceEpoch;
    userActionSendingData["deviceId"] = await fetchTheUniqueDeviceId();
    if (domain != null) userActionSendingData["domain"] = domain;
    if (username != null) userActionSendingData["username"] = username;
    if (identifier != null) userActionSendingData["identifier"] = identifier;
    if (location != null) userActionSendingData["location"] = location;
    userActionSendingData["batteryLevel"] = await instance.getBatteryLevel();
    if (skills != null) userActionSendingData["skills"] = skills;
    if (status != null) userActionSendingData["status"] = status;
    if (name != null) userActionSendingData["name"] = name;
    if (geofence != null) userActionSendingData["geofence"] = geofence;
    if (emailid != null) userActionSendingData["emailid"] = emailid;
    if (mobile != null) userActionSendingData["mobile"] = mobile;
    if (jobId != null) userActionSendingData["jobId"] = jobId;

    if (hasInternet) {
      debugPrint(
        "MQTT topic: ${CustomMqttController.liveTrackingTopic}/$userId\n"
        "Message: ${jsonEncode(userActionSendingData)}",
      );
      
      try {
        Get.find<CustomMqttController>().publishMessage(
          topic: '${CustomMqttController.liveTrackingTopic}/$userId',
          message: jsonEncode(userActionSendingData),
        );
      } catch (e) {
        debugPrint('Error publishing MQTT message: $e');
        // Store locally if MQTT controller is not available
        instance.box?.add(userActionSendingData);
      }
    } else {
      instance.box?.add(userActionSendingData);
    }
  }
}

Future<String> fetchTheUniqueDeviceId() async {
  try {
    final deviceInfo = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown';
    }
    
    return 'unknown';
  } catch (e) {
    print('Error getting device ID: $e');
    return 'unknown';
  }
} 