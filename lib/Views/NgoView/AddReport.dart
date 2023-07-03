import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' ;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fyp/Views/SponsorView/MultipleSelection.dart';
import 'package:fyp/Controllers/Administrator/FoodItemController.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/Models/NgoModel/Report.dart';
import 'package:fyp/Controllers/Ngo/ReportController.dart';
import 'package:fyp/Controllers/Administrator/FileUploadController.dart';
import 'package:fyp/Views/AdministrationView/SuccessfulSubmissionView.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
class AddReport extends StatefulWidget {
  const AddReport({Key? key}) : super(key: key);


  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  String? reportTitle;
  String? surplusFood ;
  String? expiryDate;
  String? image;
  String? reportDescription;
  String? surplusID;
  File? _image;
  String? _category;
  String? _group;
  int? quantity;
  int? numberOfItems;
  int? numberOfPeopleFed;
  PlatformFile? selectedFile;
  String _location = '';
  bool _showMap = false;
  LatLng? _currentLocation;
  String _selectedOption = 'Public';

  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  LatLng? _searchAddress;

  final _formKey = GlobalKey<FormState>();
  final numberFedController = TextEditingController();
  final numberSharedController = TextEditingController();
  final reportTitleController = TextEditingController();
  final reportDescriptionController= TextEditingController();
  bool _showPrefix= false;
  DateTime? selectedDate;
  File? file;

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

