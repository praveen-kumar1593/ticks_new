import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHistoryMapScreen extends StatelessWidget {
  final List<LatLng> locationHistory;

  const LocationHistoryMapScreen({Key? key, required this.locationHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (locationHistory.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Location History')),
        body: Center(child: Text('No location history.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Location History')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: locationHistory.last,
          zoom: 15,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId('history'),
            color: Colors.blue,
            width: 5,
            points: locationHistory,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId('start'),
            position: locationHistory.first,
            infoWindow: InfoWindow(title: 'Start'),
          ),
          Marker(
            markerId: MarkerId('end'),
            position: locationHistory.last,
            infoWindow: InfoWindow(title: 'End'),
          ),
        },
      ),
    );
  }
}