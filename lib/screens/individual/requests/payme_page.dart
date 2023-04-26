// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/individual/requests/share_payment_link.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PleasePayMePage extends StatefulWidget {
  const PleasePayMePage({
    super.key,
  });

  @override
  State<PleasePayMePage> createState() => _PleasePayMePageState();
}

class _PleasePayMePageState extends State<PleasePayMePage> {
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Column(
                                children: [
                                  SvgPicture.asset('assets/icons/Group 95.svg'),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const AutoSizeText(
                                    'Ibrahim Lukman',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: stepsColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  const AutoSizeText(
                                    "Please pay me.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: inactiveTab,
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: 3.h,
                              ),
                              Container(
                                decoration: DottedDecoration(
                                    linePosition: LinePosition.bottom,
                                    color: transactionKeys,
                                    dash: const [3, 3]),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              const AutoSizeText(
                                "A note from Ibrahim",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const AutoSizeText(
                                "I will appreciate your support no matter how much is not little.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: inactiveTab,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              const AutoSizeText(
                                'Enter Amount',
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
                                // controller: _userController.nameController,
                                keyboadType: TextInputType.number,
                                title: '0',
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Note must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              const AutoSizeText(
                                'Enter Name',
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
                                // controller: _userController.nameController,
                                title: 'Enter your name',
                                keyboadType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Amount must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              const AutoSizeText(
                                'Email Address',
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
                                // controller: _userController.nameController,
                                title: 'Email Address',
                                keyboadType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Amount must not be empty';
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
                              NameTextfield(
                                // controller: _userController.nameController,
                                title: '08123045845',
                                keyboadType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Amount must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/markIcon.svg'),
                                  // SizedBox(
                                  //   width: 1.h,
                                  // ),
                                  const AutoSizeText(
                                    "By clicking on I support or using the custom box, I consent \nthat Fagopay shall debit my wallet to credit the requestee.",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: stepsColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Center(
                                child: AuthButtons(
                                    form: false,
                                    text: "Pay",
                                    route: const SharePaymentLink()),
                              ),
                            ],
                          ),
                        )),
                  ),
                ])));
  }
}
