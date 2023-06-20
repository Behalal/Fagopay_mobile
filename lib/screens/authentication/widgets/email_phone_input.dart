import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class EmailPhone extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  const EmailPhone({
    super.key,
    this.errorText,
    this.onChanged,
    this.hintText,
    required this.controller, this.prefixIcon, this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 341,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        style: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: signInPlaceholder),
        decoration: InputDecoration(
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: signInText,
              width: 1.0,
            ),
          ),

          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: signInText,
                  width: 1.0,
                  style: BorderStyle.solid)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: signInText,
                  width: 1.0,
                  style: BorderStyle.solid)),
          hintText: hintText ?? "Phone number or Email",
          hintStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: signInPlaceholder,
          ),
          prefixIcon: prefixIcon ?? const Image(image: AssetImage("assets/images/phone.png")),
        ),
      ),
    );
  }
}
