import 'package:flutter/material.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  static Future<String> Login(email, password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('stakeholder').doc(userCredential.user?.uid).get();
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        bool isVerified = userData['isVerified'];
        String? role= userData['role'].toString().toLowerCase();

        // await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );
        if (isVerified) {
          return (role);
        } else {
          return ("invalid");
        }
        return ("valid");
        // Navigate to home screen after successful login
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          return ("invalid");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return ("invalid");
        }
        return "";
      } catch (e) {
        print(e);
        return(e.toString());
      }


  }
}


