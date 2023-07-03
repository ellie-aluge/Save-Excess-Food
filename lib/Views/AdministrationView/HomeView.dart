import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:fyp/Views/AdministrationView/TradeMark.dart';
import 'package:fyp/Views/DonationView/DonateFoodView.dart';
import 'package:fyp/Views/DonationView/DonateFundView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
// import 'package:fyp/Views/DonationView/DonateFundView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final List<String> carouselList = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwj8zyvZHhVPwasGdpnso2k9_JTJ0fsKUPlg&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkqNM677x7FgB3xKENdxvLBzne7xBFWtWK0g&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3I9u0E9QegxoPhKs9rNBCWtzmsGzPhkIbfg&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY-wmPqzUHQI-4b2yo0XbzYEbRfL-HDSj6QQ&usqp=CAU',
    ];
    return Container(

      color: GlobalColors.inputBorder,
        child: SingleChildScrollView(
          child:Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height*1.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationAlert(),
                CarouselSlider(
                  items: carouselList.map((imageUrl) {
                    return Container(
                      height: 3000,
                      margin: EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    viewportFraction: 1,
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  color: GlobalColors.greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(25),
                          width: 200,
                          child: Column(
                            children: [
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'FOOD',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Expanded(
                                      child: Text(
                                        'Donation of food and money keep The Lost Food Project running. Donate to a cause that feeds thousands every day.',
                                        style: TextStyle(fontSize: 12.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: GlobalColors.inputBorder,
                                          side: BorderSide(
                                            width: 2.0,
                                            color: GlobalColors.mainColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DonateFoodView(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'DONATE FOOD',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: GlobalColors.mainColor,
                                          ),
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(25),
                          width: 200,
                          child: Column(
                            children: [
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'FUNDS',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Center(
                                      child: Text(
                                        'Donation of food and money keep The Lost Food Project running. Donate to a cause that feeds thousands every day.',
                                        style: TextStyle(fontSize: 12.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: GlobalColors.inputBorder,
                                            side: BorderSide(
                                              width: 2.0,
                                              color: GlobalColors.mainColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DonateFundView(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'DONATE FUND',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: GlobalColors.mainColor,
                                            ),
                                          ),
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
                
                Container(
                  margin: EdgeInsets.only(top:20, left:30),
                  child: Column(
                    children:[
                      Row(
                          children:[
                            Text('IMPACT', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('VIEW MORE'),
                      ]),

                    ]
                  )

                ),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                      height:50,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final reports = snapshot.data!.docs;
                            return CarouselSlider(
                              items: reports.map((report) {
                                final image = report['image'];
                                final description = report['description'];
                                final reportTitle = report['reportTitle'];
                                return Card(
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned.fill(
                                          child: Container(
                                            color: Colors.black.withOpacity(0.8),
                                          ),
                                      ),
                                      Positioned(
                                        left: 8,
                                        bottom: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reportTitle,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width:200,
                                                child: Text(
                                                  description,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: false,
                                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                viewportFraction: 0.7,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),

                    ),
               ),

                Container(
                    height:30,
                    child: TradeMark(),

                ),
              ],
            ),
          ),

        )
    );

  }
}