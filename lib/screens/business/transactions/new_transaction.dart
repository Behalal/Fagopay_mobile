import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  bool inflowTab = true;

  List country = [
    {'name': 'Select Country', 'value': ''},
    {'name': 'Nigeria', 'value': 'nga'},
    {'name': 'Ghana', 'value': 'gha'}
  ]; // Option 2
  String? selectedCountry;

  List state = [
    {'name': 'Select State', 'value': ''},
    {'name': 'Ogun', 'value': 'ogun'},
    {'name': 'Oyo', 'value': 'oyo'}
  ];
  String? selectedState;

  List supplierBank = [
    {'name': 'Access', 'value': '1'},
    {'name': 'Guaranty Trust Bank', 'value': '2'}
  ];
  String? selectedBank;
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
                pageName: "Add Transaction",
                // backRoute: AllTransaction(),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    },
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Inflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        if (inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    }),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (!inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Outflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              ///////////////////****New Transaction Form****/////////////////////////////////////////////
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
                      value: selectedBank,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedBank = value;
                          } else {
                            selectedBank = "";
                          }
                        });
                      },
                      items: supplierBank.map((bank) {
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
                        color: stepsColor,
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
                    "Email Address",
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
                          color: stepsColor),
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
                        hintText: "Enter Email",
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
                          color: stepsColor),
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
                        hintText: "Enter Phone",
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
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: AuthButtons(form: true, text: "Save", route: null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
