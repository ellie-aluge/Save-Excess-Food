import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/SignUpView.dart';
import 'package:csc_picker/csc_picker.dart';
import 'dart:io';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fyp/Controllers/Administrator/SignUpController.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fyp/Views/AdministrationView/SuccessfulFormView.dart';

class SignUpView extends StatefulWidget {
  final String? role;
  const SignUpView({Key? key, required this.role}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}


class _SignUpViewState extends State<SignUpView> {

  String? roles;
  String? countryValue = "Malaysia";
  String? stateValue = "";
  String? cityValue = "";
  String? city='';
  String? address = "";
  String? _email;
  String? _password;
  String? _companyName;
  bool? isVerified= false;
  String? telephone;
  String? website;
  String? _phoneNumber;
  String? uid;


  final _formKey = GlobalKey<FormState>();
  // final auth = FirebaseAuth.instance;
  final companyNameControl = TextEditingController();
  final telephoneControl = TextEditingController();
  // final AuthService _auth = AuthService(FirebaseAuth.instance);



  void _submitForm() async {

    Stakeholder stakeholder = Stakeholder(uid:uid, email: _email, companyName: companyNameControl.text, isVerified: isVerified, website: website, city: cityValue, state: stateValue, country: countryValue, address: address,  password: _password, telephone: telephone, role:widget.role);

    String errorMessage = await SignUpController.addStakeholder(stakeholder);
    if (errorMessage == "success") {
      print("hello");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulFormView()),);
    } else {
      print (errorMessage);
      // Display error message to user

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body: ListView(
            children: [
              Column(
                children:[
                  Container(
                    height:MediaQuery.of(context).size.height,
                    width:MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          top:0,
                          left:0,
                          right:0,
                          child: Container(
                              height:190.0,
                              decoration: BoxDecoration(
                                color: GlobalColors.mainColor,
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                image: DecorationImage(
                                  scale: 3.5,
                                  image: AssetImage('assets/admin/SEF_white.png',
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                          ),
                        ),

                        Positioned(
                          bottom:0,
                          right:0,
                          left:0,
                          top:170,
                          child: Container(
                            height:500.0,
                            width:400,
                            decoration: BoxDecoration(
                              color:GlobalColors.containerField,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),

                            ),

                            child:SingleChildScrollView(

                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top:35, left:20),
                                      margin: const EdgeInsets.symmetric(horizontal:12),
                                      alignment: Alignment.center,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'SIGNUP',
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight:FontWeight.bold,
                                            color: GlobalColors.titleHeading,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(18),
                                        margin: const EdgeInsets.symmetric(horizontal:12),
                                        alignment: Alignment.center,
                                        child: Form(
                                            key: _formKey,

                                            child: Column(
                                              children: [
                                                TextFormField(
                                                    controller: companyNameControl,
                                                    maxLength:25,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter the company name';
                                                      }
                                                    },
                                                    decoration:  InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 1),

                                                      prefixIcon: Icon(Icons.person,
                                                          size:18),
                                                      counterText: "",
                                                      hintText: 'Company Name',
                                                      hintStyle: TextStyle(
                                                          color:GlobalColors.formLabel,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 13
                                                      ),

                                                    )
                                                ),
                                                SizedBox(height: 11), // adjust the height as needed
                                                TextFormField(
                                                    maxLength:25,
                                                    validator: (value) => EmailValidator.validate(value!)
                                                        ? null
                                                        : "Please enter a valid email",
                                                    keyboardType: TextInputType.emailAddress,
                                                    onChanged: (value) {
                                                      _email = value.toString().trim();
                                                    },


                                                    decoration:  InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                                                        prefixIcon: Icon(
                                                            Icons.email_outlined,
                                                            size:17),
                                                        counterText: "",
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1.5, color: GlobalColors.inputBorder), //<-- SEE HERE
                                                        ),
                                                        hintText: 'Email',
                                                        hintStyle: TextStyle(
                                                            color:GlobalColors.formLabel,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13
                                                        )
                                                    )
                                                ),
                                                SizedBox(height:11),
                                                TextFormField(
                                                    maxLength:25,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter the company Address';
                                                      }
                                                    },
                                                    decoration:  InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                                                        prefixIcon: Icon(
                                                            Icons.email_outlined,
                                                            size:17),
                                                        counterText: "",
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1.5, color: GlobalColors.inputBorder), //<-- SEE HERE
                                                        ),
                                                        hintText: 'Address',
                                                        hintStyle: TextStyle(
                                                            color:GlobalColors.formLabel,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13
                                                        )
                                                    )
                                                ),

