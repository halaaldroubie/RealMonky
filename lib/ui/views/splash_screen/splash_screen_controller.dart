import 'package:food_ordering_sp1/core/data/repositories/shared_prefrence_repository.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/intro_view/intro_view.dart';
import 'package:food_ordering_sp1/ui/views/landing_view/landing_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (storage.getFirstLunch())
        Get.off(IntroView());
      else
        Get.off(
          storage.isLoggedIn ? LandingView() : LandingView(),
        );

      storage.setFirstLunch(false);
    });
    super.onInit();
  }
}
