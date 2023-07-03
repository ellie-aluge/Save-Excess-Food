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

class AssignmentDetails extends StatefulWidget {
  final String? formattedDate, formattedTime, deliveryAddress, requestFoodId, description, status, surplusId;

  AssignmentDetails({
    required this.formattedTime,
    required this.formattedDate,
    required this.status,
    required this.description,
    required this.deliveryAddress,
    required this.requestFoodId,
    required this.surplusId,
  });

  @override
  State<AssignmentDetails> createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  String? imageUrl='', date, location, title, status;
  String? selectedOption;
  bool _isPageVisible = false;
  File? _image;
  File? file;

  @override
  void initState() {
    super.initState();
    initializeOptionsList();
    initializeFoodStream();
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

  final ImagePicker _picker = ImagePicker();
  Future <File?> pickImage() async{
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        if(file==null)return;
        if (file != null) {
          _image  = File(file.path) ;
        } else {
          print('No image selected.');
        }
      });
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

  Widget buildDropdown() {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue!;
        });
      },
      items: getStatusDropdownItems(),
    );
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

  Widget buildSlideUpPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPageVisible = false;
        });
      },
      child: Container(

        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Update Delivery Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Select the current delivery status:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                buildDropdown(),
                SizedBox(height: 10),

                selectedOption=='delivered'?

                Padding(
                    padding: EdgeInsets.only(right:10, top:10, bottom:10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height:100,
                              alignment: Alignment.center,
                              color: GlobalColors.inputBorder,
                              child:IconButton(
                                iconSize: 40,
                                color: GlobalColors.titleHeading,
                                icon: Icon(Icons.add_a_photo_outlined),
                                onPressed: ()
                                {
                                  pickImage();
                                },
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width:100,
                              height:100,
                              decoration: BoxDecoration(
                                // color: GlobalColors.mainColor,
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                              ),
                              child: _image == null
                                  ? Center(child:Text('No image selected') )
                                  : Image.file(_image!, fit: BoxFit.cover,),

                            ),
                          ],
                        )


                    )


                ):Container(),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: GlobalColors.titleHeading,

                  ),
                  onPressed: () async{
                    String downloadUrl = await  FileUploadController().uploadImageToFirebase(_image);
                    status=selectedOption;
                    DeliveryServiceController().updateDeliveryStatus(widget.requestFoodId.toString(), selectedOption!);
                    DeliveryServiceController().addDeliveryCollection(widget.requestFoodId.toString(), selectedOption!,downloadUrl);
                    setState(() {
                      _isPageVisible = false;
                    });
                  },
                  child: Text('Update Status'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                          'Request ID: ${widget.requestFoodId.toString()}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: GlobalColors.titleHeading,
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
                        status != 'delivered'?ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: GlobalColors.titleHeading,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPageVisible = true;
                            });
                          },
                          child: Text('Update Status'),
                        ):Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
          _isPageVisible ? buildSlideUpPage(context) : Container(),
        ],
      ),
    );
  }
}
