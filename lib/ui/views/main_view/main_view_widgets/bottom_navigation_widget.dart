import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp1/core/enums/bottom_navigation.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
  final BottomNavigationEnum bottomNavigationEnum;
  final Function(BottomNavigationEnum, int) onTap;

  BottomNavigationWidget(
      {Key? key, required this.bottomNavigationEnum, required this.onTap})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      //fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          painter: _ClipShadowPainter(
            clipper: BottomClipper(),
            shadow: Shadow(blurRadius: 12, color: AppColors.mainTextColor),
          ),
          child: ClipPath(
            clipper: BottomClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(color: AppColors.mainWhiteColor),
            ),
          ),
        ),
        Positioned(
          bottom: size.width * 0.03,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navItem(
                    imageName: 'ic_menu',
                    text: 'Menu',
                    isSelected: widget.bottomNavigationEnum ==
                        BottomNavigationEnum.MENU,
                    onTap: () {
                      widget.onTap(BottomNavigationEnum.MENU, 0);
                    },
                    size: size),
                navItem(
                    imageName: 'ic_shopping',
                    text: 'Offers',
                    isSelected: widget.bottomNavigationEnum ==
                        BottomNavigationEnum.OFFERS,
                    onTap: () {
                      widget.onTap(BottomNavigationEnum.OFFERS, 1);
                    },
                    size: size),
                SizedBox(
                  width: size.width * 0.25,
                ),
                navItem(
                    imageName: 'ic_user',
                    text: 'Profile',
                    isSelected: widget.bottomNavigationEnum ==
                        BottomNavigationEnum.PROFILE,
                    onTap: () {
                      widget.onTap(BottomNavigationEnum.PROFILE, 3);
                    },
                    size: size),
                navItem(
                    imageName: 'ic_more',
                    text: 'More',
                    isSelected: widget.bottomNavigationEnum ==
                        BottomNavigationEnum.MORE,
                    onTap: () {
                      widget.onTap(BottomNavigationEnum.MORE, 4);
                    },
                    size: size),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.13),
          child: InkWell(
            onTap: () {
              widget.onTap(BottomNavigationEnum.HOME, 2);
            },
            child: CircleAvatar(
              backgroundColor:
                  widget.bottomNavigationEnum == BottomNavigationEnum.HOME
                      ? AppColors.mainOrangeColor
                      : AppColors.mainTextColor,
              radius: size.width * 0.09,
              child: SvgPicture.asset(
                'assets/images/ic_home.svg',
                color: AppColors.mainWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem({
    required String imageName,
    required String text,
    required bool isSelected,
    required Function()? onTap,
    required Size size,
  }) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/$imageName.svg',
            color: isSelected
                ? AppColors.mainOrangeColor
                : AppColors.mainTextColor,
            width: size.width * 0.05,
          ),
          SizedBox(
            height: size.width * 0.02,
          ),
          Text(
            text,
            style: TextStyle(
                color: isSelected
                    ? AppColors.mainOrangeColor
                    : AppColors.mainTextColor,
                fontSize: size.width * 0.045),
          )
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.3381500, 0);
    path0.quadraticBezierTo(size.width * 0.3731500, size.height * 0.0069000,
        size.width * 0.3757000, size.height * 0.1236000);
    path0.quadraticBezierTo(size.width * 0.4022000, size.height * 0.5633000,
        size.width * 0.5006000, size.height * 0.5896000);
    path0.quadraticBezierTo(size.width * 0.5955500, size.height * 0.5727000,
        size.width * 0.6200000, size.height * 0.1240000);
    path0.quadraticBezierTo(size.width * 0.6204500, size.height * -0.0157000,
        size.width * 0.6646000, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.6225000, size.height * 0.6100000);
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ClipShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
