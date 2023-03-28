import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/kyc/Bvn_otp.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fagopay/screens/kyc/kyc1.dart';

import '../constants/colors.dart';

class BusinessVerify extends StatefulWidget {
  const BusinessVerify({super.key});

  @override
  State<BusinessVerify> createState() => BusinessVerifyState();
}

class BusinessVerifyState extends State<BusinessVerify> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Company Type")),
      DropdownMenuItem(value: "RC", child: Text("RC")),
      DropdownMenuItem(value: "BN", child: Text("BN")),
      DropdownMenuItem(value: "IT", child: Text("LL")),
      DropdownMenuItem(value: "LL", child: Text("LL")),
      DropdownMenuItem(value: "LLP", child: Text("LLP")),
    ];

    return menuItems;
  }

  String selectedValue = "";
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
              CurrentStep(step: "2", backRoute: const Kyc_verfication()),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Verify your Business",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Please provide us an issued certificate from the corporate affairs commission or issued business certificate to certify that your business is registered",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              const Text(
                "Company Email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Company Email",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/images/bi_shield-lock.png")),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Provide your RC Number",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.5.w),
                child: SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "RC Number",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/images/bi_shield-lock.png")),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              const Text(
                "Business Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.5.w),
                child: SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "RC Name",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/images/bi_shield-lock.png")),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Address",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Address",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/images/bi_shield-lock.png")),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Company Address",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Company Address",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/images/bi_shield-lock.png")),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Select Company Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 8.w),
                child: Container(
                  padding: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: textBoxBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
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
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Select Country Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 8.w),
                child: Container(
                  padding: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: textBoxBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
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
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Select State Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 8.w),
                child: Container(
                  padding: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: textBoxBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
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
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Select City Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: welcomeText,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 8.w),
                child: Container(
                  padding: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: textBoxBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
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
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                child: AuthButtons(
                  hasImage: "assets/images/bi_shield-lock-white.png",
                  text: "Verify Business",
                  route: const BvnOTP(),
                  form: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
