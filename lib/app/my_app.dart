import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/app/my_app_controller.dart';
import 'package:food_ordering_sp1/core/enums/connectivity_status.dart';
import 'package:food_ordering_sp1/core/services/connectivity_service.dart';
import 'package:food_ordering_sp1/core/services/location_service.dart';

import 'package:food_ordering_sp1/core/translation/app_translation.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/splash_screen/splash_screen_view.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.ONLINE,
        create: (context) =>
            connectivityService.connectivityStatusController.stream,
        child: GetMaterialApp(
            defaultTransition: Transition.circularReveal,
            transitionDuration: Duration(milliseconds: 12),
            title: 'Flutter Demo',
            builder: BotToastInit(),
            locale: getLocal(),
            fallbackLocale: getLocal(),
            translations: AppTranslation(), //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreenView()));
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar') {
    return Locale('ar', 'SA');
  } else if (storage.getAppLanguage() == 'tr') {
    return Locale('tr', 'TR');
  } else {
    return Locale('en', 'US');
  }
}
