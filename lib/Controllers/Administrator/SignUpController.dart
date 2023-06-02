import 'package:flutter/material.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController {

  static Future<String> addStakeholder(Stakeholder holder) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: holder.email.toString(), password: holder.password.toString());
      // Get a reference to the Firestore collection
      CollectionReference stakeholder = FirebaseFirestore.instance.collection('stakeholder');
      String? stakeholderID= userCredential.user?.uid;


      print (userCredential.user?.uid);

      await holder.createStakeholder(stakeholderID);
      return 'success'; // Add user successful
    } catch (e) {
      return e.toString(); // Add user failed, return error message
    }
  }
}
