import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/LoginView.dart';
class SuccessfulFormView extends StatelessWidget {
  const SuccessfulFormView({Key? key}) : super(key: key);

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
                width: 250, // Adjust this to the width of your container
                height: 250, // Adjust this to the height of your container
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

              Text('Thank you for your submission. Your account will be verified by our admin as soon as possible. ',
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
                    MaterialPageRoute(builder: (context) => LoginView()),);
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
