import 'package:cloud_firestore/cloud_firestore.dart';

class SurplusFoodController {
  final CollectionReference surplusFoodCollection =
  FirebaseFirestore.instance.collection('surplusFood');

  Future<List<SurplusFood>> getSurplusFoodList() async {
    QuerySnapshot snapshot = await surplusFoodCollection.get();
    List<SurplusFood> surplusFoodList = [];

    snapshot.docs.forEach((doc) {
      String image = doc['image'];
      DateTime date = doc['date'];
      String location = doc['location'];
      String surplusTitle = doc['surplusTitle'];
      String description = doc['description'];
      int quantity= doc['quantity'];

      SurplusFood food = SurplusFood(
        image: image,
        date: date,
        location: location,
        surplusTitle: surplusTitle,
        description: description,
      );

      surplusFoodList.add(food);
    });

    return surplusFoodList;
  }
}