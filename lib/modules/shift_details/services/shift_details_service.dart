import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ferry/ferry.dart';
import '../../../graphql/__generated__/getAssigneeWorkTimeDetails.data.gql.dart';
import '../../../graphql/__generated__/getAssigneeWorkTimeDetails.req.gql.dart';

import '../../../graphql/__generated__/getAssigneeWorkTimeDetails.var.gql.dart';
import '../../../services/graphql_client_services.dart';
import '../models/client_working_hour_model.dart';
import '../models/get_assignee_work_time_details_model.dart';
import '../models/shift_model.dart';
import 'package:http/http.dart' as http;


class ShiftDetailsService {
  static const String _tag = 'ShiftDetailsService';
  static const String _cacheKey = 'shift_details_cache';
  static const String _lastFetchKey = 'shift_details_last_fetch';
  static const Duration _cacheValidity = Duration(hours: 1); // Cache for 1 hour

  /// Fetch shift details from network or cache
  Future<GetAssigneeWorkTimeDetailsModel?> getShiftDetails({bool forceRefresh = false}) async {
    try {
      debugPrint('$_tag: Fetching shift details (forceRefresh: $forceRefresh)');

      // Check if we should use cached data
      if (!forceRefresh && await _shouldUseCache()) {
        final cachedData = await _getCachedData();
        if (cachedData != null) {
          debugPrint('$_tag: Using cached shift details');
          return cachedData;
        }
      }

      // Fetch from network
      debugPrint('$_tag: Fetching from network');
      final networkData = await _fetchFromNetwork();
      
      if (networkData != null) {
        // Cache the data
        await _cacheData(networkData);
        debugPrint('$_tag: Shift details fetched and cached successfully');
        return networkData;
      }

      // If network fails, try to use cached data as fallback
      debugPrint('$_tag: Network failed, trying cached data as fallback');
      return await _getCachedData();

    } catch (e, stackTrace) {
      debugPrint('$_tag: Error fetching shift details: $e');
      debugPrint('$_tag: Stack trace: $stackTrace');
      
      // Return cached data as fallback
      return await _getCachedData();
    }
  }

