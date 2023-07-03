import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fyp/Views/DeliveryView/TrackingMapScreen.dart';


class ViewRider extends StatefulWidget {
  const ViewRider({Key? key}) : super(key: key);

  @override
  State<ViewRider> createState() => _ViewRiderState();
}

class _ViewRiderState extends State<ViewRider> {
  String riderLocation = 'Pusat Pentadbiran Universiti Teknologi Malaysia, 80990 Skudai, Johor';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          List<Location> locations = await locationFromAddress(riderLocation);
          if (locations.isNotEmpty) {
            LatLng riderLatLng = LatLng(locations.first.latitude, locations.first.longitude);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackingMapScreen(
                  initialRiderLocation: riderLatLng, // Pass the converted LatLng object
                ),
              ),
            );
          } else {
            // Handle address not found error
          }
        } catch (e) {
          // Handle geocoding service error
        }
      },
      child: Text('ASSIGN'),
    );
  }
}
