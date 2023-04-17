import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../individual/widgets/business_warning.dart';
import '../../individual/widgets/head_style_extra_pages.dart';

class AddSalesAccount extends StatefulWidget {
  const AddSalesAccount({super.key});

  @override
  State<AddSalesAccount> createState() => _AddSalesAccountState();
}

class _AddSalesAccountState extends State<AddSalesAccount> {
  final _userController = Get.find<UserController>();
  
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

  List accountManagers = [
    {'name': 'Manager1', 'value': '1'},
    {'name': 'Manager2', 'value': '2'}
  ];
  String? selectedManager;

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
              ProgressStyle(
                stage: 0,
                pageName: "Create Account",
                // backRoute: BusinessHome(
                //   userDetails: _userController.user!,
                //   accountDetails: _userController.userAccountDetails!,
                // ),
              ),
              SizedBox(
                height: 3.h,
              ),
              const BusinessWarning(),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                    "Name your Account",
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
                        hintText: "e.g Challenge Branch",
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
                    "Select Admin",
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
                      hint: const Text("Select Account Manager"),
                      value: selectedManager,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedManager = value;
                          } else {
                            selectedManager = "";
                          }
                        });
                      },
                      items: accountManagers.map((manager) {
                        return DropdownMenuItem<String>(
                          value: manager['value'],
                          child: Text(manager['name']),
                        );
                      }).toList(),
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
                height: 10.h,
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
