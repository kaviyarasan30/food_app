import 'package:flutter/material.dart';
import 'package:app/colors/colors.dart';
import 'package:app/utils/dimensions.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  AppTextField({
    super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.maxLines = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        maxLines: maxLines ? 3 : 1,
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
            //hinttext
            hintText: hintText,
            //prefixIcon
            prefixIcon: Icon(
              icon,
              color: AppColors.mainColor,
            ),
            //focusedBroder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            //enabledBorder
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            //border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            )),
      ),
    );
  }
}
