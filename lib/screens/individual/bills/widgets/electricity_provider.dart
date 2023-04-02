import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../models/bill_post_model.dart';

class ElectricityProvider extends StatefulWidget {
  const ElectricityProvider({super.key});

  @override
  State<ElectricityProvider> createState() => _ElectricityProviderState();
}

class _ElectricityProviderState extends State<ElectricityProvider> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Power Company")),
      DropdownMenuItem(
          value: "eko-electric",
          child: Text("Eko electricity distribution company")),
      DropdownMenuItem(
          value: "ikeja-electric",
          child: Text("Ikeja electricity distribution company")),
      DropdownMenuItem(
          value: "kano-electric",
          child: Text("Kano electricity distribution company")),
      DropdownMenuItem(
          value: "portharcourt-electric",
          child: Text("PortHacourt electricity distribution company")),
      DropdownMenuItem(
          value: "jos-electric",
          child: Text("Jos electricity distribution company")),
      DropdownMenuItem(
          value: "ibadan-electric",
          child: Text("Ibadan electricity distribution company")),
      DropdownMenuItem(
          value: "kaduna-electric",
          child: Text("Kaduna electricity distribution company")),
      DropdownMenuItem(
          value: "abuja-electric",
          child: Text("Abuja electricity distribution company")),
      DropdownMenuItem(
          value: "enugu-electric",
          child: Text("Enugu electricity distribution company")),
      DropdownMenuItem(
          value: "benin-electric",
          child: Text("Benin electricity distribution company")),
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
          "Select Power Company",
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
                  buyElectricityFields.setServiceid = selectedValue;
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
