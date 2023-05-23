import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InvoiceField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FontWeight textWeight;
  final bool hintcolor;
  final bool bgColor;
  final bool txtColor;

  const InvoiceField({
    super.key,
    required this.hintText,
    required this.controller,
    this.textWeight = FontWeight.w600,
    this.hintcolor = false,
    this.bgColor = false,
    this.txtColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontFamily: "Work Sans",
        fontWeight: textWeight,
        fontSize: 14,
        color: (txtColor) ? fagoSearchColor : inactiveTab,
      ),
      decoration: InputDecoration(
        filled: bgColor,
        fillColor: (bgColor) ? white : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 1.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: textBoxBorderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: linearGradient1,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: textBoxBorderColor,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "Work Sans",
          fontWeight: textWeight,
          fontSize: 14,
          color: (txtColor)
              ? fagoSearchColor
              : (hintcolor)
                  ? signInPlaceholder
                  : inactiveTab,
        ),
      ),
    );
  }
}
