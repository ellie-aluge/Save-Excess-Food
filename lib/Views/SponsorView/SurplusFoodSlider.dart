import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SurplusFoodSlider extends StatelessWidget {

  const SurplusFoodSlider({Key? key, required this.foodList}) : super(key: key);
  final List<dynamic> foodList;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foodItems').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final foodItems = snapshot.data!.docs;

          final filteredFoodItems = foodItems.where((foodItem) {
            final id = foodItem.id;
            return foodList.contains(id);
          }).toList();

          return Container(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredFoodItems.length,
              itemBuilder: (context, index) {
                final foodItem = filteredFoodItems[index];
                final id = foodItem.id;
                final imageUrl = foodItem['image'];
                final title = foodItem['group'];
                final subtitle = foodItem['name'];
                final shelfLife = foodItem['shelfLife'];

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        shelfLife.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error loading food items');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}