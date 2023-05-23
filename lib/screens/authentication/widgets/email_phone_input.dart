import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class EmailPhone extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  const EmailPhone({
    super.key,
    this.errorText,
    this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 341,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
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
              color: textBoxBorderColor,
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
          hintText: "Phone number or Email",
          hintStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: signInPlaceholder,
          ),
          prefixIcon: const Image(image: AssetImage("assets/images/phone.png")),
        ),
      ),
    );
  }
}
