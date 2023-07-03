import 'package:flutter/material.dart';
import 'package:fyp/Models/NgoModel/RequestFood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RequestFoodController {
  final CollectionReference requestFood = FirebaseFirestore.instance.collection('requestFood');

  static Future<String> addFoodRequest(RequestFood requestFood) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference request = FirebaseFirestore.instance.collection('requestFood');


      DocumentReference requestFoodItemReference= request.doc();
      String requestFoodId= requestFoodItemReference.id;
      await requestFoodItemReference.set(requestFood.toMap(requestFoodId));


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
