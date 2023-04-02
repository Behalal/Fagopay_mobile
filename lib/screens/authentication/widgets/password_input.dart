import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final Widget? icon, prefixIcon, suffixIcon;
  final bool? obscure;
  const PasswordInput({
    super.key,
    required this.controller,
    this.icon,
    this.prefixIcon,
    this.suffixIcon, this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 341,
      child: TextFormField(
        controller: controller,
       obscureText: obscure ?? false,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: signInPlaceholder),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: textBoxBorderColor,
              width: 1.0,
            ),
          ),
          focusColor: linearGradient1,
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
          hintText: "Password",
          hintStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: signInPlaceholder,
          ),
          prefixIcon:
              const Image(image: AssetImage("assets/images/password_icon.png")),
               suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
