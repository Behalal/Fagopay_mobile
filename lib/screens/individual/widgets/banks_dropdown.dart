import 'package:auto_size_text/auto_size_text.dart';
import '../../constants/colors.dart';
import '../transactions/models/bank_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectBank extends StatefulWidget {
  List<DropdownMenuItem<String>> bankdropdown;
  VoidCallback onChanged;
  String selectedValue;
  SelectBank({
    super.key,
    required this.bankdropdown,
    required this.onChanged,
    required this.selectedValue,
  });

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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = widget.bankdropdown;

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.bankdropdown);
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
          height: 2.h,
        ),
        Container(
          width: 90.w,
          decoration: BoxDecoration(
              border: Border.all(color: fagoSecondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              alignment: AlignmentDirectional.centerStart,
              value: widget.selectedValue,
              items: dropdownItems,
              onChanged: ((value) {}),
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
