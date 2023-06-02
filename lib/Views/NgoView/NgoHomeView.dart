import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/LoginView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/Views/AdministrationView/TradeMark.dart';
import 'package:fyp/Views/AdministrationView/NotificationAlert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fyp/Views/AdministrationView/HomeView.dart';
import 'package:fyp/Views/SponsorView/SurplusFoodView.dart';

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
            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [GlobalColors.mainColor, GlobalColors.gradientColor],
            //         begin: Alignment.bottomRight,
            //       )
            //   ),
            // ),
            elevation: 2,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {}),
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
                  Tab(icon: Icon(Icons.fastfood), text: 'Surplus'),
                  Tab(icon: Icon(Icons.monetization_on_outlined),
                      text: 'Donation')
                ]
            ),
          ),


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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationAlert(),

                  Container(
                    padding:EdgeInsets.all(10),
                    height:100,
                    width:  MediaQuery.of(context).size.width,
                    color:GlobalColors.mainColor.withOpacity(0.3),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('SDN HOTEL & BAKERY', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                        SizedBox(height:15),
                        Text('RM300', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                      ],
                    ),
                  ),


                  SizedBox(height: 10),
                  Padding(padding: EdgeInsets.all(10),
                      child: Container(
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:[
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
                                                  NgoHomeView()),);
                                      },
                                      child:  Text(
                                          'DONATE NOW',
                                          style: TextStyle(
                                            fontWeight: FontWeight
                                                .bold,
                                            color:GlobalColors.titleHeading,
                                          )),
                                    )

                                ),


                                Text('History'),

                                Card(
                                  child: DataTable(
                                    columns: [
                                      DataColumn(label: Text('Amount')),
                                      DataColumn(label: Text('Date')),
                                      DataColumn(label: Text('Status')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('John')),
                                        DataCell(Text('25')),
                                        DataCell(Icon(Icons.approval)),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Jane')),
                                        DataCell(Text('30')),
                                        DataCell(Text('Female')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Bob')),
                                        DataCell(Text('40')),
                                        DataCell(Text('Male')),
                                      ]),
                                    ],
                                  ),
                                )

                              ]
                          )

                      )
                  ),

                ],
              ),
            ],
          ),
        ));
  }

}



