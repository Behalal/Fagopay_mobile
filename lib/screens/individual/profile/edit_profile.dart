// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var number = "";
  int? transactionType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Edit Profile",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 40, // Image radius
                                    backgroundImage:
                                        AssetImage('assets/images/fago(2).png'),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const AutoSizeText(
                                    'Obasana Nasir',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: welcomeText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: 'Kindly contact ',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'support@fagopay.africa ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: fagoSecondaryColor),
                                  ),
                                  TextSpan(
                                    text: 'to change your name and email.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: stepsColor),
                                  ),
                                ],
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
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: Get.width,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  color: fagoPrimaryColorWithOpacity10,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: fagoSecondaryColorWithOpacity)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const AutoSizeText(
                                      'Obasana Nasir',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: welcomeText,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/icons/lock-icon.svg',
                                      color: fagoSecondaryColor,
                                    )
                                  ]),
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
                                  color: fagoSecondaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  fillColor: white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: fagoSecondaryColorWithOpacity,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: fagoSecondaryColorWithOpacity,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: fagoSecondaryColorWithOpacity,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Phone Number',
                                  hintStyle: GoogleFonts.roboto(
                                    color: stepsColor,
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // controller: authController.phoneNoController,
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
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: Get.width,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  color: fagoPrimaryColorWithOpacity10,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: fagoSecondaryColorWithOpacity)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const AutoSizeText(
                                      'Obasana@gmail.com',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: welcomeText,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/icons/lock-icon.svg',
                                      color: fagoSecondaryColor,
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Center(
                              child: AuthButtons(
                                form: false,
                                text: "Update",
                              ),
                            ),
                          ],
                        )),
                  ),
                ])));
  }
  
}
