import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';

class CustomToast {
  static showMessage(
      {required String message, MessageType? messageType = MessageType.INFO}) {
    String imageName = 'info';
    Color shadowColor = AppColors.mainBlueColor;

    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCESS:
        // TODO: Handle this case.
        break;
      case MessageType.WARNING:
        // TODO: Handle this case.
        break;
      case MessageType.INFO:
        // TODO: Handle this case.
        break;
      default:
        break;
    }

    BotToast.showCustomText(
        duration: Duration(seconds: 2),
        toastBuilder: (value) {
          return Container(
            width: screenWidth(1.2),
            //  height: size.width * 0.35,
            decoration: BoxDecoration(
                color: AppColors.mainWhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenWidth(10),
                ),
                SvgPicture.asset(
                  'assets/images/$imageName.svg',
                  width: screenWidth(10),
                  height: screenWidth(10),
                ),
                SizedBox(
                  height: screenWidth(6),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth(18)),
                ),
                SizedBox(
                  height: screenWidth(6),
                ),
              ],
            ),
          );
        });
  }
}
