import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp1/core/enums/data_type.dart';
import 'package:food_ordering_sp1/core/data/repositories/shared_prefrence_repository.dart';
import 'package:food_ordering_sp1/main.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/intro_view/intro_view.dart';
import 'package:food_ordering_sp1/ui/views/landing_view/landing_view.dart';
import 'package:food_ordering_sp1/ui/views/login_view/login_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/main_view.dart';
import 'package:food_ordering_sp1/ui/views/splash_screen/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenController controller = Get.put(SplashScreenController());
  //SplashScreenController controller = Get.putAsync(SplashScreenController());
  // SplashScreenController controller =
  //     Get.lazyPut(() => SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          'assets/images/bg_background.svg',
          width: screenWidth(1),
          height: screenHeight(1),
          fit: BoxFit.fill,
        ),
        Center(
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            width: screenWidth(5),
            height: screenHeight(5),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight(2)),
          height: screenWidth(10),
          child: SpinKitThreeBounce(color: AppColors.mainOrangeColor),
        )
      ],
    )));
  }
}
