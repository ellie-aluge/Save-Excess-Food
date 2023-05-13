import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class DonationFoodModel {
  CollectionReference surplus = FirebaseFirestore.instance.collection('surplusFood');
  String? surplusId;
  String? surplusTitle;
  String? categoryId;
  bool? isVerified;
  String? imageUrl;
  String? city;
  String? state;
  String? country;
  String? address;
  String? telephone;
  String? password;
  String? role;


  Stakeholder({
    this.surplusId,
    this.surplusTitle,
    this.address,
    this.city,
    this.categoryId,
    this.country,
    this.isVerified,
    this.state,
    this.telephone,
    this.imageUrl,
    this.password,
    this.role,

  });

  // receiving data from server
  factory Stakeholder.fromMap(map) {
    return Stakeholder(
      surplusId: map['surplusId'],
      surplusTitle: map['surplusTitle'],
      address: map['address'],
      city: map['city'],
      categoryId: map['categoryId'],
      country: map['country'],
      isVerified: map['isVerified'],
      state: map['state'],
      telephone: map['telephone'],
      imageUrl: map['imageUrl'],
      password: map['password'],
      role: map['role'],
    );
  }

  void CreateStakeholder (String? stakeholderID) async{
    await FirebaseFirestore.instance.collection('stakeholder').doc(stakeholderID).set({
      'surplusId': stakeholderID,
      'surplusTitle': surplusTitle,
      'address': address,
      'city': city,
      'categoryId': categoryId,
      'country': country,
      'isVerified': isVerified,
      'state': state,
      'telephone': telephone,
      'imageUrl': imageUrl,
      'password': password,
      'role' :role,
    });
  }
  // sending data to our server
  Map<String, dynamic> toMap(String? stakeholderID) {
    print (surplusId);
    return {
      'surplusId': stakeholderID,
      'surplusTitle': surplusTitle,
      'address': address,
      'city': city,
      'categoryId': categoryId,
      'country': country,
      'isVerified': isVerified,
      'state': state,
      'telephone': telephone,
      'imageUrl': imageUrl,
      'password': password,
      'role' :role,
    };
  }





}
