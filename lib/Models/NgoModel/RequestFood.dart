import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class RequestFood {
  CollectionReference requestFood = FirebaseFirestore.instance.collection('requestFood');
  String? requestFoodId;
  String? surplusId;
  String? deliveryServiceId;
  String? deliveryAddress;
  DateTime? pickupDate;
  // List? foodItems;
  String? description;
  String? NgoId;





  RequestFood({
    this.requestFoodId,
    this.surplusId,
    this.deliveryServiceId,
    this.deliveryAddress,
    this.pickupDate,
    this.description,
    this.NgoId,

  });



  // receiving data from server
  factory RequestFood.fromMap(map) {
    return RequestFood(
      requestFoodId: map['requestFoodId'],
      surplusId: map['surplusId'],
      deliveryServiceId: map['deliveryServiceId'],
      deliveryAddress: map['deliveryAddress'],
      pickupDate: map['pickupDate'],
      description: map['description'],
      NgoId: map['NgoId'],


    );
  }

  void AddSurplusFood (String? stakeholderID) async{
    await FirebaseFirestore.instance.collection('surplusFood').doc(surplusId).set({
      'requestFoodId': requestFoodId,
      'surplusId': surplusId,
      'deliveryServiceId': deliveryServiceId,
      'deliveryAddress': deliveryAddress,
      'pickupDate': pickupDate,
      'description': description,
      'NgoId': NgoId,
    });
  }

  // sending data to our server
  Map<String, dynamic> toMap(String? requestFoodId) {
    print (requestFoodId);
    return {
      'requestFoodId': requestFoodId,
      'surplusId': surplusId,
      'deliveryServiceId': deliveryServiceId,
      'deliveryAddress': deliveryAddress,
      'pickupDate': pickupDate,
      'description': description,
      'NgoId':NgoId,
    };
  }

}
