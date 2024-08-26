import 'package:app/colors/colors.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 10,
              color: AppColors.mainBlackColor.withOpacity(0.3))
        ],
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.mainColor,
      ),
      child: Center(child: BigText(text: text, color: Colors.white)),
    );
  }
}
