import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


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

  });

  // receiving data from server
  factory Stakeholder.fromMap(map) {
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
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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
    };
  }



}
