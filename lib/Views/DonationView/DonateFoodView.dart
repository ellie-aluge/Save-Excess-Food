import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file/file.dart';
import 'dart:io';
class DonateFoodView extends StatefulWidget {
  const DonateFoodView({Key? key}) : super(key: key);

  @override
  State<DonateFoodView> createState() => _DonateFoodViewState();
}

class _DonateFoodViewState extends State<DonateFoodView> {
  String? surplusTitle;
  String? surplusFood ;
  int? quantity;
  String? expiryDate;
  String? image;
  String? surplusDescription;
  String? surplusID;
  File? _image;


  final _formKey = GlobalKey<FormState>();
  final surplusTitleController = TextEditingController();
  final surplusCategoryController = TextEditingController();
  final surplusDescriptionController= TextEditingController();
  // final surplus

  final ImagePicker _picker = ImagePicker();

  Future pickImage() async{
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color:Colors.black ,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Donate Food", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.transparent,
          elevation: 0,
      ),

      body: SingleChildScrollView(
      child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
                Text("Add Available Surplus Food", style: TextStyle(
                color: Colors.black,
                fontSize:18,
                fontWeight: FontWeight.bold
            ),),

        SizedBox(height: 10),
        Container(
          child: Text("Add Surplus food items so the NGO can be alerted on food availabilty and help feed the needy", style: TextStyle(
              color: Colors.black,
              fontSize:12,
              fontWeight:FontWeight.w300,

          ),),
              ),

              SizedBox(height: 10,),
              Container(
                width: 250,
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
                              padding: EdgeInsets.only(left:30, top:10),
                              child:  TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: surplusTitleController,
                                  maxLength:25,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter the Title of surplus food project';
                                    }
                                  },
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                                    counterText: "",
                                    hintText: 'title of surplus food saving project',
                                    hintStyle: TextStyle(

                                        color:GlobalColors.formLabel,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                    ),

                                  )
                              ),
                          ),

                          SizedBox(height: 40),


                          Text(
                            'Category:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:30, top:10),
                            child:  TextFormField(
                                textAlign: TextAlign.center,
                                controller: surplusCategoryController,
                                maxLength:25,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select food category';
                                  }
                                },
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                                  counterText: "",
                                  hintText: 'title of surplus food saving project',
                                  hintStyle: TextStyle(

                                      color:GlobalColors.formLabel,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),

                                )
                            ),
                          ),

                          SizedBox(height: 40),


                          Text(
                            'Quantity:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:30, top:10),
                            child:  TextFormField(
                                textAlign: TextAlign.center,
                                // controller: ,
                                maxLength:25,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title of project';
                                  }
                                },
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                                  counterText: "",
                                  hintText: 'title of surplus food saving project',
                                  hintStyle: TextStyle(
                                      color:GlobalColors.formLabel,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                  ),
                                ),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          SizedBox(height: 40),


                          Text(
                            'Expiry Date:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:30, top:10),
                            child:  TextFormField(
                                textAlign: TextAlign.center,
                                // controller: companyNameControl,
                                maxLength:25,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter the Title of surplus food project';
                                  }
                                },
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                                  counterText: "",
                                  hintText: 'title of surplus food saving project',
                                  hintStyle: TextStyle(

                                      color:GlobalColors.formLabel,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),

                                )
                            ),
                          ),

                          SizedBox(height: 40),


                          Text(
                            'Description:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:30, top:10),
                            child:  TextFormField(
                                textAlign: TextAlign.center,
                                // controller: companyNameControl,
                                maxLength:825,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter the Title of surplus food project';
                                  }
                                },
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                                  counterText: "",
                                  hintText: 'title of surplus food saving project',
                                  hintStyle: TextStyle(

                                      color:GlobalColors.formLabel,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),

                                )
                            ),
                          ),



                          SizedBox(height: 40),


                          Text(
                            'Description:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:30, top:10),
                            child:  TextFormField(
                                textAlign: TextAlign.center,
                                // controller: companyNameControl,
                                maxLength:825,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter the Title of surplus food project';
                                  }
                                },
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                                  counterText: "",
                                  hintText: 'title of surplus food saving project',
                                  hintStyle: TextStyle(

                                      color:GlobalColors.formLabel,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),

                                )
                            ),
                          ),

                          SizedBox(height:10),




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
                                  // if (_formKey.currentState!.validate()) {
                                  //
                                  // }

                                  pickImage();
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
