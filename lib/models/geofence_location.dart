class GeofenceLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double radius;
  final bool isInside;

  GeofenceLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.isInside = false,
  });

  factory GeofenceLocation.fromMap(Map<String, dynamic> map) {
    return GeofenceLocation(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      radius: (map['radius'] as num).toDouble(),
      isInside: map['isInside'] ?? false,
    );
  }
  
  factory GeofenceLocation.fromJson(Map<String, dynamic> json) {
    return GeofenceLocation.fromMap(json);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'isInside': isInside,
    };
  }
  
  @override
  String toString() {
    return 'GeofenceLocation(id: $id, name: $name, latitude: $latitude, longitude: $longitude, radius: $radius, isInside: $isInside)';
  }
} 