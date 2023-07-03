import 'package:flutter/material.dart';
import 'package:fyp/Models/NgoModel/Report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReportFoodController {
  final CollectionReference report = FirebaseFirestore.instance.collection('reports');

  static Future<String> addReport(Report reportItem) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference reports = FirebaseFirestore.instance.collection('reports');


      DocumentReference reportItemReference= reports.doc();
      String reportItemId= reportItemReference.id;
      await reportItemReference.set(reportItem.toMap(reportItemId));


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
