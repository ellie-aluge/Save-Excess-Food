import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' ;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:fyp/Views/SponsorView/MultipleSelection.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/Controllers/Administrator/FileUploadController.dart';
import 'package:fyp/Views/AdministrationView/SuccessfulSubmissionView.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:fyp/Models/NgoDeliveryService/Vehicle.dart';
import 'package:fyp/Controllers/Delivery/VehiclesController.dart';
// import 'package:fyp/Cont'
class AddVehicleView extends StatefulWidget {
  const AddVehicleView({Key? key}) : super(key: key);

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  String? stakeholderId;
  String? carPlateNumber;
  String? image;
  bool? availabilityStatus;
  File? _image;
  String? _category;
  String? _group;
  MultipleSelection? multiple;
  TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final carPlateController = TextEditingController();
  final carNameController = TextEditingController();
  final carDescriptionController= TextEditingController();
  bool _showPrefix= false;
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


  void addVehicle() async{
    String downloadUrl = await  FileUploadController().uploadImageToFirebase(_image);
    String stakeholderId= Stakeholder().getCurrentUserID();
    // multiple();
    Vehicle vehicle = Vehicle(stakeholderId:stakeholderId,carPlateNumber:carPlateController.text, carName:carNameController.text, carDescription:carDescriptionController.text, image:downloadUrl);
    String addStatus  = await VehiclesController.addVehicles(vehicle);
    if (addStatus == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulSubmissionView()),);
    } else {
      print (addStatus);
      // Display error message to user
    }
  }

  static List<String> selectedOptions = [];

  static void updateSelectedOptions(List<String> options) {
    selectedOptions = options;
    print (selectedOptions);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  Text("Add Vehicle Information", style: TextStyle(
                      color: GlobalColors.titleHeading,
                      fontSize:18,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(height: 10),
                  Container(
                    child: Text("Add vehicle information so that the NGO can assign you to deliver tasks thereby helping to feed the needy", style: TextStyle(
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
                                    controller: carNameController,
                                    maxLength:40,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter the name/make of the car';
                                      }
                                    },
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical:1, horizontal:10),
                                      counterText: "",
                                      hintText: 'Enter the name/make of the car',
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
                                'Plate Number:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right:10, top:10),
                                child:  TextFormField(
                                    controller: carPlateController,
                                    maxLength:40,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter the plate number of the car';
                                      }
                                    },
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical:1, horizontal:10),
                                      counterText: "",
                                      hintText: 'Enter the plate number of the car',
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
                                'Description:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right:10, top:10),
                                child:  TextFormField(
                                    controller: carDescriptionController,
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Kindly add brief description of the surplus food items';
                                      }
                                    },
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical:25, horizontal:10),
                                      counterText: "",
                                      hintText: 'Kindly add brief description and any other important details of the car: e.g has cooling unit',
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
                                        addVehicle();
                                      }

                                      // pickImage();
                                    },
                                    child: const Text('Update',
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
