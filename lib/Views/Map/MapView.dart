import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io' ;
import 'dart:convert';
class MapView extends StatefulWidget {
  final String? location;

  MapView({required this.location});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  LatLng coordinates= LatLng(0, 0); // Default coordinates

  @override
  void initState() {

    searchLocation();
    super.initState();
  }
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }


  void searchLocation() async {
    final query = widget.location;
    final apiKey = 'AIzaSyAE9P85Od4r26T1wfZ6ZhGU-r8efV56J3E';
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body);
      final results = jsonResult['results'];

      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];

        setState(() {
          coordinates = LatLng(lat, lng);
          final address= coordinates;
        });

        if ( coordinates != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(coordinates!));
        }

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width:300,
      // height:300,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Default initial location
                zoom: 12,
              ),
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId('searchedLocation'),
                  position: coordinates ?? LatLng(37.7749, -122.4194),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}