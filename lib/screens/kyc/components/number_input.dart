import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboadType;
  final String? errorText;
  final String? title;
  final Color? boarderColor;
  final String? validatorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  const NumberInput({
    super.key,
    this.errorText,
    this.onChanged,
    this.controller,
    this.title,
    this.validate,
    this.validatorText,
    this.keyboadType,
    this.boarderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 55,
      width: Get.width,
      child: TextFormField(
        validator: validate ??
            (value) {
              if (value == null || value.isEmpty) {
                return validatorText;
              } else {
                return null;
              }
            },
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboadType,
        style: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: stepsColor),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: stepsColor.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                  style: BorderStyle.solid)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: linearGradient1,
                  width: 1.0,
                  style: BorderStyle.solid)),
          hintText: title,
          hintStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: stepsColor,
          ),
          //prefixIcon: const Image(image: AssetImage("assets/images/phone.png")),
        ),
      ),
    );
  }
}