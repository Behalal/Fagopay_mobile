// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/models/nextofkin_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_model/completeUserModel.dart';
import '../../constants/colors.dart';

class NextOfKinPage extends StatefulWidget {
  const NextOfKinPage({
    super.key,
  });

  @override
  State<NextOfKinPage> createState() => _NextOfKinPageState();
}

class _NextOfKinPageState extends State<NextOfKinPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var number = "";
  int? transactionType;
  String? selectedRelationship;
  @override
  void initState() {
    _userController.nameController.text = _userController.user?.nextofkin?.fullName ?? "";
    _userController.phoneNumController.text = _userController.user?.nextofkin?.phoneNumber ?? "";
    _userController.emailController.text = _userController.user?.nextofkin?.email ?? "";
    _userController.addressController.text = _userController.user?.nextofkin?.houseAddress ?? "";
    _userController.relationshipController.text = _userController.user?.nextofkin?.relationship ?? "";
    super.initState();
  }

  final _userController = Get.find<UserController>();
  final List<String> items = [
    'Siblings',
    'Father',
    'Mother',
    'Relationship Partner',
    'Husband',
    'Wife',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Next of Kin",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.5.w),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "Your Next of Kin",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: 90.w,
                                  child: const AutoSizeText(
                                    "This person will be your beneficiary in the long term and will be the first contact in case we are unable to reach you.",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: inactiveTab,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),

                                const AutoSizeText(
                                  'Name',
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
                                NameTextfield(
                                  controller: _userController.nameController,
                                  title: 'Yussuf Samad',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'full name must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                const AutoSizeText(
                                  'Phone Number',
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
                                IntlPhoneField(
                                    disableLengthCheck: true,
                                    keyboardType: Platform.isIOS
                                        ? const TextInputType.numberWithOptions(
                                            signed: true, decimal: false)
                                        : TextInputType.phone,
                                    flagsButtonMargin:
                                        const EdgeInsets.only(left: 8),
                                    style: GoogleFonts.roboto(
                                      color: stepsColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                fagoSecondaryColorWithOpacity,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                                  fagoSecondaryColorWithOpacity,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                                  fagoSecondaryColorWithOpacity,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Phone Number',
                                      hintStyle: GoogleFonts.roboto(
                                        color: stepsColor,
                                        fontSize: 13,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    controller:
                                        _userController.phoneNumController,
                                    initialCountryCode: "NG",
                                    validator: (data) {
                                      number = data!.number;
                                      if (number.length < 10 ||
                                          number.length > 10) {
                                        return "Invalid phone number";
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(number)) {
                                        return "Please enter only digits";
                                      }
                                      return null;
                                    },
                                    onChanged: (data) {
                                      number = data.countryCode;
                                    }),
                                // Container(
                                //   padding: const EdgeInsets.all(15),
                                //   width: Get.width,
                                //   height: 6.h,
                                //   decoration: BoxDecoration(
                                //       color: fagoPrimaryColorWithOpacity10,
                                //       borderRadius: BorderRadius.circular(8),
                                //       border: Border.all(
                                //           color: fagoSecondaryColorWithOpacity)),
                                //   child: Row(
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         const AutoSizeText(
                                //           'Obasana Nasir',
                                //           style: TextStyle(
                                //             fontFamily: "Work Sans",
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w600,
                                //             color: welcomeText,
                                //           ),
                                //         ),
                                //         const Spacer(),
                                //         SvgPicture.asset(
                                //           'assets/icons/lock-icon.svg',
                                //           color: fagoSecondaryColor,
                                //         )
                                //       ]),
                                // ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                const AutoSizeText(
                                  'Email',
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
                                NameTextfield(
                                  controller: _userController.emailController,
                                  title: 'yussamad@gmail.com',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email must not be empty';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(
                                  height: 3.h,
                                ),
                                const AutoSizeText(
                                  'Address, city',
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
                                NameTextfield(
                                  controller: _userController.addressController,
                                  title:
                                      '12, adjascent KFC, Ikoyi estate, island',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Address must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                const AutoSizeText(
                                  'Relationship',
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
                                  width: Get.width,
                                  height: 58,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              fagoSecondaryColorWithOpacity)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(_userController.relationshipController.text.isEmpty ? 'Categories' : _userController.relationshipController.text,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedRelationship,
                                      onChanged: (value) {
                                        setState(() {
                                          _userController.relationshipController.text = value as String;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if("${_userController.user?.firstName?.toLowerCase()}${_userController.user?.lastName?.toLowerCase()}" == ExtendedString(_userController.nameController.text.toLowerCase()).removeAllWhitespace){
                                      Get.snackbar("Error", "Personal name cannot be added as next of Kin", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                    }else if(_userController.user?.email?.toLowerCase() == _userController.emailController.text.toLowerCase()){
                                      Get.snackbar("Error", "Personal email cannot be added as next of Kin", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                    }else if(_userController.user?.phoneNumber == _userController.phoneNumController.text){
                                      Get.snackbar("Error", "Personal phone number cannot be added as next of Kin", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                    }else{
                                      NextOfKinModel nextOfKin = NextOfKinModel(
                                          fullName: _userController
                                              .nameController.text
                                              .trim(),
                                          houseAddress: _userController
                                              .addressController.text
                                              .trim(),
                                          phoneNumber: number +
                                              _userController
                                                  .phoneNumController.text
                                                  .trim(),
                                          email: _userController
                                              .emailController.text
                                              .trim(),
                                          relationship: selectedRelationship);
                                      if (kDebugMode) {
                                        print(
                                            'Next of kin: ${nextOfKin.toJson()}');
                                      }
                                      print('here i am');
                                      if (_userController.nextOfKinStatus !=
                                          NextOfKinEnum.loading &&
                                          formKey.currentState!.validate()) {
                                        print('here i am 3');
                                        _userController.uploadNextOfKin(context: context);
                                      }
                                      print('here i am 2');
                                    }
                                  },
                                  child: Container(
                                      height: 50,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(36),
                                          color: fagoSecondaryColor),
                                      child: const Center(
                                        child: AutoSizeText(
                                          'Save',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: white,
                                          ),
                                        ),
                                      )),
                                ),
                                // Center(
                                //   child: AuthButtons(
                                //     form: false,
                                //     text: "Save",
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ])));
  }
}

extension ExtendedString on String {
  String removeAllWhitespace() {
    return replaceAll(RegExp(r"\s+"), "");
  }
}

class NameTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboadType;
  final String? errorText;
  final String? title;
  final Color? boarderColor;
  final String? validatorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;

  const NameTextfield({
    super.key,
    this.errorText,
    this.onChanged,
    this.controller,
    this.title,
    this.validate,
    this.validatorText,
    this.keyboadType,
    this.boarderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 55,
      width: Get.width,
      child: TextFormField(

        validator: validate ??
            (value) {
              if (value == null || value.isEmpty) {
                return validatorText;
              } else {
                return null;
              }
            },
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboadType,
        style: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: stepsColor),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: textBoxBorderColor ?? boarderColor!,
              width: 1.0,
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                  style: BorderStyle.solid)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: linearGradient1,
                  width: 1.0,
                  style: BorderStyle.solid)),
          hintText: title,
          hintStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: stepsColor,
          ),
          //prefixIcon: const Image(image: AssetImage("assets/images/phone.png")),
        ),
      ),
    );
  }
}
