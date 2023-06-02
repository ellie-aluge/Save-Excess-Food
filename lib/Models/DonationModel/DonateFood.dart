import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class DonateFood {
  CollectionReference surplus = FirebaseFirestore.instance.collection('surplusFood');
  String? surplusId;
  String? surplusTitle;
  String? stakeholderId;
  String? image;
  String? location;
  int? quantity;
  DateTime? date;
  List? foodItems;
  String? description;





  DonateFood({
    this.surplusId,
    this.surplusTitle,
    this.stakeholderId,
    this.image,
    this.location,
    this.quantity,
    this.date,
    this.foodItems,
    this.description,

  });

  // receiving data from server
  factory DonateFood.fromMap(map) {
    return DonateFood(
      surplusId: map['surplusId'],
      surplusTitle: map['surplusTitle'],
      stakeholderId: map['stakeholderId'],
      image: map['image'],
      location: map['location'],
      quantity: map['quantity'],
      date: map['date'],
      foodItems: map['foodItems'],
      description: map['description'],

    );
  }

  void AddSurplusFood (String? stakeholderID) async{
    await FirebaseFirestore.instance.collection('surplusFood').doc(surplusId).set({
      'surplusId': surplusId,
      'stakeholderId':stakeholderId,
      'surplusTitle': surplusTitle,
      'location': location,
      'image': image,
      'quantity': quantity,
      'date': date,
      'foodItems': foodItems,
      'description': description,
    });
  }
  // sending data to our server
  Map<String, dynamic> toMap(String? surplusId) {
    print (surplusId);
    return {
    'surplusId': surplusId,
      'stakeholderId':stakeholderId,
    'surplusTitle': surplusTitle,
    'location': location,
    'image': image,
    'quantity': quantity,
    'date': date,
      'foodItems':foodItems,
      'description': description,
    };
  }





}
