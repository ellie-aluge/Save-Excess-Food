import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/Views/NavigationSideBar/NavigationDrawer.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';
import 'package:fyp/Views/NgoView/RequestDetails.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:intl/intl.dart';

class ManageRequests extends StatefulWidget {
  @override
  _ManageRequestsState createState() => _ManageRequestsState();
}

class _ManageRequestsState extends State<ManageRequests> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _pendingStream = Stream.empty();
  Stream<QuerySnapshot<Map<String, dynamic>>> _pickedUpStream = Stream.empty();
  Stream<QuerySnapshot<Map<String, dynamic>>> _deliveredStream = Stream.empty();
  Stream<QuerySnapshot<Map<String, dynamic>>> _surplusStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    initializeRequestsStream();
  }

  void initializeRequestsStream() async {
    String userId = Stakeholder().getCurrentUserID();
    setState(() {
      _pendingStream = FirebaseFirestore.instance
          .collection('requestFood')
          .where('NgoId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .snapshots();
      _pickedUpStream = FirebaseFirestore.instance
          .collection('requestFood')
          .where('NgoId', isEqualTo: userId)
          .where('status', isEqualTo: 'pickedUp')
          .snapshots();
      _deliveredStream = FirebaseFirestore.instance
          .collection('requestFood')
          .where('NgoId', isEqualTo: userId)
          .where('status', isEqualTo: 'delivered')
          .snapshots();
    });
  }

  void initializeSurplusStream(String surplusId) async {
    setState(() {
      _surplusStream = FirebaseFirestore.instance
          .collection('surplusFood')
          .where('surplusId', isEqualTo: surplusId)
          .snapshots();
    });
  }

  Color getStatusColor(String status) {
    if (status == 'pending') {
      return Colors.pink;
    } else if (status == 'delivered') {
      return Colors.green;
    } else if (status == 'pickedUp') {
      return Colors.blue;
    }
    // Return a default color if the status doesn't match any condition
    return Colors.black;
  }



  Widget buildRequestList(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream,
      String status,
      ) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No surplus food request available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var requestData = snapshot.data!.docs[index];
            var timestamp = requestData['pickupDate'];
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
            String formattedTime = DateFormat('HH:mm').format(dateTime);
            var deliveryAddress = requestData['deliveryAddress'];
            var requestFoodId = requestData['requestFoodId'];
            var description = requestData['description'];
            var surplusId = requestData['surplusId'];
            var deliveryServiceId= requestData['deliveryServiceId'];

            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('surplusFood')
                  .doc(surplusId)
                  .snapshots(),
              builder: (context, surplusSnapshot) {
                if (surplusSnapshot.hasError) {
                  // Handle the error case
                  return SizedBox.shrink();
                }

                if (surplusSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  // Show a loading indicator while fetching the surplus food data
                  return Center(child: CircularProgressIndicator());
                }

                if (!surplusSnapshot.hasData ||
                    !surplusSnapshot.data!.exists) {
                  // Handle if the surplusFood document doesn't exist
                  return SizedBox.shrink();
                }

                var surplusData = surplusSnapshot.data!.data();
                if (surplusData == null) {
                  // Handle if the surplusData is null
                  return SizedBox.shrink();
                }

                var surplusTitle = surplusData['surplusTitle'];
                var imageUrl= surplusData['image'];
                var pickUpLocation = surplusData['location'];
                var quantity= surplusData['quantity'];
                var donorId= surplusData['stakeholderId'];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                            child:ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Container(
                                width: 90,
                                child:  Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),

                              ),
                              title: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surplusTitle,
                                      style: TextStyle(
                                        color: GlobalColors.titleHeading,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),

                                        Text(
                                          pickUpLocation,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                              trailing: Container(
                                width: 50,
                                // height: 100,
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: status == 'pending'
                                            ? Image.asset('assets/admin/assigned.jpg')
                                            : status == 'pickedUp'
                                            ? Image.asset('assets/admin/picked.jpg')
                                            : status == 'delivered'
                                            ? Image.asset('assets/admin/delivered.jpg')
                                            : SizedBox.shrink(),
                                      ),



                                      // SizedBox(width: 4),
                                      Text(
                                        status=='pending'?'Assigned'
                                        :status=='pickedUp'? 'Picked'
                                        :'Delivered',
                                        style: TextStyle(
                                          color: getStatusColor(status),
                                          fontSize: 10,
                                          fontWeight:FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                    defaultColumnWidth: FixedColumnWidth(90.0),
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              'Pickup Date:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Pickup Time:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              formattedDate,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              formattedTime,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('quantity: $quantity',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => RequestDetails(
                                                  surplusTitle: surplusTitle,
                                                  quantity: quantity,
                                                  surplusId: surplusId,
                                                  formattedDate: formattedDate,
                                                  formattedTime: formattedTime,
                                                  deliveryAddress: deliveryAddress,
                                                  requestFoodId: requestFoodId,
                                                  description: description,
                                                  status: status,
                                                  deliveryServiceId: deliveryServiceId,
                                                  donorId: donorId,

                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'VIEW MORE',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.titleHeading,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          title: Center(child: Text("Save Excess Foods")),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Assigned'),
              Tab(text: 'Picked Up'),
              Tab(text: 'Delivered'),
            ],
          ),
        ),
        drawer: Navigation(),
        body: Container(
          height: 1000,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    "MANAGE REQUESTS",
                    style: TextStyle(
                      color: GlobalColors.titleHeading,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildRequestList(_pendingStream, 'pending'),
                    buildRequestList(_pickedUpStream, 'pickedUp'),
                    buildRequestList(_deliveredStream, 'delivered'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
