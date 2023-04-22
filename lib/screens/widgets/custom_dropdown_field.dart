import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;
  final String? hint, value;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.hint,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
                color: linearGradient1, width: 1.0, style: BorderStyle.solid)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: textBoxBorderColor,
                width: 1.0,
                style: BorderStyle.solid)),
        hintText: hint ?? "Select option",
        hintStyle: const TextStyle(
          fontFamily: "Work Sans",
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: signInPlaceholder,
        ),
      ),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
