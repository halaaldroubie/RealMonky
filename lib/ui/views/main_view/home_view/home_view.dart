import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ordering_sp1/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp1/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp1/core/data/repositories/category_repository.dart';
import 'package:food_ordering_sp1/core/data/repositories/meal_repository%20.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/core/enums/opertion_type.dart';
import 'package:food_ordering_sp1/core/enums/request_status.dart';
import 'package:food_ordering_sp1/core/utils/network_util.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';
import 'package:food_ordering_sp1/ui/views/main_view/home_view/home_view_controller.dart';
import 'package:food_ordering_sp1/ui/views/meal_details/meal_details_view.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  final Function() onMenuTap;
  HomeView({Key? key, required this.onMenuTap}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Icon(
          Icons.wifi,
          color: Colors.green,
          size: screenWidth(10),
        ),
        // Obx(() {
        //   return controller.isCategoryLoading
        //       ? SpinKitCircle(
        //           color: AppColors.mainOrangeColor,
        //         )
        //       : controller.categoryList.isEmpty
        //           ? Text('No Category')
        //           : ListView.separated(
        //               physics: BouncingScrollPhysics(),
        //               shrinkWrap: true,
        //               itemCount: controller.categoryList.length,
        //               addAutomaticKeepAlives: true,
        //               itemBuilder: (BuildContext context, int index) {
        //                 return SizedBox(
        //                   height: 200,
        //                   child: Text(
        //                     controller.categoryList[index].name ?? '',
        //                     style: TextStyle(fontSize: 60),
        //                   ),
        //                 );
        //               },
        //               separatorBuilder: (BuildContext context, int index) {
        //                 return Container(
        //                   width: 100,
        //                   height: 5,
        //                   color: AppColors.mainOrangeColor,
        //                 );
        //               },
        //             );
        // }),
        Obx(() {
          return Icon(
            controller.isOnlne.value ? Icons.wifi : Icons.wifi_off,
            color: controller.isOnlne.value ? Colors.green : Colors.red,
            size: screenWidth(10),
          );
        }),
        Obx(
          () {
            return controller.isMealLoading
                ? SpinKitCircle(
                    color: AppColors.mainOrangeColor,
                  )
                : controller.mealList.isEmpty
                    ? Text('No Meals')
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.mealList.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      await Get.to(MealDetailsView(
                                          model: controller.mealList[index]));
                                    },
                                    child: CachedNetworkImage(
                                      height: 100,
                                      imageUrl: controller.mealList[index]
                                                  .images!.length >
                                              0
                                          ? controller
                                              .mealList[index].images![0]
                                          : '',
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                Row(
                                  children: [
                                    Obx(() {
                                      return CustomButton(
                                        text: "${cartService.cartCount}",
                                        onPressed: () {
                                          controller.addToCart(
                                              controller.mealList[index]);
                                        },
                                      );
                                    }),
                                    InkWell(
                                      onTap: () {
                                        controller.addToCart(
                                            controller.mealList[index]);
                                      },
                                      child: Text(
                                        controller.mealList[index].name ?? '',
                                        style: TextStyle(fontSize: 60),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 100,
                            height: 5,
                            color: AppColors.mainOrangeColor,
                          );
                        },
                      );
          },
        )

        // FutureBuilder(
        //   future: MealRepository().getAll(),
        //   builder: (context, snapshot) {
        //     if (snapshot.data != null) {
        //       snapshot.data!.fold((l) {
        //         CustomToast.showMessage(
        //             message: l, messageType: MessageType.REJECTED);
        //       }, (r) {
        //         mealList.clear();
        //         mealList.addAll(r);
        //       });
        //     }
        //     return snapshot.data == null
        //         ? SpinKitCircle(
        //             color: AppColors.mainOrangeColor,
        //           )
        //         : ListView.separated(
        //             physics: BouncingScrollPhysics(),
        //             shrinkWrap: true,
        //             itemCount: mealList.length,
        //             addAutomaticKeepAlives: true,
        //             itemBuilder: (BuildContext context, int index) {
        //               return SizedBox(
        //                 height: 200,
        //                 child: Column(
        //                   children: [
        //                     CachedNetworkImage(
        //                       imageUrl: mealList[index].images!.length > 0
        //                           ? getFullImageUrl(mealList[index].images![0])
        //                           : '',
        //                       placeholder: (context, url) =>
        //                           CircularProgressIndicator(),
        //                       errorWidget: (context, url, error) =>
        //                           Icon(Icons.error),
        //                     ),
        //                     Text(
        //                       mealList[index].name ?? '',
        //                       style: TextStyle(fontSize: 60),
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             },
        //             separatorBuilder: (BuildContext context, int index) {
        //               return Container(
        //                 width: 100,
        //                 height: 5,
        //                 color: AppColors.mainOrangeColor,
        //               );
        //             },
        //           );
        //   },
        // ),
      ],
    );
  }

  String getFullImageUrl(String url) {
    var splitedString = url.split('assets/images/');
    return '';
  }
}
