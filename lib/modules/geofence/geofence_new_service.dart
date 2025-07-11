import 'dart:convert';
import 'dart:math';
import 'package:ticks_new/modules/geofence/geofence_finder.dart';
import 'package:built_value/json_object.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

import '../../graphql/schemas/__generated__/geofence.data.gql.dart';
import '../../services/storage_services.dart';


class GeofenceNewService extends GetxService {
  final allGeofenceData = Rxn<List<GlistAllGeoFencesData_listAllGeoFences_data>>();
  final userGeofence = Rxn<GlistAllGeoFencesData_listAllGeoFences_data>();

  /// Fetch geofences from the API using a direct HTTP request (mimics Postman)
  Future<void> fetchGeofencesDirectHttp({
    required String domain,
    int page = 1,
    int limit = 1000,
    String order = 'desc',
    String sortField = 'createdOn',
    Map<String, dynamic>? searchFields,
  }) async {
    final url = Uri.parse('https://assets.nectarit.com:444/api/graphql');
    final token = await Get.find<StorageService>().getAuthToken();
    final body = {
      "query": '''
        query listAllGeoFences(\$data: geofenceList) {
          listAllGeoFences(data: \$data) {
            data {
              type
              data
            }
            totalCount
          }
        }
      ''',
      "variables": {
        "data": {
          "domain": domain,
          "searchFields": searchFields ?? {"category": "GEOFENCE"},
          "page": page,
          "limit": limit,
          "order": order,
          "sortField": sortField
        }
      }
    };
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    print('[GeofenceNewService] Direct HTTP request body: ' + jsonEncode(body));
    print('[GeofenceNewService] Direct HTTP headers: $headers');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print('[GeofenceNewService] Direct HTTP status: \\${response.statusCode}');
    print('[GeofenceNewService] Direct HTTP response: \\${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final dataList = decoded['data']?['listAllGeoFences']?['data'] as List?;
      if (dataList != null) {
        // You may want to map this to your Ferry-generated models if needed
        // For now, store as raw list
        allGeofenceData.value = dataList.map((item) {
          // You can convert to your Ferry model if needed
          // Here, just store as a Map for simplicity
          return GlistAllGeoFencesData_listAllGeoFences_data((b) => b
            ..type = item['type']
            ..data = jsonToBuiltValue(item['data'])
          );
        }).toList();
        print('[GeofenceNewService] Geofences loaded: \\${allGeofenceData.value?.length ?? 0}');
      } else {
        allGeofenceData.value = null;
        print('[GeofenceNewService] No geofences found.');
      }
    } else {
      allGeofenceData.value = null;
      print('[GeofenceNewService] Failed to fetch geofences.');
    }
  }

  /// Set the user's geofence by identifier (if you know the geofence id)
  void setUserGeofenceOrLocation({
    required String? userGeofenceId,
    required Map<String, dynamic> userLocationPoint, // e.g., {'lat': ..., 'lng': ...}
  }) {
    final geofenceList = allGeofenceData.value;
    userGeofence.value = null; // Default to no geofence
    print('Assigned geofenceId: $userGeofenceId');
    print('Geofence list: $geofenceList');
    if (userGeofenceId != null && userGeofenceId.isNotEmpty && geofenceList != null) {
      final matched = geofenceList.firstWhereOrNull((geo) {
        final map = geo.data?.value as Map<String, dynamic>?;
        return map != null && map['identifier'] == userGeofenceId;
      });

      if (matched != null) {
        final map = matched.data?.value as Map<String, dynamic>?;
        print('Matched geofence map: $map');
        if (map != null) {
          final typeName = map['typeName'];
          print('Matched geofence typeName: $typeName');
          final lat = userLocationPoint['lat'] as double;
          final lng = userLocationPoint['lng'] as double;
          bool isInside = false;

          if (typeName == 'Circle') {
            print('Calling isPointInCircle...');
            isInside = isPointInCircle(map, lat, lng);
            print('isPointInCircle result: $isInside');
          } else if (typeName == 'Polygon') {
            final polygon = GeofenceFinder.parseWktPolygon(map['wkt']);
            isInside = GeofenceFinder.isPointInPolygon(polygon, lat, lng);
          }

          if (isInside) {
            userGeofence.value = matched;
            final geofenceName = map['name'] ?? '';
            print('User is in geofence: $geofenceName');
            return;
          }
        }
      }
      // If not inside, or not matched, userGeofence remains null
      print('User is NOT inside their assigned geofence. Location: $userLocationPoint, Geofence name: ""');
      return;
    }

    // If no geofenceId, always null
    print('User has no assigned geofence. Location: $userLocationPoint, Geofence name: ""');
  }

  /// Set the user's geofence by checking their location against all geofences (circle only)
  void setUserGeofenceByLocation({
    required double userLat,
    required double userLng,
  }) {
    final geofenceList = allGeofenceData.value;
    if (geofenceList == null) {
      print('No geofences loaded.');
      userGeofence.value = null;
      return;
    }
    for (final geo in geofenceList) {
      final map = geo.data?.value as Map<String, dynamic>?;
      if (map == null) continue;
      if (map['typeName'] == 'Circle' && isPointInCircle(map, userLat, userLng)) {
        userGeofence.value = geo;
        print('User is in geofence: ${map['name']}');
        return;
      }
      // TODO: Add polygon check here if needed
    }
    userGeofence.value = null;
    print('User is not in any geofence. Location: $userLat, $userLng');
  }

  /// Helper: Check if a point is inside a circle geofence
  // bool isPointInCircle(Map<String, dynamic> geoData, double lat, double lng) {
  //   print('Entered isPointInCircle');
  //   final wkt = geoData['wkt']; // e.g., "POINT(76.35498046875001 9.665738395188692)"
  //   final radius = double.tryParse(geoData['radius']?.toString() ?? '0') ?? 0;
  //   final match = RegExp(r'POINT\\(([-\\d.]+) ([-\\d.]+)\\)').firstMatch(wkt ?? '');
  //   if (match == null) return false;
  //   final centerLng = double.parse(match.group(1)!);
  //   final centerLat = double.parse(match.group(2)!);
  //   // Use Haversine or simple Euclidean for small distances
  //   final distance = sqrt(pow(centerLat - lat, 2) + pow(centerLng - lng, 2));
  //   return distance <= radius;
  // }
  bool isPointInCircle(Map<String, dynamic> geoData, double lat, double lng) {
    final wkt = geoData['wkt'];
    final radius = double.tryParse(geoData['radius']?.toString() ?? '0') ?? 0;
    final match = RegExp(r'POINT\(([-\d.]+) ([-\d.]+)\)').firstMatch(wkt ?? '');
    if (match == null) return false;
    final centerLng = double.parse(match.group(1)!);
    final centerLat = double.parse(match.group(2)!);

    final distance = Geolocator.distanceBetween(lat, lng, centerLat, centerLng);
    print('Circle center: $centerLat, $centerLng');
    print('User location: $lat, $lng');
    print('Radius: $radius');
    print('Distance: $distance');
    return distance <= radius;
  }

  /// Helper: Convert a Map to a BuiltValue JsonObject (if needed)
  static JsonObject jsonToBuiltValue(Map<String, dynamic>? map) {
    return map == null ? JsonObject({}) : JsonObject(map);
  }
}
