// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fyp/utils/global.colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:fyp/Views/Map/MapView.dart';
// import 'package:fyp/Views/SponsorView/SurplusFoodSlider.dart';
// import 'package:fyp/Views/NgoView/RequestFoodView.dart';
//
// class DeliveryDetailsView extends StatelessWidget {
//   final String? id, date, location, imageUrl, title, description;
//   final List<dynamic> foodList;
//   int? quantity;
//
//   DeliveryDetailsView({
//     required this.id,
//     required this.date,
//     required this.location,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.quantity,
//     required this.foodList,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, child:  Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(250), // Set the desired height here
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(imageUrl ?? ''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//
//           title: Text(
//             title.toString(),
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         child: Container(
//           margin: EdgeInsets.only(
//             // top: MediaQuery.of(context).padding.top + -10,
//             left: 10,
//             right: 0,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.8),
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(left:20, top:10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title.toString(),
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color:GlobalColors.titleHeading,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       location.toString(),
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       date.toString(),
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//               TabBar(
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: GlobalColors.titleHeading,
//                 tabs: [
//                   Tab(text: 'Description'),
//                   Tab(text: 'Map'),
//                   Tab(text: 'Items'),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     SingleChildScrollView(
//                       child: Container(
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               description.toString(),
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               quantity.toString(),
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     MapView(location:location),
//                     // Container(
//                     //   padding: const EdgeInsets.all(20),
//                     //   child: Text('Map Content'),
//                     // ),
//                     SurplusFoodSlider(foodList: foodList),
//
//                   ],
//                 ),
//
//               ),
//
//               userRole != null && userRole!.toLowerCase() == "ngo"
//                   ? Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: GlobalColors.inputBorder,
//                       side: BorderSide(
//                         width: 2.0,
//                         color: GlobalColors.mainColor,
//                       ),
//                     ),
//                     onPressed: () {
//                       // Handle button press
//                     },
//                     child: Text(
//                       'EDIT ITEM',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: GlobalColors.titleHeading,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//                   : Center(
//                   child:Padding(
//                       padding: EdgeInsets.only(bottom:20),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: GlobalColors
//                               .inputBorder,
//                           side: BorderSide(
//                             width: 2.0,
//                             color: GlobalColors.mainColor,
//                           ),
//
//                         ),
//
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => RequestFoodView(),
//                             ),
//                           );
//                         },
//                         child:  Text(
//                             'MAKE REQUEST',
//                             style: TextStyle(
//                               fontWeight: FontWeight
//                                   .bold,
//                               color:GlobalColors.titleHeading,
//                             )),
//                       )
//                   )
//
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     ),
//     );
//   }
// }