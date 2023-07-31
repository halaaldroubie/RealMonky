import 'package:flutter/animation.dart';
import 'package:food_ordering_sp1/core/services/base_controller.dart';
import 'package:food_ordering_sp1/core/services/notification_service.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:get/get.dart';

import '../../../core/enums/notification_type.dart';

class LandingViewController extends BaseController {
  Rx<Color> buttonColor = AppColors.mainOrangeColor.obs;
  @override
  void onInit() {
    notificationService.notifcationStream.stream.listen((event) {
      if (event.notifctionType == NotificationType.CHANGECOLOR.name) {
        buttonColor.value = AppColors.mainBlueColor;
      }
    });
    super.onInit();
  }
}
