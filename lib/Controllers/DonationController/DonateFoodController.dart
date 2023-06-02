import 'package:flutter/material.dart';
import 'package:fyp/Models/DonationModel/DonateFood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DonateFoodController {
  final CollectionReference surplusFood = FirebaseFirestore.instance.collection('surplusFood');

  static Future<String> addSurplusFood(DonateFood surplusFood) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference surplus = FirebaseFirestore.instance.collection('surplusFood');


      DocumentReference surplusFoodItemReference= surplus.doc();
      String surplusItemId= surplusFoodItemReference.id;
      await surplusFoodItemReference.set(surplusFood.toMap(surplusItemId));


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
