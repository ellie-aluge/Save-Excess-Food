import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:intl/intl.dart';

class SurplusFoodView extends StatefulWidget {
  const SurplusFoodView({Key? key}) : super(key: key);

  @override
  State<SurplusFoodView> createState() => _SurplusFoodViewState();
}

class _SurplusFoodViewState extends State<SurplusFoodView> {
  late Stream<QuerySnapshot> _foodStream;

  @override
  void initState() {
    super.initState();
    _foodStream = FirebaseFirestore.instance.collection('surplusFood').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _foodStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child:CircularProgressIndicator()) ;
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No surplus food available.');
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
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                leading: Container(
                  width: 100,
                  height: 100,
                  child: Image.network(imageUrl),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: GlobalColors.titleHeading,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SponsorHomeView()),
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