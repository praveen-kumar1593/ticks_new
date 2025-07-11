import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;

import '../constants/custom_snackbar.dart';
import '../graphql/__generated__/fetchUserAttendanceStatus.req.gql.dart';
import '../graphql/__generated__/markUserAttendance.req.gql.dart';
import '../graphql/__generated__/markUserAttendance.var.gql.dart';
import '../graphql/__generated__/markAttendanceSync.req.gql.dart';
import '../graphql/__generated__/markAttendanceSync.var.gql.dart';
import '../graphql/__generated__/schema.schema.gql.dart';
import '../models/fetch_user_attendance_status.dart';
import 'graphql_client_services.dart';
import 'storage_services.dart';
import '../models/user_data_singleton.dart';

class IndividualAttendanceService {
  static final IndividualAttendanceService _instance = IndividualAttendanceService._internal();
  
  factory IndividualAttendanceService() {
    return _instance;
  }
  
  IndividualAttendanceService._internal();

  final GraphQLClientService _apiClient = Get.find<GraphQLClientService>();

  // ================================================================================
  // HYBRID APPROACH: Network First, Local Fallback
  // ================================================================================

  Future<Map<String, dynamic>?> getInitialIndividualStatusCombined() async {
    try {
      bool hasInternet = await _checkInternetConnectivity();
      debugPrint("🌐 Internet connectivity: $hasInternet");

      if (hasInternet) {
        log("🌐 Fetching data from network");
        var networkData = await getInitialIndividualStatusFromNetwork();
        debugPrint("🌐 Network data result: $networkData");

        if (networkData != null) {
          log("💾 Saving network data to local storage");
          
          // Parse network data to our model
          FetchUserAttendanceStatus userAttendanceStatus = 
              FetchUserAttendanceStatus.fromJson(networkData['fetchUserAttendanceStatus']);

          // Save to local storage
          await _saveIndividualStatusToLocal(userAttendanceStatus);

          log("✅ Network data stored locally");
          debugPrint("✅ Returning network data: $networkData");
          return networkData;
        } else {
          log("❌ No network data received, trying local storage");
        }
      }
      
      // If no internet or no network data, try local storage
      debugPrint("📱 Fetching data from local storage");
      var localData = await _getIndividualStatusFromLocal();
      debugPrint("📱 Local data result: $localData");

      if (localData != null) {
        var localAttendanceRecords = await getOfflineAttendanceRecords();
        debugPrint("📱 Offline records count: ${localAttendanceRecords.length}");

        if (localAttendanceRecords.isNotEmpty) {
          debugPrint("🔄 Syncing offline records with local data");
          
          var updatedLocalData = _syncOfflineRecordsLocally(
            offlineRecords: localAttendanceRecords,
            fetchStatus: localData,
          );

          await _saveIndividualStatusToLocal(updatedLocalData);
          localData = await _getIndividualStatusFromLocal();
        }

        // Convert local data to same format as network data
        final result = {
          "fetchUserAttendanceStatus": localData!.toJson(),
        };
        debugPrint("📱 Returning local data: $result");
        return result;
      } else {
        debugPrint("❌ No data available in local storage");
        return null;
      }
    } catch (err, trace) {
      debugPrint("❌ Error in getInitialIndividualStatusCombined: $err");
      debugPrint("Stack trace: $trace");
      return null;
    }
  }

  // ================================================================================
  // NETWORK OPERATIONS
  // ================================================================================