                                                SizedBox(height: 11),

                                                CSCPicker(
                                                  defaultCountry: CscCountry.Malaysia,
                                                  disableCountry: true,
                                                  onCityChanged: (city){cityValue=city;},
                                                  onStateChanged: (state){stateValue=state;},
                                                  onCountryChanged: (country){},
                                                ),

                                                SizedBox(height:11),

                                                InternationalPhoneNumberInput(
                                                  onInputChanged: (PhoneNumber number) {
                                                    telephone=number.phoneNumber;
                                                  },
                                                  inputDecoration: InputDecoration(
                                                    hintText: 'Phone Number',
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(),
                                                    ),
                                                  ),
                                                  // selectorConfig: SelectorConfig(
                                                  //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                                  // ),
                                                  initialValue: PhoneNumber(isoCode: 'MY'),
                                                ),

                                                // TextFormField(
                                                //     maxLength:25,
                                                //     validator: (value) {
                                                //       if (value == null || value.isEmpty) {
                                                //         return 'Please enter the company telephone';
                                                //       }
                                                //     },
                                                //     decoration:  InputDecoration(
                                                //         contentPadding: EdgeInsets.symmetric(vertical: 3),
                                                //         prefixIcon: Icon(
                                                //             Icons.phone_android_outlined,
                                                //             size:13),
                                                //         counterText: "",
                                                //         enabledBorder: OutlineInputBorder(
                                                //           borderSide: BorderSide(
                                                //               width: 1.5, color: GlobalColors.inputBorder), //<-- SEE HERE
                                                //         ),
                                                //         hintText: 'Telephone',
                                                //         hintStyle: TextStyle(
                                                //             color:GlobalColors.formLabel,
                                                //             fontWeight: FontWeight.w500,
                                                //             fontSize: 13
                                                //         )
                                                //     )
                                                // ),
                                                SizedBox(height:11),
                                                TextFormField(
                                                    maxLength:25,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter the company password';
                                                      }
                                                    },
                                                    onChanged: (value) {
                                                      _password = value.toString();
                                                    },
                                                    decoration:  InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 3),
                                                        prefixIcon: Icon(
                                                            Icons.lock_open_outlined,
                                                            size:17),
                                                        counterText: "",
                                                        hintText: 'Website',
                                                        hintStyle: TextStyle(
                                                            color:GlobalColors.formLabel,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13
                                                        )
                                                    )
                                                ),

                                                SizedBox(height:11),
                                                TextFormField(
                                                    maxLength:25,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          value.length < 8) {
                                                        return 'Please enter a strong password with minimum 8 characters';
                                                      } else
                                                        return null;
                                                    },
                                                    maxLines: 1,
                                                    obscureText: true,
                                                    onChanged: (value) {
                                                      _password = value;
                                                    },
                                                    decoration:  InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 3),
                                                        prefixIcon: Icon(
                                                            Icons.lock_open_outlined,
                                                            size:17),
                                                        counterText: "",
                                                        hintText: 'Password',
                                                        hintStyle: TextStyle(
                                                            color:GlobalColors.formLabel,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13
                                                        )
                                                    )
                                                ),
                                                SizedBox(height:11),
                                                TextFormField(
                                                    maxLength:25,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          value!=_password) {
                                                        return 'Please ensure the password is the same';
                                                      } else
                                                        return null;
                                                    },
                                                    obscureText: true,
                                                    decoration:  InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 3),
                                                        prefixIcon: Icon(
                                                            Icons.lock_open_outlined,
                                                            size:17),
                                                        counterText: "",
                                                        hintText: 'Confirm Password',
                                                        hintStyle: TextStyle(
                                                            color:GlobalColors.formLabel,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13
                                                        )
                                                    )
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
                                                        if (_formKey.currentState!.validate()) {

                                                          _submitForm();
                                                          // ScaffoldMessenger.of(context).showSnackBar(
                                                          // const SnackBar(content: Text('Processing Data')),
                                                          // );

                                                          // dynamic result = await _auth.RegisterWithEmail(email,
                                                          //     password, firstNameControl, secondNameControl, role);
                                                        }

                                                      },
                                                      child: const Text('SIGNUP',
                                                          style:TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                    )
                                                ),
                                              ],
                                            )
                                        )

                                    ),





                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      width:300,
                                      height:40,
                                      alignment: Alignment.center,
                                      child:  Text('Login',
                                          style:TextStyle(
                                            color: GlobalColors.titleHeading,
                                            fontWeight: FontWeight.bold,
                                          )),

                                    )
                                  ],
                                )
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),

            ]
        )

    );
  }
}
