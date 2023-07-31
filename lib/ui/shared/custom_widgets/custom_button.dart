import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp1/ui/shared/colors.dart';
import 'package:food_ordering_sp1/ui/shared/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      this.backgroundColor,
      required this.text,
      this.textColor,
      this.borderColor,
      this.imageName})
      : super(key: key);

  final Function? onPressed;
  final Color? backgroundColor;
  final String text;
  final String? imageName;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageName != null) ...[
              SvgPicture.asset('assets/images/$imageName.svg'),
              SizedBox(
                width: size.width * 0.05,
              ),
            ],
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: screenWidth(20)),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth(12), size.width * 0.13),
          shape: StadiumBorder(),
          backgroundColor: backgroundColor ?? AppColors.mainOrangeColor,
          side: borderColor != null
              ? BorderSide(
                  width: 1.0,
                  color: borderColor!,
                )
              : null,
        ),
      ),
    );
  }
}
