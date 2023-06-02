import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Stakeholder {
  CollectionReference stakeholder = FirebaseFirestore.instance.collection('stakeholder');
  String? uid;
  String? email;
  String? companyName;
  bool? isVerified;
  String? website;
  String? city;
  String? state;
  String? country;
  String? address;
  String? telephone;
  String? password;
  String? role;

  Stakeholder({
    this.uid,
    this.email,
    this.address,
    this.city,
    this.companyName,
    this.country,
    this.isVerified,
    this.state,
    this.telephone,
    this.website,
    this.password,
    this.role,
  });

  // Receiving data from the server
  factory Stakeholder.fromMap(Map<String, dynamic> map) {
    return Stakeholder(
      uid: map['uid'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      companyName: map['companyName'],
      country: map['country'],
      isVerified: map['isVerified'],
      state: map['state'],
      telephone: map['telephone'],
      website: map['website'],
      password: map['password'],
      role: map['role'],
    );
  }

  Future<void> createStakeholder(String? stakeholderID) async {
    await FirebaseFirestore.instance.collection('stakeholder').doc(stakeholderID).set(toMap(stakeholderID));
  }

  // Sending data to the server
  Map<String, dynamic> toMap(String? stakeholderID) {
    return {
      'uid': stakeholderID,
      'email': email,
      'address': address,
      'city': city,
      'companyName': companyName,
      'country': country,
      'isVerified': isVerified,
      'state': state,
      'telephone': telephone,
      'website': website,
      'password': password,
      'role': role,
    };
  }

  String getCurrentUserID() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userID = user.uid;
      print('Current user ID: $userID');
      return userID;
    } else {
      print('No user is currently signed in.');
      return '';
    }
  }
}