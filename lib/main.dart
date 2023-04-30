import 'package:flutter/material.dart';
import 'package:fyp/Views/AdministrationView/LandingPage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fyp/utils/global.colors.dart';
Future main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
       theme:  ThemeData(

        inputDecorationTheme:  InputDecorationTheme(
            hintStyle: TextStyle(
                color:GlobalColors.formLabel,
                fontWeight: FontWeight.w500,
                fontSize: 13
            ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: GlobalColors.inputBorder),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: GlobalColors.mainColor),
          ),

          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1.5, color: Colors.red),
          ),

          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1.5, color: Colors.red),
          ),

          errorStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, ),
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

