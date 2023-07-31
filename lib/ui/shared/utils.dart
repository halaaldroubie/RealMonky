import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ordering_sp1/app/my_app_controller.dart';
import 'package:food_ordering_sp1/core/data/repositories/shared_prefrence_repository.dart';
import 'package:food_ordering_sp1/core/enums/connectivity_status.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/core/services/cart_service.dart';
import 'package:food_ordering_sp1/core/services/connectivity_service.dart';
import 'package:food_ordering_sp1/core/services/location_service.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/services/notification_service.dart';

bool isEmail(String value) {
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool isValidNumber(String value) {
  RegExp regExp =
      RegExp(r'^(?:\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\d{7}$');
  return regExp.hasMatch(value);
}

double screenWidth(double percent) {
  return Get.size.width / percent;
}

double screenHeight(double percent) {
  return Get.size.height / percent;
}

SharedPrefrenceRepository get storage => Get.find<SharedPrefrenceRepository>();
NotificationService get notificationService => Get.find<NotificationService>();

CartService get cartService => Get.find<CartService>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();

LocationService get locationService => Get.find<LocationService>();
Future cLaunchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    CustomToast.showMessage(
        message: 'Cant lunch url', messageType: MessageType.REJECTED);
  }
}

void customLoader() => BotToast.showCustomLoading(toastBuilder: (context) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.mainBlackColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: screenWidth(4),
        height: screenWidth(4),
        child: SpinKitCircle(
          color: AppColors.mainOrangeColor,
          size: screenWidth(8),
        ),
      );
    });

double get taxAmount => 0.18;

double get deliverAmount => 0.1;

bool get isOnline =>
    Get.find<MyAppController>().connectivityStatus == ConnectivityStatus.ONLINE;

bool get isOffline =>
    Get.find<MyAppController>().connectivityStatus ==
    ConnectivityStatus.OFFLINE;

void checkConnection(Function function) {
  if (isOnline)
    function();
  else
    showNoConnectionMessage();
}

void showNoConnectionMessage() {
  CustomToast.showMessage(
      message: 'Please check internet connection',
      messageType: MessageType.WARNING);
}