  // AIzaSyAE9P85Od4r26T1wfZ6ZhGU-r8efV56J3E
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
            content: Text('Please enable location permission manually in your device settings.'),
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



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void addSurplusFood() async{
    String downloadUrl = await  FileUploadController().uploadImageToFirebase(_image);
    String stakeholderId= Stakeholder().getCurrentUserID();
    // multiple();
    Report report = Report(stakeholderId:stakeholderId,reportTitle:reportTitleController.text, location: _searchController.text, peopleFed:numberOfPeopleFed, itemsShared:numberOfItems, visibility:_selectedOption, image: downloadUrl, description:reportDescriptionController.text, date:selectedDate);
    String addStatus  = await ReportFoodController.addReport(report);
    if (addStatus == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulSubmissionView()),);
    } else {
      print (addStatus);
      // Display error message to user
    }
  }





  @override
  void dispose() {
    _mapController?.dispose(); // Delete the temporary image file when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color:Colors.white ,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Add Report", style: TextStyle(color: Colors.white),),
          backgroundColor: GlobalColors.mainColor,
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
                children:[
                  Text("Add Impact Report", style: TextStyle(
                      color: Colors.black,
                      fontSize:18,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(height: 10),
                  Container(
                    child: Text("Add reports to increase visibility and view analytics and impact of the Save Excess Food activities. This will help the Sponsors see the impact and motivate them to help feed the needy", style: TextStyle(
                      color: Colors.black,
                      fontSize:12,
                      fontWeight:FontWeight.w300,

                    ),),
                  ),

                  SizedBox(height: 10,),
                  Container(
                      width: 350,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right:10, top:10),
                                child:  TextFormField(
                                    controller: reportTitleController,
                                    maxLength:40,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter the title of the save excess food campaign/activity';
                                      }
                                    },
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical:1, horizontal:10),
                                      counterText: "",
                                      hintText: 'Give the save food campaign a title',
                                      hintStyle: TextStyle(

                                          color:GlobalColors.formLabel,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13
                                      ),

                                    )
                                ),
                              ),



                              SizedBox(height:30),

                              Text(
                                'Location:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),


                              SizedBox(height:
                              30,),



                              Container(
                                height: 250,
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
                                          target: LatLng(3.1412, 101.68653), // Default initial location
                                          zoom: 12,
                                        ),
                                        markers: Set<Marker>.from([
                                          Marker(
                                            markerId: MarkerId('searchedLocation'),
                                            position: _searchAddress ?? LatLng(3.1412, 101.68653),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(height: 30),


                              //add expiry date
                              Text(
                                'Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right:10, top:10),
                                child: InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          selectedDate != null
                                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                              : 'Select Date',
                                        ),
                                        Icon(Icons.calendar_today),
                                      ],
                                    ),
                                  ),
                                ),),

                              SizedBox(height: 30),

                              Text(
                                'Select Visibility:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Private entries can only be seen by you while Public entries will be viewed by all app users',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),


                               Container(
                                 // color:Colors.black,
                                 padding:EdgeInsets.all(10),
                                 width: MediaQuery.of(context).size.width,
                                 height:80,
                                 child: DropdownButton<String>(
                                   value: _selectedOption,
                                   onChanged: (String? newValue) {
                                     setState(() {
                                       _selectedOption = newValue!;
                                     });
                                   },
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold,
                                   ),
                                   items: <String>['Public', 'Private']
                                       .map<DropdownMenuItem<String>>((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value),
                                     );
                                   }).toList(),
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
                                padding: EdgeInsets.only(right:10, top:10),
                                child:  TextFormField(
                                    controller: reportDescriptionController,
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Kindly add brief description of the activity';
                                      }
                                    },
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical:25, horizontal:10),
                                      counterText: "",
                                      hintText: 'Kindly add description and any other important details of the activity',
                                      hintStyle: TextStyle(
                                          color:GlobalColors.formLabel,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13
                                      ),

                                    )
                                ),
                              ),

                              SizedBox(height: 30),


                              Text(
                                'Number of items shared:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right:10, top:10),
                                  child: TextFormField(

                                    controller: numberSharedController,
                                    keyboardType: TextInputType.number,

                                    validator: (value) {
                                      if (numberOfItems == null) {
                                        return 'Please enter a number only';
                                      }

                                      final amount = this.quantity;
                                      if (amount!=null) {
                                        if(amount<=1)
                                          return 'Quantity must be above 10';
                                      }
                                    },


                                    onChanged: (value) {
                                      numberOfItems = int.tryParse(numberSharedController.text);
                                      print(numberOfItems);
                                    },


                                    // textAlign: TextAlign.center,
                                    decoration:  InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                                      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal:10),
                                      counterText: "",
                                      hintText: "Enter the number of items shared",
                                      hintStyle: TextStyle(
                                          color:GlobalColors.formLabel,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),

                                    ),
                                    style: TextStyle(fontSize: 13,),
                                  )
                              ),


                              SizedBox(height:30),
                              Text(
                                'Number of people fed:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(right:10, top:10),
                                  child: TextFormField(

                                    controller: numberFedController,
                                    keyboardType: TextInputType.number,

                                    validator: (value) {
                                      if (numberFedController == null) {
                                        return 'Please enter a number only';
                                      }

                                      final amount = this.numberOfPeopleFed;
                                      if (amount!=null) {
                                        if(amount<=1)
                                          return 'Quantity must be above 10';
                                      }
                                    },


                                    onChanged: (value) {
                                      numberOfPeopleFed = int.tryParse(numberFedController.text);
                                      print(numberOfPeopleFed);
                                    },


                                    // textAlign: TextAlign.center,
                                    decoration:  InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                                      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal:10),
                                      counterText: "",
                                      hintText: "Enter the number of people fed",
                                      hintStyle: TextStyle(
                                          color:GlobalColors.formLabel,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),

                                    ),
                                    style: TextStyle(fontSize: 13,),
                                  )
                              ),

                              SizedBox(height:30),

                              Text(
                                'Add Image:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right:10, top:10),
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


                              ),

                              Container(
                                  margin: const EdgeInsets.all(38),
                                  width:300,
                                  height:40,
                                  child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      primary: GlobalColors.titleHeading,

                                    ),
                                    onPressed: ()
                                    {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {

                                        print(selectedDate);
                                        addSurplusFood();
                                      }

                                      // pickImage();
                                    },
                                    child: const Text('DONATE FOOD',
                                        style:TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                              ),
                            ],
                          )
                      )
                  )

                ]
            ),


          ),
        )



    );
  }


}
