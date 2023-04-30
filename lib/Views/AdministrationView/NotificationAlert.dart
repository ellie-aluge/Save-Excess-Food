import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:marquee/marquee.dart';
class NotificationAlert extends StatelessWidget {
  const NotificationAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        // margin:  EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: GlobalColors.greyColor,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 25,),
            Icon(Icons.notifications_active,
              color: GlobalColors.mainColor,),
            // SizedBox(width: 5,),
            Expanded(child: Marquee(
              text: "Feed the hungry, not the land fill",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: GlobalColors.titleHeading,
              ),
              blankSpace: 300,
              // pauseAfterRound: Duration(seconds: 1),
            ),
            )
          ],
        )
    );
  }
}
