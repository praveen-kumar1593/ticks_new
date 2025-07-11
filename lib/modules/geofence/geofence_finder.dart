import 'package:geolocator/geolocator.dart';

class GeofenceFinder {
  /// Checks if a point is inside a polygon using the ray-casting algorithm
  static bool isPointInPolygon(List<List<double>> polygon, double lat, double lng) {
    int i, j = polygon.length - 1;
    bool oddNodes = false;
    for (i = 0; i < polygon.length; i++) {
      if ((polygon[i][1] < lng && polygon[j][1] >= lng ||
           polygon[j][1] < lng && polygon[i][1] >= lng) &&
          (polygon[i][0] <= lat || polygon[j][0] <= lat)) {
        if (polygon[i][0] + (lng - polygon[i][1]) / (polygon[j][1] - polygon[i][1]) * (polygon[j][0] - polygon[i][0]) < lat) {
          oddNodes = !oddNodes;
        }
      }
      j = i;
    }
    return oddNodes;
  }

  /// Parses a WKT POLYGON string into a list of [lat, lng] pairs
  static List<List<double>> parseWktPolygon(String wkt) {
    final coords = wkt
        .replaceAll('POLYGON((', '')
        .replaceAll('))', '')
        .split(',')
        .map((pair) {
          final parts = pair.trim().split(' ');
          return [double.parse(parts[1]), double.parse(parts[0])]; // [lat, lng]
        })
        .toList();
    return coords;
  }

  /// Parses a WKT POINT string into a [lat, lng] pair
  static List<double> parseWktPoint(String wkt) {
    final coords = wkt.replaceAll('POINT(', '').replaceAll(')', '').split(' ');
    return [double.parse(coords[1]), double.parse(coords[0])]; // [lat, lng]
  }

  /// Checks if a point is inside a circle geofence
  // static bool isPointInCircle(Map<String, dynamic> geoData, double lat, double lng) {
  //   final center = parseWktPoint(geoData['wkt']);
  //   final radius = double.tryParse(geoData['radius']?.toString() ?? '0') ?? 0;
  //   final dLat = lat - center[0];
  //   final dLng = lng - center[1];
  //   final distanceSquared = dLat * dLat + dLng * dLng;
  //   return distanceSquared <= radius * radius;
  // }
 static bool isPointInCircle(Map<String, dynamic> geoData, double lat, double lng) {
   print('Entered isPointInCircle');
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

  /// Finds the geofence name for a user given a geofence list, user location, and (optionally) assigned geofenceId
  static String findGeofenceNameForUser({
    required List<dynamic> geofenceList,
    required double userLat,
    required double userLng,
    String? assignedGeofenceId,
  }) {
    for (final geo in geofenceList) {
      final map = geo['data'] as Map<String, dynamic>;
      if (assignedGeofenceId != null && assignedGeofenceId.isNotEmpty) {
        if (map['identifier'] != assignedGeofenceId) continue;
      }
      final typeName = map['typeName'];
      if (typeName == 'Circle') {
        if (isPointInCircle(map, userLat, userLng)) {
          return map['name'] ?? '';
        }
      } else if (typeName == 'Polygon') {
        final polygon = parseWktPolygon(map['wkt']);
        if (isPointInPolygon(polygon, userLat, userLng)) {
          return map['name'] ?? '';
        }
      }
    }
    return '';
  }
} 