import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/meal_details/meal_details_controller.dart';
import 'package:get/get.dart';

class MealDetailsView extends StatefulWidget {
  final MealModel model;
  MealDetailsView({Key? key, required this.model}) : super(key: key);

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  late MealDetailsController controller;

  @override
  void initState() {
    controller = Get.put(MealDetailsController(widget.model));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Price: ${widget.model.price ?? '1000'}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            Obx(() {
              return Row(
                children: [
                  CustomButton(
                    text: '-',
                    backgroundColor: controller.count == 1
                        ? AppColors.mainGreyColor
                        : AppColors.mainOrangeColor,
                    onPressed: () {
                      controller.changeCount(false);
                    },
                  ),
                  CustomButton(text: controller.count.value.toString()),
                  CustomButton(
                    text: '+',
                    onPressed: () {
                      controller.changeCount(true);
                    },
                  ),
                ],
              );
            }),
            Obx(() {
              return Text(
                '${controller.calcTotal()}',
                style: TextStyle(fontSize: screenWidth(10)),
              );
            }),
            CustomButton(
              text: 'add',
              onPressed: () {
                controller.addToCart();
              },
            )
          ],
        ),
      ),
    );
  }
}
