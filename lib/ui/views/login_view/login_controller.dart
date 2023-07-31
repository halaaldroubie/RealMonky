import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/core/data/repositories/shared_prefrence_repository.dart';
import 'package:food_ordering_sp1/core/data/repositories/user_repository.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/core/services/base_controller.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  TextEditingController emailController =
      TextEditingController(text: 'Test@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Test@1234');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  void login() {
    if (formKey.currentState!.validate()) {
      runFullLoadingFutuerFunction(
          function: UserRepository()
              .login(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
        value.fold((l) {
          isLoading.value = false;

          CustomToast.showMessage(
              messageType: MessageType.REJECTED, message: l);
        }, (r) {
          storage.setTokenIno(r);

          Get.off(MainView());
        });
      }));
    }
  }
}
