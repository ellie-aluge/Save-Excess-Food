import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
class RoleView extends StatefulWidget {
  const RoleView({Key? key}) : super(key: key);

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.mainColor,
        body: ListView(
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
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),

            ]
        )

    );

  }
}