  Future<Map<String, dynamic>?> getInitialIndividualStatusFromNetwork() async {
    try {
      final request = GfetchUserAttendanceStatusReq();
      final response = await _apiClient.request(request);

      debugPrint("🔍 GraphQL Response: $response");
      debugPrint("🔍 Response has errors: ${response.hasErrors}");
      debugPrint("🔍 Response data: ${response.data}");
      debugPrint("🔍 Response data is null: ${response.data == null}");
      debugPrint("🔍 fetchUserAttendanceStatus: ${response.data?.fetchUserAttendanceStatus}");
      debugPrint("🔍 Response data type: ${response.data.runtimeType}");
      
      if (response.data != null) {
        debugPrint("🔍 Response data fields: ${response.data!.toJson()}");
      }

      // Since we know the raw response data is available but the typed response is null,
      // let's try to access the raw response directly
      try {
        // Access the raw response through reflection
        final dynamicResponse = response as dynamic;
        
        // Try different ways to access the raw data
        Map<String, dynamic>? rawData;
        
        // Method 2: Try to access response property
        if (rawData == null) {
          try {
            if (dynamicResponse.response != null && dynamicResponse.response.data != null) {
              rawData = dynamicResponse.response.data as Map<String, dynamic>;
              debugPrint("🔍 Raw response data found (method 2): $rawData");
            }
          } catch (e) {
            debugPrint("❌ Method 2 failed: $e");
          }
        }
        
        // Method 3: Try to access data property directly
        if (rawData == null) {
          try {
            if (dynamicResponse.data != null) {
              rawData = dynamicResponse.data as Map<String, dynamic>;
              debugPrint("🔍 Raw response data found (method 3): $rawData");
            }
          } catch (e) {
            debugPrint("❌ Method 3 failed: $e");
          }
        }
        
        // If we found raw data, use it
        if (rawData != null && rawData.containsKey('fetchUserAttendanceStatus')) {
          log("✅ Raw network data received: $rawData");
          return rawData;
        }
      } catch (rawError) {
        debugPrint("❌ Raw response access error: $rawError");
      }

      // If GraphQL client failed, try HTTP fallback
      debugPrint("🔄 Trying HTTP fallback...");
      final httpData = await _fetchDataWithHttp();
      if (httpData != null) {
        return httpData;
      }

      // Check if we have data first, even if there are errors
      if (response.data != null && response.data!.fetchUserAttendanceStatus != null) {
        log("✅ Network data received: ${response.data}");
        
        // Convert GraphQL response to JSON format
        final graphqlData = response.data!.fetchUserAttendanceStatus!;
        debugPrint("🔍 GraphQL data: $graphqlData");
        debugPrint("🔍 GraphQL data type: ${graphqlData.runtimeType}");
        
        try {
          // Use direct JSON conversion
          final directJson = graphqlData.toJson();
          debugPrint("🔍 Direct JSON conversion: $directJson");
          
          final result = {
            'fetchUserAttendanceStatus': directJson,
          };
          
          debugPrint("🔍 Final result: $result");
          return result;
        } catch (jsonError) {
          debugPrint("❌ JSON conversion error: $jsonError");
          // Try alternative conversion method
          try {
            final result = {
              'fetchUserAttendanceStatus': graphqlData.toString(),
            };
            debugPrint("🔍 Alternative result: $result");
            return result;
          } catch (altError) {
            debugPrint("❌ Alternative conversion error: $altError");
            return null;
          }
        }
      }

      // Log errors if no data is available
      if (response.hasErrors) {
        debugPrint("❌ Network query errors: ${response.graphqlErrors}");
        debugPrint("❌ GraphQL errors count: ${response.graphqlErrors?.length}");
        if (response.graphqlErrors != null) {
          for (int i = 0; i < response.graphqlErrors!.length; i++) {
            debugPrint("❌ Error $i: ${response.graphqlErrors![i]}");
          }
        }
      }

      debugPrint("❌ No valid data in response");
      return null;
    } catch (err, trace) {
      debugPrint("❌ Error in getInitialIndividualStatusFromNetwork: $err");
      debugPrint("Stack trace: $trace");
      return null;
    }
  }