  /// Fetch shift details from GraphQL
  Future<GetAssigneeWorkTimeDetailsModel?> _fetchFromNetwork() async {
    try {
      final graphQLService = Get.find<GraphQLClientService>();
      final url = graphQLService.url;
      final token = await graphQLService.getToken();
      final query = '''
        query GetAssigneeWorkTimeDetails {
          getAssigneeWorkTimeDetails {
            shift {
              identifier
              startTime
              endTime
              duration
              domain
              name
              description
              status
              allowedBreak
              bufferTime
            }
            clientWorkingHour {
              id
              name
              sundayStartTime
              sundayEndTime
              mondayStartTime
              mondayEndTime
              tuesdayStartTime
              tuesdayEndTime
              wednesdayStartTime
              wednesdayEndTime
              thursdayStartTime
              thursdayEndTime
              fridayStartTime
              fridayEndTime
              saturdayStartTime
              saturdayEndTime
              allowedBreak
              bufferTime
              client
            }
          }
        }
      ''';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'query': query}),
      );

      final data = jsonDecode(response.body);
      debugPrint('ShiftDetailsService: --- HTTP RAW DATA ---');
      debugPrint('\u001b[36m$data\u001b[0m');
      debugPrint('ShiftDetailsService: --- END HTTP RAW DATA ---');

      if (data['data'] != null && data['data']['getAssigneeWorkTimeDetails'] != null) {
        return GetAssigneeWorkTimeDetailsModel.fromJson(data['data']['getAssigneeWorkTimeDetails']);
      }
      debugPrint('$_tag: No data received from HTTP GraphQL');
      return null;
    } catch (e) {
      debugPrint('$_tag: HTTP network error: $e');
      return null;
    }
  }

  /// Convert GraphQL data to our model
  GetAssigneeWorkTimeDetailsModel _convertGraphQLToModel(
    GGetAssigneeWorkTimeDetailsData_getAssigneeWorkTimeDetails graphqlData,
  ) {
    // Convert shift data
    Shift? shift;
    if (graphqlData.shift != null) {
      final shiftData = graphqlData.shift!;
      shift = Shift(
        identifier: shiftData.identifier,
        startTime: shiftData.startTime,
        endTime: shiftData.endTime,
        duration: shiftData.duration,
        domain: shiftData.domain,
        name: shiftData.name,
        description: shiftData.description,
        status: shiftData.status,
        allowedBreak: shiftData.allowedBreak,
        bufferTime: shiftData.bufferTime,
      );
    }

    // Convert client working hour data
    ClientWorkingHour? clientWorkingHour;
    if (graphqlData.clientWorkingHour != null) {
      final workingHourData = graphqlData.clientWorkingHour!;
      clientWorkingHour = ClientWorkingHour(
        id: parseInt(workingHourData.id),
       // id: workingHourData.id,
        name: workingHourData.name,
        sundayStartTime: _convertTimeStringToMillis(workingHourData.sundayStartTime),
        sundayEndTime: _convertTimeStringToMillis(workingHourData.sundayEndTime),
        mondayStartTime: _convertTimeStringToMillis(workingHourData.mondayStartTime),
        mondayEndTime: _convertTimeStringToMillis(workingHourData.mondayEndTime),
        tuesdayStartTime: _convertTimeStringToMillis(workingHourData.tuesdayStartTime),
        tuesdayEndTime: _convertTimeStringToMillis(workingHourData.tuesdayEndTime),
        wednesdayStartTime: _convertTimeStringToMillis(workingHourData.wednesdayStartTime),
        wednesdayEndTime: _convertTimeStringToMillis(workingHourData.wednesdayEndTime),
        thursdayStartTime: _convertTimeStringToMillis(workingHourData.thursdayStartTime),
        thursdayEndTime: _convertTimeStringToMillis(workingHourData.thursdayEndTime),
        fridayStartTime: _convertTimeStringToMillis(workingHourData.fridayStartTime),
        fridayEndTime: _convertTimeStringToMillis(workingHourData.fridayEndTime),
        saturdayStartTime: _convertTimeStringToMillis(workingHourData.saturdayStartTime),
        saturdayEndTime: _convertTimeStringToMillis(workingHourData.saturdayEndTime),
        allowedBreak: workingHourData.allowedBreak,
        bufferTime: workingHourData.bufferTime,
        client: workingHourData.client,
      );
    }

    return GetAssigneeWorkTimeDetailsModel(
      shift: shift,
      clientWorkingHour: clientWorkingHour,
    );
  }

  /// Convert time string (HH:mm) to milliseconds
  int? _convertTimeStringToMillis(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    
    try {
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        return (hours * 60 * 60 * 1000) + (minutes * 60 * 1000);
      }
    } catch (e) {
      debugPrint('$_tag: Error converting time string "$timeStr": $e');
    }
    
    return null;
  }

  /// Check if cached data should be used
  Future<bool> _shouldUseCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastFetchTime = prefs.getInt(_lastFetchKey);
      
      if (lastFetchTime == null) {
        return false;
      }

      final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchTime);
      final now = DateTime.now();
      
      return now.difference(lastFetch) < _cacheValidity;
    } catch (e) {
      debugPrint('$_tag: Error checking cache validity: $e');
      return false;
    }
  }

  /// Get cached shift details
  Future<GetAssigneeWorkTimeDetailsModel?> _getCachedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      
      if (cachedJson != null) {
        final cachedData = json.decode(cachedJson);
        return GetAssigneeWorkTimeDetailsModel.fromJson(cachedData);
      }
      
      return null;
    } catch (e) {
      debugPrint('$_tag: Error getting cached data: $e');
      return null;
    }
  }

  /// Cache shift details
  Future<void> _cacheData(GetAssigneeWorkTimeDetailsModel data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = json.encode(data.toJson());
      
      await prefs.setString(_cacheKey, jsonData);
      await prefs.setInt(_lastFetchKey, DateTime.now().millisecondsSinceEpoch);
      
      debugPrint('$_tag: Data cached successfully');
    } catch (e) {
      debugPrint('$_tag: Error caching data: $e');
    }
  }

  /// Clear cached data
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_lastFetchKey);
      debugPrint('$_tag: Cache cleared successfully');
    } catch (e) {
      debugPrint('$_tag: Error clearing cache: $e');
    }
  }

  /// Get cache status
  Future<Map<String, dynamic>> getCacheStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastFetchTime = prefs.getInt(_lastFetchKey);
      final hasCachedData = prefs.getString(_cacheKey) != null;
      
      return {
        'hasCachedData': hasCachedData,
        'lastFetchTime': lastFetchTime,
        'isValid': lastFetchTime != null && 
            DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(lastFetchTime)) < _cacheValidity,
      };
    } catch (e) {
      debugPrint('$_tag: Error getting cache status: $e');
      return {
        'hasCachedData': false,
        'lastFetchTime': null,
        'isValid': false,
      };
    }
  }
} 