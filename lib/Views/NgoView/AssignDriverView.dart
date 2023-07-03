import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:intl/intl.dart';
import 'package:fyp/Views/NgoView/DeliveryDetailsView.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:fyp/Models/NgoModel/RequestFood.dart';
import 'package:fyp/Views/AdministrationView/SuccessfulFormView.dart';
import 'package:fyp/Controllers/DonationController/RequestFoodController.dart';

class AssignDriverView extends StatefulWidget {
  final String? surplusId;
  final String? deliveryAddress;
  final DateTime? pickupDate;
  final String? description;
  AssignDriverView({required  this.surplusId,
                    required this.pickupDate,
                    required this.description,
                    required this.deliveryAddress});

  @override
  State<AssignDriverView> createState() => _AssignDriverViewState();
}

class _AssignDriverViewState extends State<AssignDriverView> {
  int? quantity;
  String? userId, userRole;
  Stream<QuerySnapshot<Map<String, dynamic>>> _deliveryStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    initializeDeliveryStream();
  }

  void initializeDeliveryStream() async {
      setState(() {
        _deliveryStream =
            FirebaseFirestore.instance.collection('stakeholder').where('role', isEqualTo: 'Delivery').snapshots();
      });
  }

  void requestFood() async
  {
    String? NgoId= Stakeholder().getCurrentUserID();
    RequestFood requestFood = RequestFood(surplusId:widget.surplusId,
                                          deliveryAddress:widget.deliveryAddress,
                                          pickupDate: widget.pickupDate,
                                          deliveryServiceId: userId,
                                          description:widget.description,
                                          NgoId:NgoId);

    String addStatus  = await RequestFoodController.addFoodRequest(requestFood);
    if (addStatus == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulFormView()),);
    } else {
      print (addStatus);
      // Display error message to user
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:Text('Assign Delivery'),
          backgroundColor: GlobalColors.mainColor,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _deliveryStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No delivery services available.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var deliveryData = snapshot.data!.docs[index];
                var imageUrl = deliveryData['image'];
                var location = deliveryData['address'];
                var name = deliveryData['companyName'];
                var email = deliveryData['email'];
                var telephone = deliveryData['telephone'];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  leading: Container(
                    width: 80,
                    decoration: BoxDecoration(
                image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                ),
                    ),
                    // child: Image.network(imageUrl, width: 300, height: 300,),

                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      color: GlobalColors.titleHeading,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        telephone,
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      SizedBox(height: 3),
                      Text(
                        ' $email',
                        style: TextStyle( fontSize:11),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: GlobalColors.inputBorder,
                      side: BorderSide(
                        width: 2.0,
                        color: GlobalColors.mainColor,
                      ),
                    ),
                    onPressed: () {
                       userId = deliveryData['uid'];
                       requestFood();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AssignDriverView(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'ASSIGN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.mainColor,
                      ),
                    ),
                  ),
                  onTap: () {
                    quantity = deliveryData['quantity'];
                    var id = deliveryData['surplusId'];
                    List<dynamic> foodList = deliveryData['foodItems'];
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => DeliveryDetailsView(
                    //       id: id,
                    //       date: date,
                    //       location: location,
                    //       imageUrl: imageUrl,
                    //       title: title,
                    //       description: description,
                    //       quantity: quantity,
                    //       foodList: foodList,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
            );
          },
        ),
      );
    }
  }

