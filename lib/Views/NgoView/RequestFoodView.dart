import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'dart:io';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fyp/Views/SponsorView/MultipleSelection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fyp/Models/NgoModel/RequestFood.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:fyp/Views/NgoView/AssignDriverView.dart';

class RequestFoodView extends StatefulWidget {
   String? surplusId;

  RequestFoodView({required this.surplusId});


  @override
  State<RequestFoodView> createState() => _RequestFoodViewState();
}

class _RequestFoodViewState extends State<RequestFoodView> {
  bool _showMap = false;
  LatLng? _currentLocation;
  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  LatLng? _searchAddress;
  final _formKey = GlobalKey<FormState>();
  final requestDescriptionController = TextEditingController();
  bool _showPrefix = false;
  DateTime? selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDateTime = DateTime.now();

  void searchLocation() async {
    final query = _searchController.text;
    final apiKey = 'AIzaSyAE9P85Od4r26T1wfZ6ZhGU-r8efV56J3E'; // Replace with your Google Maps API key

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
          _searchAddress = LatLng(lat, lng);
        });

        if (_mapController != null && _searchAddress != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(_searchAddress!));
        }
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _showMap = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Access Denied'),
            content: Text(
                'Please enable location permission manually in your device settings.'),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );

      if (selectedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          _selectedTime = selectedTime;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Request Food Item",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Request Food",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  "The details entered will be used to ensure proper collection and delivery of the selected surplus food entry",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Delivery Location:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 300,
                        child: Column(
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    searchLocation();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: GoogleMap(
                                onMapCreated: (controller) {
                                  setState(() {
                                    _mapController = controller;
                                  });
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(3.1412, 101.68653),
                                  // Default initial location
                                  zoom: 12,
                                ),
                                markers: Set<Marker>.from([
                                  Marker(
                                    markerId: MarkerId('searchedLocation'),
                                    position:
                                    _searchAddress ?? LatLng(37.7749, -122.4194),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Pickup Date and Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _selectDateTime(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(),
                            controller: TextEditingController(
                              text: _selectedDateTime.toString(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: TextFormField(
                          controller: requestDescriptionController,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kindly add brief description of the request';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            counterText: "",
                            hintText:
                            'Kindly add brief description and any other important details of the surplus food request to be viewed by the delivery team and Sponsors',
                            hintStyle: TextStyle(
                              color: GlobalColors.formLabel,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.all(38),
                        width: 300,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: GlobalColors.titleHeading,
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AssignDriverView(
                                    surplusId: widget.surplusId, // Pass the surplusId parameter
                                    deliveryAddress: _searchController.text,
                                    pickupDate: _selectedDateTime,
                                    description: requestDescriptionController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'NEXT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
