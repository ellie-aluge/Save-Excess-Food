import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
import 'package:fyp/Views/AdministrationView/TradeMark.dart';

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
    return Column(
      children: [
// SizedBox(height:30),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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

// Expanded(child: child),
        Container(
            height: 210,
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: GlobalColors.greyColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child:   Container(
                    padding: EdgeInsets.all(25),
                    width: 200,
                    child: Column(
                        children: [

                          Flexible(
                            child: Wrap(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'FOOD',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 30),

                                Expanded(
                                  child: Text(
                                    'Donation of food and money keep The Lost Food Project running. Donate to a cause that feeds thousands everyday.',
                                    style: TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),


                                Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: GlobalColors
                                            .inputBorder,
                                        side: BorderSide(
                                          width: 2.0,
                                          color: GlobalColors.mainColor,
                                        ),

                                      ),

                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SponsorHomeView()),);
                                      },
                                      child:  Text(
                                          'DONATE FOOD',
                                          style: TextStyle(
                                            fontWeight: FontWeight
                                                .bold,
                                            color:GlobalColors.mainColor,
                                          )),
                                    )
                                ),


                              ],
                            ),
                          ),
// Text('DONATE'),
// Text('Donations go a long way'),

                        ]
                    )
                ),),



                Expanded(child:  Container(
                    padding: EdgeInsets.all(25),
                    width: 200,
                    child: Column(
                        children: [

                          Flexible(
                            child: Wrap(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'FUNDS',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 30),

                                Center(
                                  child: Text(
                                    'Donation of food and money keep The Lost Food Project running. Donate to a cause that feeds thousands everyday.',
                                    style: TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),


                                Expanded(
                                    child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: GlobalColors
                                                .inputBorder,
                                            side: BorderSide(
                                              width: 2.0,
                                              color: GlobalColors.mainColor,
                                            ),

                                          ),

                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SponsorHomeView()),);
                                          },
                                          child:  Text(
                                              'DONATE FUND',
                                              style: TextStyle(
                                                fontWeight: FontWeight
                                                    .bold,
                                                color:GlobalColors.mainColor,
                                              )),
                                        )
                                    )
                                )



                              ],
                            ),
                          ),
// Text('DONATE'),
// Text('Donations go a long way'),

                        ]
                    )
                ),),


              ],
            )
        ),


        Expanded(
            child:TradeMark()
        ),
      ],
    );
  }
}
