import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:intl/intl.dart';
import 'package:fyp/Views/SponsorView/SurplusDetails.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';

class SurplusFoodView extends StatefulWidget {
  const SurplusFoodView({Key? key}) : super(key: key);

  @override
  State<SurplusFoodView> createState() => _SurplusFoodViewState();
}

class _SurplusFoodViewState extends State<SurplusFoodView> {
  int? quantity;
  String? userId, userRole;
  Stream<QuerySnapshot<Map<String, dynamic>>> _foodStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    initializeFoodStream();
  }

  void initializeFoodStream() async {
    String? userRole = await Stakeholder().getRole();
    print(userRole);

    if (userRole != null && userRole.toLowerCase() == "ngo") {
      setState(() {
        _foodStream = FirebaseFirestore.instance.collection('surplusFood').snapshots();
      });
    } else {
      String userId = Stakeholder().getCurrentUserID();
      setState(() {
        _foodStream = FirebaseFirestore.instance
            .collection('surplusFood')
            .where('stakeholderId', isEqualTo: userId)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _foodStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No surplus food available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var foodData = snapshot.data!.docs[index];
              var imageUrl = foodData['image'];
              Timestamp timestamp = foodData['date'];
              DateTime dateTime = timestamp.toDate();
              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
              var date = formattedDate;
              var location = foodData['location'];
              var title = foodData['surplusTitle'];
              var description = foodData['description'];

              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                leading: Container(
                  width: 100,
                  height: 100,
                  child:imageUrl != null
                      ? Image.network(
                    imageUrl!,
                    width: 100,
                    height: 100,
                  )
                      : Image.asset(
                    'assets/admin/assigned.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: GlobalColors.titleHeading,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      location,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Expiry: $date',
                      style: TextStyle(color: Colors.red, fontSize: 9),
                    ),
                  ],
                ),
                onTap: () {
                  quantity = foodData['quantity'];
                  var id = foodData['surplusId'];
                  List<dynamic> foodList = foodData['foodItems'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurplusDetails(
                        id: id,
                        date: date,
                        location: location,
                        imageUrl: imageUrl,
                        title: title,
                        description: description,
                        quantity: quantity,
                        foodList: foodList,
                        userRole:userRole,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
