import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class FoodItem {
  CollectionReference foodItems = FirebaseFirestore.instance.collection('foodItems');
  String? foodItemId;
  String? category;
  String? group;
  String? name;
  int? shelfLife;
  String? image;



  FoodItem({
    this.foodItemId,
    this.category,
    this.group,
    this.name,
    this.shelfLife,
    this.image,


  });

  // receiving data from server
  factory FoodItem.fromMap(map) {
    return FoodItem(
      foodItemId: map['foodItemId'],
      name: map['name'],
      category: map['category'],
      group: map['group'],
      shelfLife: map['shelfLife'],
      image: map['image'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap(String? foodItemId) {
    return {
      'foodItemId': foodItemId,
      'name': name,
      'category': category,
      'group': group,
      'shelfLife': shelfLife,
      'image': image,
    };
  }


  // try {
  // DocumentReference docRef = foodItemsCollection.doc();
  // String foodId = docRef.id;
  //
  // await docRef.set({
  // 'foodId': foodId,
  // 'foodName': foodName,
  // 'quantity': quantity,
  // });
  //
  // print('New Food Item ID: $foodId');
  // } catch (e) {
  // print('Error adding food item: $e');
  // }
// Future void addFoodItem()
//   {
//     try {
//       DocumentReference docRef = await foodItemsCollection.add({
//         'foodName': foodName,
//         'quantity': quantity,
//       });
//
//       String foodId = docRef.id;
//       print('New Food Item ID: $foodId');
//     } catch (e) {
//       print('Error adding food item: $e');
//     }
//
//   }




  }
