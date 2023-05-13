import 'package:flutter/material.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyUserController {
  final CollectionReference stakeholders = FirebaseFirestore.instance.collection('stakeholder');

  String role='', uid='', email='', companyName='', country='', isVerified='', state='', telephone='', website='', password='';

  Future getRequestList() async {
    List itemsList = [];

    try {

      await stakeholders.where('isVerified', isEqualTo: false).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          // print(element.data());

          print(element.reference);
          itemsList.add(element.data());

          print(itemsList[0]);

        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future updateAccountStatus() async {
    List itemsList = [];

    try {

      await stakeholders.where('isVerified', isEqualTo: false).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          // print(element.data());

          print(element.reference);
          itemsList.add(element.data());

          print(itemsList[0]);

        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
