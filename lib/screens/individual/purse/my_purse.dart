// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/purse/create_purse.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPurse extends StatefulWidget {
  const MyPurse({
    super.key,
  });

  @override
  State<MyPurse> createState() => _MyPurseState();
}

class _MyPurseState extends State<MyPurse> {
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    'My Purse',
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  const Divider(
                      thickness: 2, color: fagoPrimaryColorWithOpacity),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.h, vertical: 2.h),
                              height: 27.h,
                              width: Get.width,
                              color: fagoSecondaryColorWithOpacity10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/purse_icon.svg'),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  const AutoSizeText(
                                    'No Purse yet',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: stepsColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const AutoSizeText(
                                    'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: stepsColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const CreatePurse());
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 23.5.h,
                                      decoration: BoxDecoration(
                                          color: fagoSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: fagoSecondaryColor)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const AutoSizeText(
                                            'Create a Purse',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: white,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              'assets/icons/create_wallet.svg')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}
