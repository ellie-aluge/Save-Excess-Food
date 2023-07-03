import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/Map/MapView.dart';
import 'package:fyp/Views/SponsorView/SurplusFoodSlider.dart';
import 'package:fyp/Views/NgoView/RequestFoodView.dart';
import 'package:fyp/Views/DeliveryView/TrackView.dart';
import 'package:fyp/Views/Map/MapView.dart';
import 'package:fyp/Views/DeliveryView/MapTrackView.dart';
import 'package:fyp/Controllers/Delivery/DeliveryServiceController.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fyp/Controllers/Administrator/FileUploadController.dart';
import 'dart:io' ;
import 'dart:convert';

class RequestDetails extends StatefulWidget {
  final String? formattedDate, formattedTime, deliveryAddress, requestFoodId, description;
  final String? deliveryServiceId, donorId, status, surplusId,surplusTitle;
  final int? quantity;

  RequestDetails({
    required this.formattedTime,
    required this.formattedDate,
    required this.status,
    required this.description,
    required this.deliveryAddress,
    required this.requestFoodId,
    required this.surplusId,
    required this.surplusTitle,
    required this.quantity,
    required this.deliveryServiceId,
    required this.donorId,
  });

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  String? imageUrl='', date, location, title, status;
  String? selectedOption, deliveryService;
  bool _isPageVisible = false;
  File? _image;
  File? file;

  @override
  void initState() {
    super.initState();
    initializeOptionsList();
    initializeFoodStream();
    initializeDeliveryService();
  }



  Future<void> initializeOptionsList() async {
    selectedOption = widget.status.toString();
    status=widget.status.toString();
  }

  Future<void> initializeFoodStream() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('surplusFood')
          .where('surplusId', isEqualTo: widget.surplusId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> surplusData = doc.data() as Map<String, dynamic>;
          if (mounted) {
            setState(() {
              title = surplusData['surplusTitle'];
              location = surplusData['location'];
              imageUrl = surplusData['image'];
            });
          }

          print('Surplus Food Name: $title');
          print('Surplus Food Description: $location');
        });
      } else {
        print('No surplus food found for the provided surplusId.');
      }
    } catch (e) {
      print('Error retrieving surplus food details: $e');
    }
  }


  Future<void> initializeDeliveryService() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('stakeholder')
          .where('uid', isEqualTo: widget.deliveryServiceId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> surplusData = doc.data() as Map<String, dynamic>;
          if (mounted) {
            setState(() {
              deliveryService = surplusData['companyName'];

            });
          }

        });
      } else {
        print('No delivery service assigned.');
      }
    } catch (e) {
      print('Error retrieving surplus food details: $e');
    }
  }

  Color getStatusColor(String status) {
    if (status == 'pending') {
      return Colors.red;
    } else if (status == 'delivered') {
      return Colors.green;
    } else if (status == 'pickedUp') {
      return Colors.blue;
    }
    // Return a default color if the status doesn't match any condition
    return Colors.black;
  }



  List<DropdownMenuItem<String>> getStatusDropdownItems() {
    if (selectedOption == 'pending') {
      return [
        DropdownMenuItem<String>(
          value: 'pending',
          child: Text('pending'),
        ),
        DropdownMenuItem<String>(
          value: 'pickedUp',
          child: Text('pickedUp'),
        ),
      ];
    } else {
      return [
        DropdownMenuItem<String>(
          value: 'pickedUp',
          child: Text('pickedUp'),
        ),
        DropdownMenuItem<String>(
          value: 'delivered',
          child: Text('delivered'),
        ),
      ];
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix([
                0.6, 0, 0, 0, 0, // Adjust the values to darken or lighten the image
                0, 0.6, 0, 0, 0,
                0, 0, 0.6, 0, 0,
                0, 0, 0, 1, 0,
              ]),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Adjust the opacity to control the darkness
              ),
            ),
          ),

          leading: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: GlobalColors.greyColor,
              ),
              child: Center(
                child:IconButton(
                  icon: Icon(Icons.arrow_back, color: GlobalColors.titleHeading),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
          ),
        ),
      ),
      body: Stack(
        children: [

          Container(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.surplusTitle.toString()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalColors.titleHeading,
                          ),
                        ),
                        Text(
                          'Request ID: ${widget.requestFoodId.toString()}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            // color: GlobalColors.gradientColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          status??'',
                          style: TextStyle(
                            color: getStatusColor(status!),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                        // widget.status.toString() != 'delivered'
                        //     ? buildDropdown()
                        //     : Text('Status: ${widget.status.toString()}'),
                        EstimatedDeliveryTimePage(
                          startLocation: 'Jalan Kempas Utama 2/6, 81300 Johor Bahru, Johor',
                          endLocation: '11800 Gelugor, Penang',
                        ),
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: GlobalColors.titleHeading,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TrackViewPage(deliveryStatus:widget.status.toString(), requestFoodId:widget.requestFoodId.toString()),
                              ),
                            );

                          },
                          child: Text('Track'),
                        ),

                      ],
                    ),
                  ),
                  // SizedBox(height: 2),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              color: GlobalColors.maroon,
                              padding:EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child:Row(
                          children:[
                            Icon(Icons.fire_truck_sharp, color: Colors.white,),
                            SizedBox(width:10),
                            Text(
                              "Assigned To: ${deliveryService?.toUpperCase() ?? ""}",
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ]
                      )
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Table(
                                      defaultColumnWidth: FixedColumnWidth(200.0),
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text(
                                                'Pickup Date:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Text(
                                                'Pickup Time:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text(
                                                widget.formattedDate.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Text(
                                                widget.formattedTime.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 400,
                                      height: 120,
                                      child: location != null ? MapView(location: location!) : Container(),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Pickup Location:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      location.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Note from the NGO:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      widget.description.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Table(
                                      defaultColumnWidth: FixedColumnWidth(200.0),
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text(
                                                'Deliver To:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text(
                                                widget.formattedTime.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 400,
                                      height: 120,
                                      child: location != null ? MapView(location: location!) : Container(),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Delivery Location:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      widget.deliveryAddress.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Note from the Deliverer:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'No note provided.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                title.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
