import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:mailer/mailer.dart';

class StakeholderDetails extends StatelessWidget {
  var id;


  StakeholderDetails(

      { required this.stakeholderID,
        required this.role,
        required this.companyName,
        required this.email,
        required this.password,
        required this.website,
        required this.address,
        required this.city,
        required this.state,
        required this.telephone
        });

  final String? stakeholderID, role, companyName, email,password, website, address, city, state, telephone;


  void sendEmail() async {
    String username = 'alugeelinor@gmail.com';
    String password = 'changemyclothes';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name')
      ..recipients.add('alugeelinor@gmail.com')
      ..subject = 'Your Subject'
      ..text = 'Your message goes here.'
      ..html = '<h1>Your HTML message goes here</h1>';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  void _verifyAccount() async {
    FirebaseFirestore.instance
        .collection('stakeholder')
        .doc(stakeholderID)
        .update({'isVerified': true})
        .then((value) => print('User updated'))
        .catchError((error) => print('Failed to update user: $error'));
      sendEmail();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // physics: NeverScrollableScrollPhysics(),
        backgroundColor: GlobalColors.mainColor,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child:  ListView(

                children: [
                  Column(
                    children:[
                      Container(
                        height:MediaQuery.of(context).size.height,
                        width:MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child:  Positioned(
                                top:0,
                                left:0,
                                right:0,
                                child: Container(
                                    height:280.0,
                                    decoration: BoxDecoration(
                                      color: GlobalColors.mainColor,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      image: DecorationImage(
                                        scale: 3.5,
                                        image: AssetImage('assets/admin/SEF_white.png',
                                        ),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                ),
                              ),
                            ),


                        Positioned(
                          top: 20,
                          left: 20,
                          child:IconButton(
                            icon: Icon(Icons.arrow_back, color:Colors.white ,),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                            Positioned(
                              bottom:0,
                              right:0,
                              left:0,
                              top:255,
                              child: Container(
                                // height:500.0,
                                width:400,
                                decoration: BoxDecoration(
                                  color:GlobalColors.containerField,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    // bottomLeft: Radius.circular(25),
                                    // bottomRight: Radius.circular(25),
                                  ),

                                ),

                                child:SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(top:35, left:20),
                                          margin: const EdgeInsets.symmetric(horizontal:12),

                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'Verify Account',
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:FontWeight.bold,
                                                color: GlobalColors.titleHeading,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text("Company Name",
                                                style: TextStyle
                                                  (
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15,
                                                ),),
                                              Text(companyName.toString(),
                                                  style: TextStyle
                                                    (
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  )),
                                            ]
                                          )
                                        ),


                                        Container(
                                            padding: const EdgeInsets.only(top:25, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Stakeholder Role",
                                                    style: TextStyle
                                                      (
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),),
                                                  Text(role.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),
                                                ]
                                            )
                                        ),


                                        Container(
                                            padding: const EdgeInsets.only(top:25, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Email",
                                                    style: TextStyle
                                                      (
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),),
                                                  Text(email.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),
                                                ]
                                            )
                                        ),


                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Website",
                                                    style: TextStyle
                                                      (
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),),
                                                  Text(website.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),
                                                ]
                                            )
                                        ),


                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Telephone",
                                                    style: TextStyle
                                                      (
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),),
                                                  Text(telephone.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),
                                                ]
                                            )
                                        ),

                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Address",
                                                    style: TextStyle
                                                      (
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),),
                                                  Text(address.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),

                                                  Text(city.toString()+", " + state.toString(),
                                                      style: TextStyle
                                                        (
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      )),
                                                ]
                                            )
                                        ),

                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Company Name"),
                                                  Text(companyName.toString()),
                                                ]
                                            )
                                        ),

                                        Container(
                                            padding: const EdgeInsets.only(top:15, left:20),
                                            margin: const EdgeInsets.symmetric(horizontal:12),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text("Company Name"),
                                                  Text(companyName.toString()),
                                                ]
                                            )
                                        ),



                                        Container(
                                          margin: const EdgeInsets.all(0),
                                          width:300,
                                          height:40,
                                          alignment: Alignment.center,
                                          child:  Text('Forgot your password?',
                                              style:TextStyle(
                                                color: GlobalColors.titleHeading,
                                                fontWeight: FontWeight.bold,
                                              )),

                                        ),

                                        Container(
                                          padding: EdgeInsets.only(bottom:30),
                                          margin: EdgeInsets.only(bottom:30),
                                          alignment: Alignment.center,
                                            child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:[
                                                  Container(
                                                    // margin: const EdgeInsets.all(38),
                                                      width:150,
                                                      height:40,
                                                      child: ElevatedButton(
                                                        style:ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.white,
                                                          side: BorderSide(width: 1, color: GlobalColors.mainColor),

                                                        ),

                                                        onPressed: ()
                                                        {

                                                        },

                                                        child: const Text('REJECT',
                                                            style:TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.bold,
                                                            )),
                                                      )
                                                  ),

                                                  SizedBox(width:20),

                                                  Container(
                                                    // margin: const EdgeInsets.all(38),
                                                      width:150,
                                                      height:40,
                                                      child: ElevatedButton(
                                                        style:ElevatedButton.styleFrom(
                                                          primary: GlobalColors.titleHeading,

                                                        ),

                                                        onPressed: ()
                                                        {

                                                          _verifyAccount();
                                                        },

                                                        child: const Text('APPROVE',
                                                            style:TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.bold,
                                                            )),
                                                      )
                                                  ),
                                                ]
                                            ),
                                        )




                                      ],
                                    )
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),


                    ],
                  ),

                ]
            )
        )


    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       child: CustomScrollView(
    //         slivers: <Widget>[
    //           SliverAppBar(
    //             backgroundColor: GlobalColors.mainColor,
    //             expandedHeight: MediaQuery.of(context).size.height * 0.4,
    //             flexibleSpace: Container(
    //               height: MediaQuery.of(context).size.height * 0.6,
    //               // color: kPrimaryColor,
    //               child: Stack(
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: Container(
    //                       margin: const EdgeInsets.only(bottom: 62),
    //                       width: 300,
    //                       height: 250,
    //                       decoration: BoxDecoration(
    //                         color: GlobalColors.mainColor,
    //                         image: DecorationImage(
    //                           image: AssetImage("assets/admin/SEF_white.png"),
    //                         ),
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SliverList(
    //             delegate: SliverChildListDelegate([
    //
    //               Padding(
    //                 padding: const EdgeInsets.only(
    //                   top: 20,
    //                   left: 25,
    //                 ),
    //                 child: Text(
    //                   companyName.toString(),
    //                   style: const TextStyle(
    //                     fontFamily: 'Poppins',
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(
    //                   top: 8,
    //                   left: 25,
    //                 ),
    //                 child: Text(
    //                   role.toString(),
    //                   style: const TextStyle(
    //                     fontFamily: 'Poppins',
    //                     fontSize: 14,
    //                     color: Colors.grey,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ),
    //
    //               Container(
    //                 height: 28,
    //                 margin: const EdgeInsets.only(
    //                   top: 23,
    //                   bottom: 36,
    //                 ),
    //                 padding: const EdgeInsets.only(
    //                   left: 25,
    //                 ),
    //
    //               ),
    //
    //             ]),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );



    // await FlutterEmailSender.send(email);
  }
// Future  sendEmail; async(
// {dynamic email= ('milke, johannesegna1l. com')}
//
// final message = Message()
//   ..from = Address(email, "Johannes")
//     .. recipients = ('milke. johannesegma1l. com ')
//     .. subject = 'Hello Johannes'
//     ..text = 'This is a test email!";
//   )
}
