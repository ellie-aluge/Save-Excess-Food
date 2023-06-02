import 'package:flutter/material.dart';
import 'package:fyp/Models/AdministratorModel/FoodItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FoodItemController {
  final CollectionReference foodItems = FirebaseFirestore.instance.collection('foodItems');

  static Future<String> addFoodItem(FoodItem foodItems) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference FoodItem = FirebaseFirestore.instance.collection('foodItems');


      DocumentReference foodItemReference= FoodItem.doc();
      String foodItemId= foodItemReference.id;
      await foodItemReference.set(foodItems.toMap(foodItemId));


      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

   Future getFoodItems() async {
    List itemsList = [];

    try {

      await foodItems.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          // print(element.data());

          print(element.reference);
          itemsList.add(element.data());

          print(itemsList[0]);

        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
