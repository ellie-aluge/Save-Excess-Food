import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'dart:async';
import 'package:fyp/Controllers/Administrator/VerifyUserController.dart';
import 'dart:math';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/StakeholderDetails.dart';

class VerifyUserView extends StatefulWidget {
  const VerifyUserView({Key? key}) : super(key: key);

  @override
  State<VerifyUserView> createState() => _VerifyUserViewState();
}

class _VerifyUserViewState extends State<VerifyUserView> {
  String? stakeholderID;
  String? role;
  String? companyName;
  String? email;
  String? address;
  String? city;
  String? country;
  bool? isVerified;
  String? state;
  String? telephone;
  String? website;
  String? password;

  List <Map> _requestsList=[];
  CollectionReference _stakeholderRequests= FirebaseFirestore.instance.collection('stakeholder');



  List stakeholderRequestsList=[];

  @override
  void initState() {
    getStakeholderRequests().then((data) {
      setState(() {

      });
    });
    super.initState();
  }



  Future<void> getStakeholderRequests() async {

    stakeholderRequestsList= await VerifyUserController().getRequestList();


  }





  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: stakeholderRequestsList.length,
        itemBuilder: (BuildContext context, int index) {
          // Determine the icon based on the status value
          IconData icon;
          Color iconColor;
          switch (stakeholderRequestsList[index]['role'].toString().toLowerCase()) {
            case 'ngo':
              icon = Icons.account_balance;
              iconColor = GlobalColors.gradientColor;
              break;
            case 'delivery':
              icon = Icons.airport_shuttle;
              iconColor = GlobalColors.titleHeading;
              break;
            case 'sponsor':
              icon = Icons.monetization_on_outlined;
              iconColor = Colors.yellow;
              break;
            default:
              icon = Icons.error;
              iconColor = Colors.grey;
          }

          return Card(
            child: ListTile(
              title: Text(stakeholderRequestsList[index]['companyName'].toString()),
              subtitle: Text (stakeholderRequestsList[index]['role'].toString()),

              leading: CircleAvatar(
                child: Icon(icon, color: Colors.white),
                backgroundColor: iconColor,
              ),

                  // child: Text(_getTitle(stakeholderRequestsList[index]['role'].toString()))),

              trailing: Text(stakeholderRequestsList[index]['email']),

              onTap: () {
                role=stakeholderRequestsList[index]['role'].toString();
                companyName= stakeholderRequestsList[index]['companyName'];
                email= stakeholderRequestsList[index]['email'].toString();
                website= stakeholderRequestsList[index]['website'];
                address= stakeholderRequestsList[index]['address'];
                city= stakeholderRequestsList[index]['city'];
                state= stakeholderRequestsList[index]['state'];
                telephone= stakeholderRequestsList[index]['telephone'];
                password= stakeholderRequestsList[index]['password'];
                stakeholderID= stakeholderRequestsList[index]['uid'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>

                        StakeholderDetails(
                          stakeholderID: stakeholderID,
                          role:role,
                          companyName: companyName ,
                          email:email,
                          password:password,
                          website:website,
                          address:address,
                          city:city,
                          state: state,
                          telephone: telephone,
                        ),
                  ),
                );
              },


            ),

          );

        },
      ),

    );
  }



}


