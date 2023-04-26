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

class CreatePaymentLink extends StatefulWidget {
  const CreatePaymentLink({
    super.key,
  });

  @override
  State<CreatePaymentLink> createState() => _CreatePaymentLinkState();
}

class _CreatePaymentLinkState extends State<CreatePaymentLink> {
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
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Edit Link",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Create a payment link and share with anyone to recieve money.",
                              textAlign: TextAlign.center,
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
                              'Enter a note',
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
                              keyboadType: TextInputType.text,
                              title:
                                  'Make a brief note to why they need to pay you',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Note must not be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            const AutoSizeText(
                              "Remaining 200 characters",
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
                              title: '0',
                              keyboadType: TextInputType.number,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Amount must not be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            const AutoSizeText(
                              "Remaining 200 characters",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: inactiveTab,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Center(
                              child: AuthButtons(
                                  form: false,
                                  text: "Create Payment Link",
                                  route: const SharePaymentLink()),
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}
