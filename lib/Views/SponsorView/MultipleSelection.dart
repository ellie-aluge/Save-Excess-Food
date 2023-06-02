import 'package:flutter/material.dart';
import 'package:fyp/Controllers/Administrator/FoodItemController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fyp/Views/DonationView/DonateFoodView.dart';
class MultipleSelection extends StatefulWidget {
  @override
  _MultipleSelectionState createState() => _MultipleSelectionState();
}

class _MultipleSelectionState extends State<MultipleSelection> {


  List <Map> _foodItemList=[];
  CollectionReference _foodItems= FirebaseFirestore.instance.collection('foodItems');



  List foodItemsList=[];
  List<String> selectedOptions = [];
  List <Map<String, dynamic>>? options;

  @override
  void initState() {
    getFoodItems().then((data) {

      setState(() {

      });
    });
    super.initState();
  }



  Future<void> getFoodItems() async {

    foodItemsList= await FoodItemController().getFoodItems();

    for(int i=0; i<foodItemsList.length;i++)
      {
        print(foodItemsList[i]['category']);
      }
    initializeOptions();
  }

  void initializeOptions() {
    options ??= [];
    for (var foodItem in foodItemsList) {
      Map<String, dynamic> option = {
        'title': foodItem['name'],
        'image': foodItem['image'],
        'description': foodItem['category'],
        'id':foodItem['foodItemId'],
        'isSelected': false,
      };
      options!.add(option);
    }
  }

  List <String> selectedId(){
    print (selectedOptions);
    return selectedOptions;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: options!.map((option) {
            bool isSelected = selectedOptions.contains(option['id']);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedOptions.remove(option['id']);
                  } else {
                    selectedOptions.add(option['id']);
                  }
                  DonateFoodView.updateSelectedOptions(selectedOptions);
                });
              },
              child: Container(
                width: 100,
                child: Column(
                  children: [
                    Image.network(
                      option['image'],
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(height: 4.0),
                    Text(option['title']),
                    Text(option['description']),
                    SizedBox(height: 4.0),
                    isSelected
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.check_circle_outline),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        // Text('Selected Options:'),
        // Wrap(
        //   spacing: 8.0,
        //   runSpacing: 8.0,
        //   children: selectedOptions.map((option) {
        //     return Chip(
        //       label: Text(option),
        //       onDeleted: () {
        //         setState(() {
        //           selectedOptions.remove(option);
        //         });
        //       },
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }
}