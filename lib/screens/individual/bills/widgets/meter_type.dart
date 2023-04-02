import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import '../models/bill_post_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MeterType extends StatefulWidget {
  const MeterType({super.key});

  @override
  State<MeterType> createState() => _MeterTypeState();
}

class _MeterTypeState extends State<MeterType> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select meter type")),
      DropdownMenuItem(value: "prepaid", child: Text("Prepaid")),
      DropdownMenuItem(value: "postpaid", child: Text("Postpaid")),
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
          "Select Meter Type",
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
                  buyElectricityFields.getVariationCode = selectedValue;
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
