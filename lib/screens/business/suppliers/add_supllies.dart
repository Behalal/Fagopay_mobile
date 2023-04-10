import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import 'all_supplies.dart';

class AddSupplies extends StatefulWidget {
  const AddSupplies({super.key});

  @override
  State<AddSupplies> createState() => _AddSuppliesState();
}

class _AddSuppliesState extends State<AddSupplies> {
  List banks = [
    {'name': 'Select Bank', 'value': ''},
    {'name': 'Individual', 'value': '1'},
    {'name': 'Company', 'value': '2'}
  ];
  late String selectedBanks;

  List country = [
    {'name': 'Select Country', 'value': ''},
    {'name': 'Nigeria', 'value': 'nga'},
    {'name': 'Ghana', 'value': 'gha'}
  ]; // Option 2
  late String selectedCountry;

  List state = [
    {'name': 'Select State', 'value': ''},
    {'name': 'Ogun', 'value': 'ogun'},
    {'name': 'Oyo', 'value': 'oyo'}
  ]; // Option 2
  late String selectedState;

  @override
  void initState() {
    selectedBanks = "";
    selectedCountry = "";
    selectedState = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 0,
                width: 4,
                pageName: "My Supplies",
                backRoute: AllSupplies(),
              ),
              SizedBox(
                height: 3.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                    "Supplier Bank",
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
                  SizedBox(
                    width: 90.w,
                    child: DropdownButtonFormField(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      decoration: InputDecoration(
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
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
                      ),
                      hint: const Text("Select Bank"),
                      value: (selectedBanks == '') ? null : selectedBanks,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedBanks = value;
                          } else {
                            selectedBanks = "";
                          }
                        });
                      },
                      items: banks.map((bank) {
                        return DropdownMenuItem<String>(
                          value: bank['value'],
                          child: Text(bank['name']),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Supplier Account Number",
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
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      decoration: InputDecoration(
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
                        hintText: "Enter Account Number",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Supplier Account Name",
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.5.h,
                    ),
                    decoration: const BoxDecoration(
                      color: fagoSecondaryColorWithOpacity10,
                    ),
                    child: const AutoSizeText(
                      "Obasana Nasir",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: inactiveTab,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Email",
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
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
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
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter email",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Phone Number",
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
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
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
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter fullname",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 42.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Country",
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
                            DropdownButtonFormField(
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: signInPlaceholder,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.5.h),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: linearGradient1,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: textBoxBorderColor,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                hintText: "Enter country",
                                hintStyle: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: signInPlaceholder,
                                ),
                              ),
                              value: (selectedCountry == '')
                                  ? null
                                  : selectedCountry,
                              hint: const Text("Select country"),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    selectedCountry = value;
                                  } else {
                                    selectedCountry = "";
                                  }
                                });
                              },
                              items: country.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country['value'],
                                  child: Text(country['name']),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 42.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "State",
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
                            DropdownButtonFormField(
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: signInPlaceholder,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.5.h),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: linearGradient1,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: textBoxBorderColor,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                hintText: "Enter country",
                                hintStyle: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: signInPlaceholder,
                                ),
                              ),
                              value:
                                  (selectedState == '') ? null : selectedState,
                              hint: const Text("Select state"),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    selectedState = value;
                                  } else {
                                    selectedState = "";
                                  }
                                });
                              },
                              items: state.map((eachState) {
                                return DropdownMenuItem<String>(
                                  value: eachState['value'],
                                  child: Text(eachState['name']),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Address, city",
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
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
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
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "12, adjascent KFC, Ikoyi estate, island",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: AuthButtons(form: true, text: "Save", route: null),
              )
            ],
          ),
        ),
      ),
    );
  }
}
