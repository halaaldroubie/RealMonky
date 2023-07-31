import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeView extends StatefulWidget {
  VerificationCodeView({Key? key}) : super(key: key);

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        PinCodeTextField(
          controller: controller,
          length: 4,
          obscureText: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          onCompleted: (v) {
            print("Completed");
          },
          onChanged: (value) {
            print(value);
          },
          appContext: context,
        ),
        CustomButton(
          text: 'Next',
          onPressed: () {
            CustomToast.showMessage(message: controller.text);
          },
        )
      ],
    );
  }
}
