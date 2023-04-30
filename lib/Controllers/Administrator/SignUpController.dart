import 'package:flutter/material.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController {
  static Future<String> addStakeholder(Stakeholder holder) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference stakeholder = FirebaseFirestore.instance.collection('stakeholder');

      // Add the user data to the Firestore collection
      print("controller");
      await stakeholder.add(holder.toMap());



      return 'success'; // Add user successful
    } catch (e) {
      return e.toString(); // Add user failed, return error message
    }
  }
}
