import 'package:flutter/material.dart';
import 'package:food_ordering_sp1/core/enums/bottom_navigation.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp1/ui/views/main_view/home_view/home_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/main_view_widgets/bottom_navigation_widget.dart';
import 'package:food_ordering_sp1/ui/views/main_view/menu_view/menu_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/more_view/more_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/offers_view/offers_view.dart';
import 'package:food_ordering_sp1/ui/views/main_view/profile_view/profile_view.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  BottomNavigationEnum selected = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      key: scafoldKey,
      endDrawer: Container(
        width: size.width * 0.5,
        color: AppColors.mainWhiteColor,
        child: Column(children: [
          Text('Option 1'),
          Text('Option 2'),
        ]),
      ),
      // backgroundColor: AppColors.mainBlackColor,
      bottomNavigationBar: BottomNavigationWidget(
        bottomNavigationEnum: selected,
        onTap: (selectedEnum, pageNumber) {
          //scafoldKey.currentState!.openEndDrawer();
          controller.animateToPage(pageNumber,
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeInCirc);
          setState(() {
            selected = selectedEnum;
          });
        },
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (pageNumer) {},
        children: [
          MenuView(),
          OffersView(),
          HomeView(onMenuTap: () {
            scafoldKey.currentState!.openDrawer();
          }),
          ProfileView(),
          MoreView()
        ],
      ),
    ));
  }
}