  Future<Map<String, dynamic>> markUserAttendanceToNetwork({
    required Map<String, dynamic> dataToNetwork,
  }) async {
    var resultData = {
      "success": false,
      "message": "Network problem",
      "data": {},
    };

    try {
      final inputData = GUserAttendanceInput((b) => b
        ..userId = (dataToNetwork['userId'] is String ? int.tryParse(dataToNetwork['userId']) ?? dataToNetwork['userId'] : dataToNetwork['userId'])
        ..newStatus = dataToNetwork['newStatus']
       ..statusSince = (dataToNetwork['statusSince'] as num?)?.toDouble()
        ..locationName = dataToNetwork['locationName']?.toString()
        ..location = dataToNetwork['location']?.toString()
        ..attendanceId = dataToNetwork['attendanceId']
        ..breakId = dataToNetwork['breakId']
        ..geofence = dataToNetwork['geofence']?.toString()
        ..batteryLevel = dataToNetwork['batteryLevel']
        ..deviceId = dataToNetwork['deviceId']?.toString()
      );

      final request = GMarkUserAttendanceReq(
        (b) => b..vars.data.replace(inputData),
      );
      final response = await _apiClient.request(request);

      log("📤 Network mutation result: ${response.data}");
      log("📤 Network mutation graphqlErrors: ${response.graphqlErrors}");
      log("📤 Network mutation errors: ${response.hasErrors}");
      log("📦 Payload: $dataToNetwork");

      if (response.hasErrors) {
        debugPrint("❌ Network mutation errors: ${response.graphqlErrors}");
        rShowCustomSnackbar(message: "User Status Updated Successfully", snackbarType: SnackbarType.success);

       // resultData['message'] = "User Status Updated Successfully";
        return resultData;
      }

      if (response.data != null && response.data!.markUserAttendance != null) {
        final result = response.data!.markUserAttendance!;
        // Add debug log for comparison
        log("Comparing: result.newStatus=[32m");
        log("Comparing: result.newStatus=${result.newStatus}, dataToNetwork['newStatus']=${dataToNetwork['newStatus']}");
        // Check if the response matches our request
        if (result.newStatus == dataToNetwork['newStatus']) {
          resultData['success'] = true;
          resultData['message'] = "User Status Updated Successfully!";
          resultData['data'] = {
            'newStatus': result.newStatus,
            'attendanceId': result.attendanceId,
          };
          return resultData;
        }
      }

      resultData['success'] = false;
      resultData['message'] = 'User Status Not Updated';
      resultData['data'] = {};
      return resultData;
    } catch (err, trace) {
      debugPrint("❌ Error in markUserAttendanceToNetwork: $err");
      debugPrint("Stack trace: $trace");
      resultData['message'] = "Something went wrong!";
      return resultData;
    }
  }

  // ================================================================================
  // LOCAL STORAGE OPERATIONS
  // ================================================================================

