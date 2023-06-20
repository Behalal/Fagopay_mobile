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
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: stepsColor),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          errorText: errorText,
          isDense: true,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color:fagoSecondaryColor, width: 0.7)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
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