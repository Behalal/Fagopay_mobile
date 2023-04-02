import 'package:auto_size_text/auto_size_text.dart';
import '../../../models/data_model.dart';
import '../../constants/colors.dart';
import '../bills/models/bill_post_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DataDropDown extends StatefulWidget {
  bool? isLoading;
  List<DropdownMenuItem<String>> dropDownItemsList;
  TextEditingController amount;
  String code;
  List<DataDetails>? dataProvided;
  BuyDataFields model;
  DataDropDown(
      {super.key,
      required this.dropDownItemsList,
      required this.amount,
      required this.code,
      required this.dataProvided,
      required this.model,
      this.isLoading});

  @override
  State<DataDropDown> createState() => _DataDropDownState();
}

class _DataDropDownState extends State<DataDropDown> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = widget.dropDownItemsList;
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
          "Select Data Bundle",
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
                  if (widget.isLoading != null) widget.isLoading = true;
                  selectedValue = newValue!;
                  if (selectedValue.isNotEmpty) {
                    widget.amount.text = widget
                        .dataProvided![int.parse(selectedValue)]
                        .variationAmount;
                    widget.model.setAmount = widget.amount.text;
                    widget.model.getVariationCode = widget
                        .dataProvided![int.parse(selectedValue)].variationCode;
                    widget.model.setName =
                        widget.dataProvided![int.parse(selectedValue)].name;
                  }
                  if (widget.isLoading != null) widget.isLoading = false;
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
