import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/LoginView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/Views/AdministrationView/TradeMark.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fyp/Views/AdministrationView/HomeView.dart';
import 'package:fyp/Views/SponsorView/SurplusFoodView.dart';
import 'package:fyp/Views/NgoView/AnalysisView.dart';
import 'package:fyp/Views/NavigationSideBar/NavigationDrawer.dart';
class NgoHomeView extends StatefulWidget {
  const NgoHomeView({Key? key}) : super(key: key);

  @override
  State<NgoHomeView> createState() => _NgoHomeViewState();
}

class _NgoHomeViewState extends State<NgoHomeView> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: GlobalColors.mainColor,
            elevation: 2,
            centerTitle: true,
            title: Text("Save Excess Food",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GlobalColors.containerField,

              ),),
            actions: [
              IconButton(
                  icon: Icon(Icons.notification_add),
                  onPressed: () {}),

              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {})
            ],
            bottom: TabBar(
                indicatorColor: GlobalColors.inputBorder,
                indicatorWeight: 5,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Image.asset(
                      'assets/admin/ngoLogo2.png', width: 23, height: 23),
                      text: 'NGO'),
                  Tab(icon: Icon(Icons.fastfood), text: 'Alerts'),
                  Tab(icon: Icon(Icons.bar_chart),
                      text: 'Analysis')
                ]
            ),
          ),

          drawer: Navigation(),

          body: TabBarView(
            children: [
              // Widget for the Home Page.

              HomeView(),

              // Widget for the NGO page.
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NotificationAlert(),

                    Row(
                      children: [

                        Container(
                          width: 200, // Adjust this to the width of your container
                          height: 200, // Adjust this to the height of your container
                          child: Image(
                            image: AssetImage('assets/admin/ngoLogo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),

                        Flexible(
                          child: Wrap(
                            children: <Widget>[
                              Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'The Lost Food Project',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )

                              ),
                              SizedBox(height: 30),

                              Center(
                                  child:Padding(
                                    padding:EdgeInsets.all(10),
                                    child: Text(
                                      'Approximately one-third of all food produced for human consumption is lost or wasted worldwide. This happens in the form of food loss – food that is damaged as it moves through the supply chain – and food waste – edible food that is thrown away by retailers or consumers.According to the U.N. Food and Agriculture Organization (FAO) reversing this trend would preserve enough food to feed 2 billion people . Thats more than twice the number of undernourished people across the globe ',
                                      style: TextStyle(fontSize: 12.0,
                                        height:1.5,),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )

                              ),







                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child:Padding(
                          padding:EdgeInsets.all(10),
                          child: Text(
                            'Approximately one-third of all food produced for human consumption is lost or wasted worldwide. This happens in the form of food loss – food that is damaged as it moves through the supply chain – and food waste – edible food that is thrown away by retailers or consumers.According to the U.N. Food and Agriculture Organization (FAO) reversing this trend would preserve enough food to feed 2 billion people . Thats more than twice the number of undernourished people across the globe ',
                            style: TextStyle(fontSize: 12.0,
                              height:1.5,),
                            textAlign: TextAlign.justify,
                          ),
                        )

                    ),


                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: GlobalColors
                            .inputBorder,
                        side: BorderSide(
                          width: 2.0,
                          color: GlobalColors.mainColor,
                        ),

                      ),


                      onPressed: () {

                        _launchURL("www.thelostfoodproject.org");
                      },
                      child:  Text(
                          'VISIT OUR WEBSITE',
                          style: TextStyle(
                            fontWeight: FontWeight
                                .bold,
                            color:GlobalColors.mainColor,
                          )),
                    ),
                    TradeMark()




                  ],
                ),
              ),

              // Widget for the Surplus Food.

              SurplusFoodView(),


              // Widget for the  Donations(money).
              AnalysisView(),

            ],
          ),
        ));
  }

}



