import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class EstimatedDeliveryTimePage extends StatefulWidget {
  final String startLocation;
  final String endLocation;

  EstimatedDeliveryTimePage({required this.startLocation, required this.endLocation});

  @override
  _EstimatedDeliveryTimePageState createState() => _EstimatedDeliveryTimePageState();
}

class _EstimatedDeliveryTimePageState extends State<EstimatedDeliveryTimePage> {
  String estimatedTime = '';

  @override
  void initState() {
    super.initState();
    calculateEstimatedTime();
  }



  Future<void> calculateEstimatedTime() async {
    final apiKey = 'AIzaSyAE9P85Od4r26T1wfZ6ZhGU-r8efV56J3E';
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${widget.startLocation}&destinations=${widget.endLocation}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['rows'] != null && data['rows'][0]['elements'] != null) {
        final duration = data['rows'][0]['elements'][0]['duration']['text'];
        setState(() {
          estimatedTime = duration;
        });
      } else {
        // Handle error case where the response data is missing or incorrect
        // Show an error message or fallback to a default value
        setState(() {
          estimatedTime = 'N/A';
        });
      }
    } else {
      throw 'Failed to fetch data';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height:30,
        child:SizedBox(
          height:30,
          child: Text(
            'Estimated Journey Time: $estimatedTime',
            style: TextStyle(fontSize: 12),
          ),
        ),

    );
  }
}