  Future<void> _saveIndividualStatusToLocal(FetchUserAttendanceStatus status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('individual_attendance_status', json.encode(status.toJson()));
      debugPrint("💾 Individual status saved to local storage");

    } catch (e) {
      debugPrint("❌ Error saving individual status to local: $e");
    }
  }

  Future<FetchUserAttendanceStatus?> _getIndividualStatusFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? statusJson = prefs.getString('individual_attendance_status');
      
      if (statusJson != null) {
        Map<String, dynamic> statusMap = json.decode(statusJson);
        return FetchUserAttendanceStatus.fromJson(statusMap);
      }
      return null;
    } catch (e) {
      debugPrint("❌ Error getting individual status from local: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> markUserAttendanceToLocal({
    required Map<String, dynamic> dataToLocal,
  }) async {
    debugPrint("📱 Saving attendance to local storage: $dataToLocal");

    Map<String, dynamic> resultData = {
      "success": false,
      "message": "Something went wrong!",
      "data": {},
    };

    try {
      // Ensure userId is included in the offline record as a number.
      var userIdStr = Get.find<UserDataSingleton>().userId;
      int? userIdNum = int.tryParse(userIdStr);
      if (userIdNum == null) {
        debugPrint('[ERROR] Invalid userId when saving offline: $userIdStr');
        resultData['success'] = false;
        resultData['message'] = 'Invalid userId, cannot save offline record.';
        return resultData;
      }
      dataToLocal['userId'] = userIdNum;

      await _saveOfflineAttendance(dataToLocal);
      resultData["success"] = true;
      resultData["message"] = "User Status Updated Successfully!";
      resultData["data"] = {};

      return resultData;
    } catch (err, trace) {
      debugPrint("❌ Error in markUserAttendanceToLocal: $err");
      debugPrint("Stack trace: $trace");

      resultData['success'] = false;
      resultData['message'] = 'User Status Not Updated';
      resultData['data'] = {};
      return resultData;
    }
  }

  // ================================================================================
  // OFFLINE RECORD MANAGEMENT
  // ================================================================================

  Future<void> _saveOfflineAttendance(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Generate unique ID for offline record
      String recordId = DateTime.now().millisecondsSinceEpoch.toString();
      data['id'] = recordId;
      data['timestamp'] = DateTime.now().toIso8601String();
      
      // Get existing offline records
      List<String> offlineRecords = prefs.getStringList('offline_attendance_records') ?? [];
      
      // Add new record
      offlineRecords.add(json.encode(data));
      
      // Save back to preferences
      await prefs.setStringList('offline_attendance_records', offlineRecords);
      
      debugPrint("💾 Offline attendance record saved: $recordId");
    } catch (e) {
      debugPrint("❌ Error saving offline attendance: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getOfflineAttendanceRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> offlineRecords = prefs.getStringList('offline_attendance_records') ?? [];
      debugPrint('[DEBUG] Raw offline records: ' + offlineRecords.toString());
      return offlineRecords.map((record) {
        try {
          final decoded = json.decode(record) as Map<String, dynamic>;
          debugPrint('[DEBUG] Decoded offline record: ' + decoded.toString());
          return decoded;
        } catch (e, stack) {
          debugPrint('[ERROR] Failed to decode offline record: $record');
          debugPrint('[ERROR] Exception: $e');
          debugPrint('[ERROR] Stack: $stack');
          return <String, dynamic>{};
        }
      }).toList();
    } catch (e, stack) {
      debugPrint('[ERROR] Error getting offline attendance records: $e');
      debugPrint('[ERROR] Stack: $stack');
      return [];
    }
  }

  Future<void> deleteOfflineAttendanceRecord(String recordId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> offlineRecords = prefs.getStringList('offline_attendance_records') ?? [];
      
      // Remove the record with the specified ID
      offlineRecords.removeWhere((record) {
        final data = json.decode(record) as Map<String, dynamic>;
        return data['id'] == recordId;
      });
      
      // Save back to preferences
      await prefs.setStringList('offline_attendance_records', offlineRecords);
      debugPrint("🗑️ Offline record deleted: $recordId");
    } catch (e) {
      debugPrint('❌ Error deleting offline attendance record: $e');
    }
  }

  Future<void> clearAllOfflineRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('offline_attendance_records');
      debugPrint("🗑️ All offline records cleared");
    } catch (e) {
      debugPrint('❌ Error clearing offline records: $e');
    }
  }

  Future<int> getOfflineRecordsCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> offlineRecords = prefs.getStringList('offline_attendance_records') ?? [];
      return offlineRecords.length;
    } catch (e) {
      debugPrint('❌ Error getting offline records count: $e');
      return 0;
    }
  }

  // ================================================================================
  // OFFLINE SYNC OPERATIONS
  // ================================================================================

  Future<Map<String, dynamic>> syncIndividualOfflineRecordsToNetwork({
    bool forceCheckOut = false,
    Map<String, dynamic> dataPayload = const {},
  }) async {
    Map<String, dynamic> resultData = {
      "success": false,
      "message": "No records to sync",
      "data": {},
    };

    try {
      var offlineRecords = await getOfflineAttendanceRecords();
      debugPrint("📱 Offline records to sync: $offlineRecords");

      if (!forceCheckOut) {
        if (offlineRecords.isEmpty) {
          resultData["message"] = "No offline records found to sync";
          return resultData;
        }
      }

      debugPrint("🔄 Starting sync of ${offlineRecords.length} offline records");

      var dataToSync = <GUserAttendanceBulkInput>[];

      if (forceCheckOut) {
        // Convert single payload to GUserAttendanceBulkInput
        var userIdRaw = dataPayload['userId'];
        double? userId;
        if (userIdRaw is double) {
          userId = userIdRaw;
        } else if (userIdRaw is int) {
          userId = userIdRaw.toDouble();
        } else if (userIdRaw is String) {
          userId = double.tryParse(userIdRaw);
        }
        if (userId == null) {
          debugPrint('❌ Invalid userId for forceCheckOut: $userIdRaw');
          resultData["message"] = "Invalid user ID for force checkout";
          return resultData;
        }
        final newStatus = dataPayload['newStatus']?.toString() ?? 'OFFLINE';
        dataToSync.add(GUserAttendanceBulkInput((b) => b
          ..userId = userId!
          ..date = (GDatetimeBuilder()..value = DateTime.now().toIso8601String())
          ..newStatus = newStatus
        ));
      } else {
        // Convert offline records to GUserAttendanceBulkInput list
        for (var record in offlineRecords) {
          var userIdRaw = record["userId"];
          double? userId;
          if (userIdRaw is double) {
            userId = userIdRaw;
          } else if (userIdRaw is int) {
            userId = userIdRaw.toDouble();
          } else if (userIdRaw is String) {
            userId = double.tryParse(userIdRaw);
          }
          if (userId == null) {
            debugPrint('⚠️ Skipping record with invalid userId: $userIdRaw in $record');
            // Also delete this invalid record so we don't try it again.
            if (record['id'] != null) {
              await deleteOfflineAttendanceRecord(record['id']);
              debugPrint("🗑️ Deleted invalid offline record: "+record['id'].toString());
            }
            continue;
          }
          final newStatus = record["newStatus"]?.toString() ?? 'OFFLINE';
          final statusSince = record["statusSince"];
          DateTime recordDate;
          if (statusSince != null && statusSince is int) {
            recordDate = DateTime.fromMillisecondsSinceEpoch(statusSince);
          } else {
            recordDate = DateTime.now();
          }
          dataToSync.add(GUserAttendanceBulkInput((b) => b
            ..userId = userId
            ..date = (GDatetimeBuilder()..value = DateTime.now().toIso8601String())
            ..newStatus = newStatus
          ));
        }
      }

      if (dataToSync.isEmpty) {
        resultData["message"] = "No valid records to sync";
        return resultData;
      }

      debugPrint("📤 Records to sync: ${dataToSync.length} items");

      // Clean and prepare records for sync
      List<Map<String, dynamic>> cleanedRecords = dataToSync.map((record) {
        final map = record.toJson();
        map.remove('date');
        // userId and statusSince should be double (for backend Float)
        for (final key in ['userId', 'statusSince']) {
          if (map[key] != null && map[key] is! double) {
            map[key] = double.tryParse(map[key].toString());
          }
        }
        // attendanceId, breakId, batteryLevel should be int
        for (final key in ['attendanceId', 'breakId', 'batteryLevel']) {
          if (map.containsKey(key) && map[key] != null && map[key] is! int) {
            map[key] = int.tryParse(map[key].toString());
          }
        }
        // All other fields: ensure string if schema says so
        for (final key in ['newStatus', 'location', 'locationName', 'geofence', 'deviceId']) {
          if (map.containsKey(key) && map[key] != null && map[key] is! String) {
            map[key] = map[key].toString();
          }
        }
        debugPrint('🟢 Cleaned record for sync: ' + map.toString() + '\nTypes: userId=${map['userId']?.runtimeType}, statusSince=${map['statusSince']?.runtimeType}, attendanceId=${map['attendanceId']?.runtimeType}, breakId=${map['breakId']?.runtimeType}, batteryLevel=${map['batteryLevel']?.runtimeType}');
        return map;
      }).toList();

      for (final map in cleanedRecords) {
        debugPrint('🟢 About to convert to GUserAttendanceBulkInput: ' + map.toString());
      }
      final inputObjects = cleanedRecords.map((m) => GUserAttendanceBulkInput.fromJson(m)).toList();
      // 3. Use inputObjects.toBuiltList() in the mutation variables
      final request = GmarkAttendanceSyncReq((b) => b
        ..vars.data.replace(inputObjects.toBuiltList())
      );
      final response = await _apiClient.request(request);

      debugPrint('📤 Full sync response: \\n${response.data}');
      debugPrint('📤 GraphQL errors: \\n${response.graphqlErrors}');
      debugPrint('📤 Link exception: \\n${response.linkException}');

      if (response.hasErrors) {
        resultData["success"] = false;
        resultData["message"] = "Error during sync";
        debugPrint("❌ Sync errors: ${response.graphqlErrors}");
        return resultData;
      }

      if (response.data?.markAttendanceSync != null) {
        final syncResult = response.data!.markAttendanceSync!;
        if (syncResult.status == "SUCCESS") {
          await clearAllOfflineRecords();
          resultData["success"] = true;
          resultData["message"] = "Attendance Synced Successfully!";
          debugPrint("✅ Offline records synced successfully");
          rShowCustomSnackbar(message: "Attendance Synced Successfully!", snackbarType: SnackbarType.success);
          return resultData;
        } else {
          resultData["success"] = false;
          resultData["message"] = "An Error Occurred While Syncing";
          rShowCustomSnackbar(message: "An Error Occurred While Syncing", snackbarType: SnackbarType.error);
          return resultData;
        }
      } else {
        resultData["success"] = false;
        resultData["message"] = "No response from sync operation";
        rShowCustomSnackbar(message: "No response from sync operation", snackbarType: SnackbarType.error);
        return resultData;
      }
    } catch (err, trace) {
      debugPrint("❌ Error in syncIndividualOfflineRecordsToNetwork: $err");
      debugPrint("Stack trace: $trace");
      resultData["message"] = "Error during sync: $err";
    }

    return resultData;
  }

  Future<Map<String, dynamic>> syncIndividualOfflineRecordsToNetworkV2({
    bool forceCheckOut = false,
    Map<String, dynamic> dataPayload = const {},
  }) async {
    Map<String, dynamic> resultData = {
      "success": false,
      "message": "No records to sync",
      "data": {},
    };

    try {
      var offlineRecords = await getOfflineAttendanceRecords();
      debugPrint("[V2] 📱 Offline records to sync: $offlineRecords");

      if (!forceCheckOut) {
        if (offlineRecords.isEmpty) {
          resultData["message"] = "No offline records found to sync";
          return resultData;
        }
      }

      debugPrint("[V2] 🔄 Starting sync of "+offlineRecords.length.toString()+" offline records");

      var dataToSync = <Map<String, dynamic>>[];

      if (forceCheckOut) {
        if (dataPayload['userId'] == null) {
          debugPrint('[ERROR] Skipping forceCheckOut payload with null userId: $dataPayload');
        } else {
          dataToSync.add(Map<String, dynamic>.from(dataPayload));
        }
      } else {
        for (var record in offlineRecords) {
          try {
            Map<String, dynamic> map = Map<String, dynamic>.from(record);
            debugPrint('[DEBUG] Preparing record for sync: ' + map.toString());
            if (map['userId'] == null) {
              debugPrint('[ERROR] Skipping and deleting record with null userId: $map');
              if (map['id'] != null) {
                await deleteOfflineAttendanceRecord(map['id']);
                debugPrint('[ERROR] Deleted invalid offline record with null userId: ${map['id']}');
              }
              continue;
            }
            // Optionally, ensure userId is double
            if (map['userId'] != null && map['userId'] is! double) {
              map['userId'] = double.tryParse(map['userId'].toString());
            }
            // Optionally, ensure statusSince is double
            if (map['statusSince'] != null && map['statusSince'] is! double) {
              map['statusSince'] = double.tryParse(map['statusSince'].toString());
            }
            // Optionally, ensure attendanceId, breakId, batteryLevel are int
            for (final key in ['attendanceId', 'breakId', 'batteryLevel']) {
              if (map.containsKey(key) && map[key] != null && map[key] is! int) {
                map[key] = int.tryParse(map[key].toString());
              }
            }
            // Optionally, ensure string fields
            for (final key in ['newStatus', 'location', 'locationName', 'geofence', 'deviceId']) {
              if (map.containsKey(key) && map[key] != null && map[key] is! String) {
                map[key] = map[key].toString();
              }
            }
            debugPrint('[DEBUG] Cleaned record for sync: ' + map.toString());
            dataToSync.add(map);
          } catch (e, stack) {
            debugPrint('[ERROR] Failed to prepare record for sync: $record');
            debugPrint('[ERROR] Exception: $e');
            debugPrint('[ERROR] Stack: $stack');
          }
        }
      }

      if (dataToSync.isEmpty) {
        resultData["message"] = "No valid records to sync";
        return resultData;
      }

      debugPrint("[V2] 📤 Records to sync: "+dataToSync.length.toString()+" items");
      for (final map in dataToSync) {
        debugPrint('[V2] 🟢 Record for sync: ' + map.toString());
        try {
          final input = GUserAttendanceBulkInput.fromJson(map);
          debugPrint('[V2] 🟢 Successfully deserialized to GUserAttendanceBulkInput: ' + input.toString());
        } catch (e, stack) {
          debugPrint('[V2][ERROR] Deserialization error for map: $map');
          debugPrint('[V2][ERROR] Exception: $e');
          debugPrint('[V2][ERROR] Stack: $stack');
        }
      }

      // Convert to BuiltList<Map<String, dynamic>> for the request
      final request = GmarkAttendanceSyncReq((b) => b
        ..vars.data.replace(dataToSync.map((m) => GUserAttendanceBulkInput.fromJson(m)).toBuiltList())
      );
      final response = await _apiClient.request(request);

      debugPrint('[V2] 📤 Full sync response: \n"+response.data.toString()');
      debugPrint('[V2] 📤 GraphQL errors: \n"+response.graphqlErrors.toString()');
      debugPrint('[V2] 📤 Link exception: \n"+response.linkException.toString()');

      if (response.hasErrors) {
        resultData["success"] = false;
        resultData["message"] = "Error during sync";
        debugPrint("[V2] ❌ Sync errors: "+response.graphqlErrors.toString());
        return resultData;
      }

      if (response.data?.markAttendanceSync != null) {
        final syncResult = response.data!.markAttendanceSync!;
        if (syncResult.status == "SUCCESS") {
          await clearAllOfflineRecords();
          resultData["success"] = true;
          resultData["message"] = "Attendance Synced Successfully!";
          debugPrint("[V2] ✅ Offline records synced successfully");
          return resultData;
        } else {
          resultData["success"] = false;
          resultData["message"] = "An Error Occurred While Syncing";
          return resultData;
        }
      } else {
        resultData["success"] = false;
        resultData["message"] = "No response from sync operation";
        return resultData;
      }
    } catch (err, trace) {
      debugPrint("[V2] ❌ Error in syncIndividualOfflineRecordsToNetworkV2: $err");
      debugPrint("[V2] Stack trace: $trace");
      resultData["message"] = "Error during sync: $err";
    }

    return resultData;
  }

  // ================================================================================
  // LOCAL DATA SYNC LOGIC
  // ================================================================================

  FetchUserAttendanceStatus _syncOfflineRecordsLocally({
    required FetchUserAttendanceStatus fetchStatus,
    required List<Map<String, dynamic>> offlineRecords,
  }) {
    try {
      // Filter records that are newer than the last update
      final relevantRecords = offlineRecords
          .where((record) {
            final statusSince = record['statusSince'];
            final attendanceId = record['attendanceId'];
            
            // Validate required fields
            if (statusSince == null || attendanceId == null) {
              debugPrint("⚠️ Skipping record with missing required fields: $record");
              return false;
            }
            
            return statusSince > (fetchStatus.updatedOn ?? 0) &&
                   attendanceId == fetchStatus.attendanceId;
          })
          .toList();

      // Sort by statusSince to process in chronological order
      relevantRecords.sort((a, b) {
        final aTime = a['statusSince'] as int? ?? 0;
        final bTime = b['statusSince'] as int? ?? 0;
        return aTime.compareTo(bTime);
      });

      // If no relevant records, return original status
      if (relevantRecords.isEmpty) {
        return fetchStatus;
      }

      // Create a mutable copy of the attendance breaks
      List<AttendanceBreak> updatedBreaks =
          List.from(fetchStatus.attendanceBreak ?? []);

      // Get the latest record as it represents current state
      final latestRecord = relevantRecords.last;

      // Process each record chronologically to update breaks
      for (var record in relevantRecords) {
        final newStatus = record['newStatus']?.toString() ?? 'OFFLINE';
        final statusSince = record['statusSince'] as int?;
        final breakId = record['breakId']?.toString();
        
        if (statusSince == null) {
          debugPrint("⚠️ Skipping record with invalid status: $record");
          continue;
        }

        if (newStatus == 'BREAK') {
          // Add new break
          updatedBreaks.add(AttendanceBreak(
            breakId: breakId,
            startTime: statusSince,
            endTime: null,
            duration: null,
          ));
        } else if (newStatus == 'ONLINE' && updatedBreaks.isNotEmpty) {
          // Find and update the latest ongoing break
          final lastBreakIndex =
              updatedBreaks.lastIndexWhere((b) => b.endTime == null);

          if (lastBreakIndex != -1) {
            final lastBreak = updatedBreaks[lastBreakIndex];
            final duration = statusSince - (lastBreak.startTime ?? 0);

            updatedBreaks[lastBreakIndex] = AttendanceBreak(
              breakId: lastBreak.breakId,
              startTime: lastBreak.startTime,
              endTime: statusSince,
              duration: duration,
            );
          }
        }
      }

      // Create updated attendance status
      return FetchUserAttendanceStatus(
        attendanceId: fetchStatus.attendanceId,
        date: fetchStatus.date,
        checkInTime: fetchStatus.checkInTime,
        checkOutTime: latestRecord['newStatus'].toString().toUpperCase() == 'OFFLINE'
            ? latestRecord['statusSince'] as int?
            : fetchStatus.checkOutTime,
        expectedCheckInTime: fetchStatus.expectedCheckInTime,
        expectedCheckOutTime: fetchStatus.expectedCheckOutTime,
        currentStatus: latestRecord['newStatus'].toString(),
        allowedBreak: fetchStatus.allowedBreak,
        bufferTime: fetchStatus.bufferTime,
        attendanceStatusesObj: fetchStatus.attendanceStatusesObj,
        user: fetchStatus.user,
        attendanceBreak: updatedBreaks,
        createdOn: fetchStatus.createdOn,
        updatedOn: latestRecord['statusSince'] as int?,
      );
    } catch (e) {
      debugPrint("❌ Error in _syncOfflineRecordsLocally: $e");
      // Return original status if sync fails
      return fetchStatus;
    }
  }

  // ================================================================================
  // FALLBACK HTTP METHOD
  // ================================================================================

  Future<Map<String, dynamic>?> _fetchDataWithHttp() async {
    try {
      final storageService = Get.find<StorageService>();
      final token = await storageService.getString('accessToken');
      
      if (token == null || token.isEmpty) {
        debugPrint("❌ No access token available for HTTP fallback");
        return null;
      }

      const url = 'https://assets.nectarit.com:444/api/graphql';
      const query = '''
        query FetchUserAttendanceStatus {
          fetchUserAttendanceStatus {
            attendanceId
            user {
              id
              name
              type {
                name
                status
              }
              referenceId
              contactNumber
              emailId
              status
              employeeId
            }
            date
            checkInTime
            checkOutTime
            expectedCheckInTime
            expectedCheckOutTime
            currentStatus
            allowedBreak
            bufferTime
            attendanceStatusesObj
            attendanceBreak {
              breakId
              startTime
              endTime
              duration
            }
            createdOn
            updatedOn
          }
        }
      ''';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Timezone': DateTime.now().timeZoneName,
        },
        body: json.encode({
          'query': query,
          'variables': {},
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("🔍 HTTP response: $data");
        
        if (data['data'] != null && data['data']['fetchUserAttendanceStatus'] != null) {
          log("✅ HTTP fallback data received: ${data['data']}");
          return data['data'];
        }
      } else {
        debugPrint("❌ HTTP request failed: ${response.statusCode} - ${response.body}");
      }
      
      return null;
    } catch (e) {
      debugPrint("❌ HTTP fallback error: $e");
      return null;
    }
  }

  // ================================================================================
  // UTILITY METHODS
  // ================================================================================

  Future<bool> _checkInternetConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      debugPrint("❌ Error checking connectivity: $e");
      return false;
    }
  }

  Future<void> clearAllAttendanceForLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('individual_attendance_status');
      await prefs.remove('offline_attendance_records');
      debugPrint("🗑️ All attendance data cleared for logout");
    } catch (e) {
      debugPrint("❌ Error clearing attendance data: $e");
    }
  }
} 