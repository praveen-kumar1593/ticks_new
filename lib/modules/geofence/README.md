# Geofence Module

This module provides geofence-related logic and API integration using the Ferry GraphQL client and GetX for state management.

## Features
- Fetch geofences from the backend API using Ferry
- Store all geofence data as an observable
- Match a user's geofence ID to the fetched list

## Usage

1. Ensure Ferry codegen is run for the `listAllGeoFences` query.
2. Register the service:

```dart
final geofenceService = Get.put(GeofenceService(ferryClient));
```

3. Fetch geofences:
```dart
await geofenceService.fetchGeofencesFromApi(domain: "your_domain");
```

4. Match a user geofence:
```dart
geofenceService.matchUserGeofence(userGeofenceId);
final userGeo = geofenceService.userGeofence.value;
``` 