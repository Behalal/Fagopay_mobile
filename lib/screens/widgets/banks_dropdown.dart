// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class SelectBank extends StatefulWidget {
  final List<DropdownMenuItem<String>> bankdropdown;
  final Function(String?)? onChanged;
  final String selectedValue;

  const SelectBank({
    Key? key,
    required this.bankdropdown,
    this.onChanged,
    required this.selectedValue,
  }) : super(key: key);

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  late List<dynamic> allBanks;
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          "Select Bank",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Container(
          width: 90.w,
          decoration: BoxDecoration(
              border: Border.all(color: textBoxBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w,),
            child: DropdownButtonFormField(
              isExpanded: true, icon: const Icon(Icons.keyboard_arrow_down_outlined, color: stepsColor,),
              alignment: AlignmentDirectional.centerStart,
              value: widget.selectedValue,
              items: widget.bankdropdown,
              onChanged: widget.onChanged,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Work Sans",
                  color: signInPlaceholder),
            ),
          ),
        ),
      ],
    );
  }
}
