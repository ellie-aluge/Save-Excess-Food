import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/LoginView.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:fyp/Views/AdministrationView/SignUpView.dart';
import 'package:fyp/Views/DonationView/DonateFoodView.dart';
import 'package:fyp/Views/AdministrationView/RoleView.dart';
import 'package:fyp/Views/NgoView/ViewRider.dart';
import 'package:fyp/Views/DeliveryView/ManageDelivery.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2),() {Get.to(() => LoginView());
    });
    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.mainColor,
      borderRadius: BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
            scale: 0.5,
            image: AssetImage('assets/admin/SEF_white.png',
        ),


        ) ,
      ),
    );

  }
}
