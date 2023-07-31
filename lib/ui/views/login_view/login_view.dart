import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ordering_sp1/app/my_app.dart';
import 'package:food_ordering_sp1/core/translation/app_translation.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/login_view/login_controller.dart';
import 'package:get/get.dart';


class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.width / 10,
                ),
                InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Choose Language",
                          content: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    storage.setAppLanguage('en');
                                    Get.updateLocale(getLocal());
                                    Get.back();
                                  },
                                  child: Text('English')),
                              InkWell(
                                  onTap: () {
                                    storage.setAppLanguage('ar');
                                    Get.updateLocale(getLocal());
                                    Get.back();
                                  },
                                  child: Text('العربية')),
                              InkWell(
                                  onTap: () {
                                    storage.setAppLanguage('tr');
                                    Get.updateLocale(getLocal());
                                    Get.back();
                                  },
                                  child: Text('Turcis')),
                            ],
                          ));
                    },
                    child: Icon(Icons.language)),
                SizedBox(
                  height: size.width / 10,
                ),
                Text(
                  tr("key_login"),
                  style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlackColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.01, bottom: size.width * 0.1),
                  child: Text(
                    'Add your details to login',
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainTextColor),
                  ),
                ),
                CustomTextField(
                  hitText: 'Your Email',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty || !isEmail(value)) {
                      return 'please check your email';
                    }
                  },
                ),
                CustomTextField(
                  suffexIcon: Icons.abc_outlined,
                  hitText: 'password',
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                  },
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? SpinKitThreeBounce(
                          color: AppColors.mainOrangeColor,
                        )
                      : CustomButton(
                          text: tr("key_login"),
                          backgroundColor: AppColors.mainOrangeColor,
                          onPressed: () {
                            controller.login();
                            //customLoader();
                          },
                        );
                }),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.1),
                  child: Text(
                    'Forget password',
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainTextColor),
                  ),
                ),
                Text(
                  'or Login With',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainTextColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.06),
                  child: CustomButton(
                    text: 'Login with Facebook',
                    backgroundColor: AppColors.mainBlueColor,
                    imageName: 'Facebook',
                  ),
                ),
                CustomButton(
                  text: 'Login with Google',
                  backgroundColor: AppColors.mainRedColor,
                  imageName: 'google-plus-logo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
