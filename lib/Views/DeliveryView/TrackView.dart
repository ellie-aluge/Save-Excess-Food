import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TrackViewPage extends StatefulWidget {
  final String deliveryStatus, requestFoodId;

  TrackViewPage({
    required this.deliveryStatus,
    required this.requestFoodId,
  });

  @override
  State<TrackViewPage> createState() => _TrackViewPageState();
}

class _TrackViewPageState extends State<TrackViewPage> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('requestFood')
        .doc(widget.requestFoodId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = 0.0;

    if (widget.deliveryStatus.toString() == 'pending') {
      percentage = 20.0;
    } else if (widget.deliveryStatus.toString() == 'pickedUp') {
      percentage = 50.0;
    } else if (widget.deliveryStatus.toString() == 'delivered') {
      percentage = 100.0;
    }

    String formattedPercentage = percentage.toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text('Track Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child:Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              value: percentage / 100,
                              strokeWidth: 20,
                              color: GlobalColors.mainColor,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          Text(
                            '$formattedPercentage%',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 10),
                          Text(
                            'ID: ${widget.requestFoodId}',
                            style: TextStyle(fontSize: 14, color:GlobalColors.maroon,fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ),
            SizedBox(height: 36),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data();
                  var deliveryCollectionData =
                  data!['delivery_collection'] as List<dynamic>?; // Add null check
                  if (deliveryCollectionData != null &&
                      deliveryCollectionData.isNotEmpty) {
                    List<Widget> statusPoints = [
                      _buildStatusPoint(
                        'Request placed',
                        true,
                        getDateFromTimestamp(data, 'dateRequested'),
                        getTimeFromTimestamp(data, 'dateRequested'),
                      ),
                      _buildStatusPoint(
                        'Assigned to Delivery Service',
                        true,
                        getDateFromTimestamp(data, 'dateRequested'),
                        getTimeFromTimestamp(data, 'dateRequested'),
                      ),
                      _buildStatusPoint(
                        'Preparing for pickup',
                        true,
                        getDateFromTimestamp(data, 'dateRequested'),
                        getTimeFromTimestamp(data, 'dateRequested'),
                      ),
                    ];


                    for (var deliveryData in deliveryCollectionData) {
                      statusPoints.add(
                        _buildStatusPoint(
                          'Out for delivery',
                          widget.deliveryStatus == 'pickedUp' || widget.deliveryStatus == 'delivered',
                          getDateFromTimestamp(deliveryData, 'datePicked'),
                          getTimeFromTimestamp(deliveryData, 'datePicked'),
                        ),
                      );
                    }

                    statusPoints.add(_buildStatusPoint(
                        'Delivered',
                        widget.deliveryStatus=='delivered'??true,
                        getDateFromTimestamp(
                            deliveryCollectionData.last, 'dateDelivered'),
                        getTimeFromTimestamp(
                            deliveryCollectionData.last, 'dateDelivered')));

                    return Column(
                      children: statusPoints,
                    );
                  }
              else {
              return Column(
              children: [
              _buildStatusPoint(
              'Request placed',
              true,
              getDateFromTimestamp(data, 'dateRequested'),
              getTimeFromTimestamp(data, 'dateRequested'),
              ),
              _buildStatusPoint(
              'Assigned to Delivery Service',
              true,
              getDateFromTimestamp(data, 'dateRequested'),
              getTimeFromTimestamp(data, 'dateRequested'),
              ),
              _buildStatusPoint(
              'Preparing for pickup',
              true,
              getDateFromTimestamp(data, 'dateRequested'),
              getTimeFromTimestamp(data, 'dateRequested'),
              ),
                _buildStatusPoint(
                  'Out for delivery',
                  false,
                  getDateFromTimestamp(data, ''),
                  getTimeFromTimestamp(data, ''),
                ),
                _buildStatusPoint(
                  'Delivered',
                  false,
                  getDateFromTimestamp(data, ''),
                  getTimeFromTimestamp(data, ''),
                ),
              ],
              );
              }

                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String getDateFromTimestamp(
      Map<String, dynamic> data,
      String fieldName,
      ) {
    if (data != null && data[fieldName] != null) {
      Timestamp timestamp = data[fieldName];
      DateTime date = timestamp.toDate();
      return DateFormat('MMM dd, yyyy').format(date);
    } else {
      return '';
    }
  }

  String getTimeFromTimestamp(
      Map<String, dynamic> data,
      String fieldName,
      ) {
    if (data != null && data[fieldName] != null) {
      Timestamp timestamp = data[fieldName];
      DateTime date = timestamp.toDate();
      return DateFormat('HH:mm').format(date);
    } else {
      return '';
    }
  }

  Widget _buildStatusPoint(
      String text,
      bool isCompleted,
      String date,
      String time,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.circle,
                color: isCompleted ? GlobalColors.maroon : Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: _buildStatusLine(),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusLine() {
    return Container(
      height: 32,
      child: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }
}
