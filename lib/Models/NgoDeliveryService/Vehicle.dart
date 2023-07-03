import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class Vehicle {
  CollectionReference surplus = FirebaseFirestore.instance.collection(
      'vehicles');
  String? stakeholderId;
  String? vehicleId;
  String? carPlateNumber;
  String? carName;
  String? carDescription;
  String? image;


  Vehicle({
    this.stakeholderId,
    this.vehicleId,
    this.carPlateNumber,
    this.carName,
    this.carDescription,
    this.image,


  });

  // receiving data from server
  factory Vehicle.fromMap(map) {
    return Vehicle(
      stakeholderId: map['stakeholderId'],
      vehicleId: map['vehicleId'],
      carPlateNumber: map['carPlateNumber'],
      carDescription: map['carDescription'],
      image:map['image'],

    );
  }

  void AddVehicle(String? vehicleId) async {
    await FirebaseFirestore.instance.collection('vehicles').doc(vehicleId).set({
      'vehicleId': vehicleId,
      'stakeholderId': stakeholderId,
      'carPlateNumber': carPlateNumber,
      'carDescription': carDescription,
      'carName': carName,
      'image':image,
    });
  }

  // sending data to our server
  Map<String, dynamic> toMap(String? vehicleId) {
    print(vehicleId);
    return {
      'vehicleId': vehicleId,
      'stakeholderId': stakeholderId,
      'carPlateNumber': carPlateNumber,
      'carDescription': carDescription,
      'carName': carName,
      'image':image,
    };
  }

}
