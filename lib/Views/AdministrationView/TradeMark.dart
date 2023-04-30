import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
class TradeMark extends StatelessWidget {
  const TradeMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: GlobalColors.mainColor,
        child: (Text(
          '@Save Excess Foods 2023', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,),
          textAlign: TextAlign.center,)
        )
    );
  }
}
