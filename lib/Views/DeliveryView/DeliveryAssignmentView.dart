import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:intl/intl.dart';
import 'package:fyp/Views/DeliveryView/AssignmentDetails.dart';
import 'package:fyp/Models/AdministratorModel/Stakeholder.dart';


class DeliveryAssignmentView extends StatefulWidget {
  const DeliveryAssignmentView({Key? key}) : super(key: key);

  @override
  State<DeliveryAssignmentView> createState() => _DeliveryAssignmentViewState();
}

class _DeliveryAssignmentViewState extends State<DeliveryAssignmentView> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _assignmentStream =
  Stream.empty();

  @override
  void initState() {
    super.initState();
    initializeAssignmentsStream();
  }

  void initializeAssignmentsStream() async {
    String userId = Stakeholder().getCurrentUserID();
    setState(() {
      _assignmentStream = FirebaseFirestore.instance
          .collection('requestFood')
          .where('deliveryServiceId', isEqualTo: userId)
          .snapshots();
    });
  }



  Color getStatusColor(String status) {
    if (status == 'pending') {
      return Colors.red;
    } else if (status == 'delivered') {
      return Colors.green;
    } else if (status == 'picked up') {
      return Colors.blue;
    }
    // Return a default color if the status doesn't match any condition
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _assignmentStream,
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
              var requestData = snapshot.data!.docs[index];
              var timestamp = requestData['pickupDate'];
              DateTime dateTime = timestamp.toDate();
              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
              String formattedTime = DateFormat('HH:mm').format(dateTime);
              var deliveryAddress = requestData['deliveryAddress'];
              var requestFoodId = requestData['requestFoodId'];
              var description = requestData['description'];
              var status = requestData['status'];
              var surplusId= requestData['surplusId'];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            requestFoodId,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Table(
                                defaultColumnWidth: FixedColumnWidth(110.0),
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
                                      // TableCell(
                                      //   child: Text(
                                      //     status,
                                      //     style: TextStyle(
                                      //       color: getStatusColor(status),
                                      //       fontSize: 10,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                          Text(
                                status,
                                style: TextStyle(
                                  color: getStatusColor(status),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: GlobalColors.gradientColor,
                          ),
                          child: Text('View More'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AssignmentDetails(
                                  surplusId: surplusId,
                                  formattedDate: formattedDate,
                                  formattedTime:formattedTime,
                                  deliveryAddress:deliveryAddress,
                                  requestFoodId:requestFoodId,
                                  description:description,
                                  status:status,

                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


