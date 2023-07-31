import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';


class CheckoutView extends StatefulWidget {
  CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cartService.clearCart();
        Get.off(MainView());
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Text(
              'Sub Total: ${cartService.subTotal.value}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            Text(
              'Tax: ${cartService.tax.value}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            Text(
              'Delivery: ${cartService.deliverFees.value}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            Text(
              'Total: ${cartService.total.value}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            CustomButton(
              text: 'Couninue shopping',
              onPressed: () {
                cartService.clearCart();
                Get.off(MainView());
                // Navigator.pop(context);
              },
            )
          ],
        ),
      )),
    );
  }
}
