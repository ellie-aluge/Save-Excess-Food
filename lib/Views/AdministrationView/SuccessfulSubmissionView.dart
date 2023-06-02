import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/AdministratorHomeView.dart';
class SuccessfulSubmissionView extends StatelessWidget {
  const SuccessfulSubmissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body:Container(

            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            child:Column(
                children:[

                  Container(
                    width: 250,
                    height: 250,
                    child: Image(
                      image: AssetImage('assets/admin/success.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // SizedBox(height:5),
                  Text('Success',
                      style:TextStyle(
                          color:Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),

                  SizedBox(height:30),

                  Text('Thank you for your submission. The item has been added successfully',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                          color:Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),

                  SizedBox(height:30),
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

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdministratorHomeView()),);
                    },
                    child:  Text(
                        'OKAY',
                        style: TextStyle(
                          fontWeight: FontWeight
                              .bold,
                          color:GlobalColors.mainColor,
                        )),
                  ),
                ]
            )

        )
    );
  }
}
