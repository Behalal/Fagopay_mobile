import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/bill_controller.dart';
import '../../../../models/data_model.dart';
import '../../../constants/colors.dart';
import '../../../widgets/data_dropdown.dart';
import '../models/bill_post_model.dart';

class InternetDropDown extends StatefulWidget {
  // bool isLoading;
  List<DataDetails>? allBanks;
  List<DropdownMenuItem<String>> dataDropdown;
  TextEditingController amountController;

  InternetDropDown({
    super.key,
    // required this.isLoading,
    required this.allBanks,
    required this.dataDropdown,
    required this.amountController,
  });

  @override
  State<InternetDropDown> createState() => _InternetDropDownState();
}

class _InternetDropDownState extends State<InternetDropDown> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Service Provider")),
      DropdownMenuItem(value: "smile-direct", child: Text("Smile-Direct")),
      DropdownMenuItem(value: "spectranet", child: Text("Spectranet")),
    ];
    return menuItems;
  }

  final _billController = Get.find<BillController>();
  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          "Select Service Provider",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 1.h,
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
                  buyInternetFields.setBillersCode = selectedValue;
                  print(newValue);
                  if (selectedValue.isNotEmpty) {
                    // fetchDataByServiceId(newValue);
                  }
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
        SizedBox(
          height: 2.h,
        ),
        DataDropDown(
          model: buyInternetFields,
          dropDownItemsList: widget.dataDropdown,
          amount: widget.amountController,
          code: "",
          dataProvided: widget.allBanks,
        ),
        SizedBox(
          height: 0.5.h,
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDataList(List<DataDetails> data) {
    List<DropdownMenuItem<String>> dataItems = [];
    dataItems.add(
      const DropdownMenuItem(value: "", child: Text("Select Desired Data")),
    );

    for (var i = 0; i < data.length; i++) {
      dataItems.add(
        DropdownMenuItem(value: i.toString(), child: Text(data[i].name)),
      );
    }

    return dataItems;
  }
}
