import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fyp/utils/global.colors.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({Key? key}) : super(key: key);

  @override
  _AnalysisViewState createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  late List<charts.Series<DataPoint, DateTime>> _lineSeriesList;
  late List<charts.Series<DataPoint, String>> _barSeriesList;
  num totalQuantity = 0;
  num _totalQuantity=0;
  @override
  void initState() {
    super.initState();
    _lineSeriesList = [];
    _barSeriesList = [];
    _fetchData();
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection('surplusFood')
        .snapshots()
        .listen((snapshot) {
      List<DataPoint> lineDataPoints = [];
      List<DataPoint> barDataPoints = [];
      Map<String, num> monthlyTotal = {};

      for (var doc in snapshot.docs) {
        var quantity = doc['quantity'];
        var timestamp = doc['date'];

        var date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
        var monthYear = '${date.month}-${date.year}';

        totalQuantity += quantity;
        if (monthlyTotal.containsKey(monthYear)) {
          monthlyTotal[monthYear] = monthlyTotal[monthYear]! + quantity;
        } else {
          monthlyTotal[monthYear] = quantity;
        }
      }

      monthlyTotal.forEach((monthYear, totalQuantity) {
        var parts = monthYear.split('-');
        var month = int.parse(parts[0]);
        var year = int.parse(parts[1]);
        var dateTime = DateTime(year, month);

        lineDataPoints.add(DataPoint(dateTime, totalQuantity.toInt()));
        barDataPoints.add(DataPoint(dateTime, totalQuantity.toInt()));
      });

      lineDataPoints.sort((a, b) => a.date.compareTo(b.date));
      barDataPoints.sort((a, b) => a.date.compareTo(b.date));

      setState(() {
        _totalQuantity = totalQuantity;
        _lineSeriesList = [
          charts.Series<DataPoint, DateTime>(
            id: 'Quantity',
            colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
            domainFn: (DataPoint data, _) => data.date,
            measureFn: (DataPoint data, _) => data.quantity,
            data: lineDataPoints,
          ),
        ];

        _barSeriesList = [
          charts.Series<DataPoint, String>(
            id: 'Quantity',
            colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
            domainFn: (DataPoint data, _) => data.date.toString(),
            measureFn: (DataPoint data, _) => data.quantity,
            data: barDataPoints,
          ),
        ];
      });
    });
  }

  String formatTickLabel(String label) {
    return label.replaceAll('-', '');
  }

  Widget buildPercentageWidget(double percentage) {
    String sign = percentage >= 0 ? '+' : '';
    String formattedPercentage = '${sign}${percentage.toStringAsFixed(1)}%';
    return Text(
      formattedPercentage,
      style: TextStyle(
        color: percentage >= 0 ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  double calculatePercentageChange(int oldValue, int newValue) {
    if (oldValue == 0) return 0.0;

    return ((oldValue - newValue) / newValue) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Surplus Food Quantity Analysis'),
      //   backgroundColor: GlobalColors.mainColor,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('surplusFood').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox();
                      }

                      var docs = snapshot.data!.docs;
                      if (docs.length < 2) {
                        return SizedBox();
                      }

                      var previousData = docs[docs.length - 2];
                      var currentData = docs[docs.length - 1];

                      var previousQuantity = previousData['quantity'];
                      var currentQuantity = currentData['quantity'];
                      var percentageChange = calculatePercentageChange(previousQuantity, currentQuantity);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                          children:[
                            Text(
                              'Total Surplus Distributed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              '$_totalQuantity',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                // color: GlobalColors.mainColor
                              ),
                            ),
                            SizedBox(height: 4.0),
                            buildPercentageWidget(percentageChange),
                          ]
                      )

                          ),


                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(16.0),
                  child: charts.TimeSeriesChart(
                    _lineSeriesList,
                    animate: true,
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                        desiredTickCount: 5,
                      ),
                    ),
                    domainAxis: charts.DateTimeAxisSpec(
                      tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                        day: charts.TimeFormatterSpec(
                          format: 'MMM d',
                          transitionFormat: 'MMM d',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: charts.BarChart(
                          _barSeriesList,
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              desiredTickCount: 5,
                            ),
                          ),
                          domainAxis: charts.OrdinalAxisSpec(
                            renderSpec: charts.SmallTickRendererSpec(
                              labelStyle: charts.TextStyleSpec(
                                fontSize: 11,
                              ),
                              labelRotation: 45,
                              labelAnchor: charts.TickLabelAnchor.after,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataPoint {
  final DateTime date;
  final int quantity;

  DataPoint(this.date, this.quantity);
}
