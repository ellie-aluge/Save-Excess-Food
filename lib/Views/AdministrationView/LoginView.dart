import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/SignUpView.dart';
import 'package:fyp/Views/SponsorView/SponsorHomeView.dart';
final _formKey = GlobalKey<FormState>();
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                       Positioned(
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

                       Positioned(
                         bottom:0,
                         right:0,
                         left:0,
                         top:255,
                         child: Container(
                           height:500.0,
                           width:400,
                           decoration: BoxDecoration(
                             color:GlobalColors.containerField,
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(25),
                               topRight: Radius.circular(25),
                               bottomLeft: Radius.circular(25),
                               bottomRight: Radius.circular(25),
                             ),

                           ),

                           child:SingleChildScrollView(
                               child: Column(
                                 children: [
                                   Container(
                                     padding: const EdgeInsets.only(top:35, left:20),
                                     margin: const EdgeInsets.symmetric(horizontal:12),
                                     alignment: Alignment.center,
                                     child: Align(
                                       alignment: Alignment.bottomLeft,
                                       child: Text(
                                         'LOGIN',
                                         maxLines: 3,
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                           fontSize: 25,
                                           fontWeight:FontWeight.bold,
                                           color: GlobalColors.titleHeading,
                                         ),
                                       ),
                                     ),
                                   ),
                                   Container(
                                       padding: const EdgeInsets.all(18),
                                       margin: const EdgeInsets.symmetric(horizontal:12),
                                       alignment: Alignment.center,
                                       child: Form(
                                           key: _formKey,
                                           child:Column(
                                               children:[
                                                 TextFormField(
                                                     maxLength:25,
                                                     validator: (value) {
                                                       if (value == null || value.isEmpty) {
                                                         return 'Please enter your cooperate email';
                                                       }
                                                     },
                                                     decoration:  InputDecoration(
                                                       prefixIcon: Icon(Icons.email_outlined,
                                                           size:18),
                                                       counterText: "",
                                                       hintText: 'Email',
                                                       hintStyle: TextStyle(
                                                           color:GlobalColors.formLabel,
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 13
                                                       ),

                                                       enabledBorder: OutlineInputBorder(
                                                         borderSide: BorderSide(
                                                             width: 1.5, color: GlobalColors.inputBorder), //<-- SEE HERE
                                                       ),

                                                     )
                                                 ),
                                                 SizedBox(height: 11),
                                                 TextFormField(
                                                     maxLength:25,
                                                     validator: (value) {
                                                       if (value == null || value.isEmpty) {
                                                         return 'Please enter your password';
                                                       }
                                                     },
                                                     decoration:  InputDecoration(
                                                         prefixIcon: Icon(
                                                             Icons.lock_open_outlined,
                                                             size:17),
                                                         counterText: "",
                                                         enabledBorder: OutlineInputBorder(
                                                           borderSide: BorderSide(
                                                               width: 1.5, color: GlobalColors.inputBorder), //<-- SEE HERE
                                                         ),
                                                         hintText: 'Password',
                                                         hintStyle: TextStyle(
                                                             color:GlobalColors.formLabel,
                                                             fontWeight: FontWeight.w500,
                                                             fontSize: 13
                                                         )
                                                     )
                                                 ),
                                                 SizedBox(height: 15),
                                                 Container(
                                                   // margin: const EdgeInsets.all(38),
                                                     width:300,
                                                     height:40,
                                                     child: ElevatedButton(
                                                       style:ElevatedButton.styleFrom(
                                                         primary: GlobalColors.titleHeading,

                                                       ),

                                                       onPressed: ()
                                                       {
                                                         if (_formKey.currentState!.validate()) {
                                                           Navigator.push(
                                                             context,
                                                             MaterialPageRoute(builder: (context) => SponsorHomeView()),);

                                                         }

                                                       },


                                                       child: const Text('LOGIN',
                                                           style:TextStyle(
                                                             fontWeight: FontWeight.bold,
                                                           )),
                                                     )
                                                 ),
                                               ]
                                           )

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
  }
}
