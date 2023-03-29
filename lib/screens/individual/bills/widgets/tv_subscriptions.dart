import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CablePackageDropDown extends StatefulWidget {
  const CablePackageDropDown({super.key});

  @override
  State<CablePackageDropDown> createState() => _CablePackageDropDownState();
}

class _CablePackageDropDownState extends State<CablePackageDropDown> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Package")),
      DropdownMenuItem(value: "Access", child: Text("data 1")),
      DropdownMenuItem(value: "Canada", child: Text("data 2")),
      DropdownMenuItem(value: "Brazil", child: Text("data 3")),
      DropdownMenuItem(value: "England", child: Text("data 4")),
    ];

    return menuItems;
  }

  String selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          "Select Package",
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
              value: selectedValue,
              items: dropdownItems,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
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
