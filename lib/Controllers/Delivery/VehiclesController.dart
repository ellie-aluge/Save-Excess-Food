import 'package:flutter/material.dart';
import 'package:fyp/Models/NgoDeliveryService/Vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class VehiclesController {
  final CollectionReference vehicles = FirebaseFirestore.instance.collection('vehicles');

  static Future<String> addVehicles(Vehicle vehicle) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference vehicles = FirebaseFirestore.instance.collection('vehicles');

      DocumentReference vehicleReference= vehicles.doc();
      String vehicleId= vehicleReference.id;
      await vehicleReference.set(vehicle.toMap(vehicleId));


      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

// Future getFoodItems() async {
//   List itemsList = [];
//
//   try {
//
//     await foodItems.get().then((querySnapshot) {
//       querySnapshot.docs.forEach((element) {
//         // print(element.data());
//
//         print(element.reference);
//         itemsList.add(element.data());
//
//         print(itemsList[0]);
//
//       });
//     });
//
//     return itemsList;
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
}
