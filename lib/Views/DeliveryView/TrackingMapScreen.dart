import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingMapScreen extends StatefulWidget {
  final LatLng initialRiderLocation;

  TrackingMapScreen({required this.initialRiderLocation});

  @override
  _TrackingMapScreenState createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends State<TrackingMapScreen> {
  LatLng riderLocation = LatLng(0, 0);
  late Marker riderMarker;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    riderMarker = Marker(
      markerId: MarkerId('rider'),
      position: widget.initialRiderLocation,
      // Other marker properties...
    );

    // Simulating rider movement every 5 seconds
    simulateRiderMovement();
  }

  void simulateRiderMovement() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        // Update rider location with simulated new coordinates
        riderLocation = LatLng(37.4219999, -122.0840575);
        riderMarker = riderMarker.copyWith(positionParam: riderLocation);

        // Simulate continuous rider movement
        simulateRiderMovement();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initialRiderLocation,
          zoom: 14.0,
        ),
        markers: {riderMarker},
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
