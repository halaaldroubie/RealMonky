import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/cart_view/cart_controller.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: controller.cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.cartList[index].meal!.name ?? '',
                          style: TextStyle(fontSize: screenWidth(10)),
                        ),
                        IconButton(
                            onPressed: () {
                              controller
                                  .removeFromCart(controller.cartList[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                    Row(
                      children: [
                        CustomButton(
                          text: '+',
                          onPressed: () {
                            controller.changeCount(
                                incress: true,
                                model: controller.cartList[index]);
                          },
                        ),
                        Text(controller.cartList[index].count.toString(),
                            style: TextStyle(fontSize: screenWidth(10))),
                        CustomButton(
                          text: '-',
                          onPressed: () {
                            controller.changeCount(
                                incress: false,
                                model: controller.cartList[index]);
                          },
                        ),
                      ],
                    ),
                    Text(controller.cartList[index].total.toString(),
                        style: TextStyle(fontSize: screenWidth(10))),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  color: AppColors.mainOrangeColor,
                  width: screenWidth(1),
                  height: 2,
                );
              },
            );
          }),
          Obx(() {
            return Column(
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
              ],
            );
          }),
          CustomButton(
            text: 'Checkout',
            onPressed: () {
              controller.checkout();
            },
          )
        ],
      )),
    );
  }
}
