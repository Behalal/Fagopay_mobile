import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/terms_and_cond.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/kyc/busin_verification_page.dart';
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';

class BusinessBox extends StatefulWidget {
  final bool isBiz;
  const BusinessBox({super.key, required this.isBiz});

  @override
  State<BusinessBox> createState() => _BusinessBoxState();
}

class _BusinessBoxState extends State<BusinessBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 5.w),
      child: Container(
        alignment: Alignment.topLeft,
        // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        //height: 140,
        decoration: (widget.isBiz)
            ? DottedDecoration(
                shape: Shape.box, color: fagoSecondaryColor, dash: const [3, 3])
            : const BoxDecoration(
                color: boxDecorationBackground,
                borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: (widget.isBiz == true)
                        ? SvgPicture.asset(
                            "assets/icons/account_choosed_logo.svg")
                        : SizedBox(
                            height: 2.h,
                          ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(' assets/icons/business_type_icon.svg'),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: const AutoSizeText(
                              "Business Account",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 50.w,
                            child: const AutoSizeText(
                              "I will like to operate the account in my personal name.",
                              // "hello",
                              textAlign: TextAlign.left,
                              minFontSize: 10,
                              stepGranularity: 10,
                              maxLines: 4,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/mark_icon.svg'),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    const AutoSizeText(
                                      "Account details in Business Name",
                                      // "hello",
                                      textAlign: TextAlign.left,
                                      minFontSize: 10,
                                      stepGranularity: 10,
                                      maxLines: 4,
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  width: 50.w,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/mark_icon.svg'),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "Access to all business tool",
                                        // "hello",
                                        textAlign: TextAlign.left,
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  width: 50.w,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/mark_icon.svg'),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "High transactional limit",
                                        // "hello",
                                        textAlign: TextAlign.left,
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  width: 50.w,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/mark_icon.svg'),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "CAC & BVN & ID verification",
                                        // "hello",
                                        textAlign: TextAlign.left,
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/mark_icon.svg'),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    const AutoSizeText(
                                      "Create upto 3 Business Account",
                                      // "hello",
                                      textAlign: TextAlign.left,
                                      minFontSize: 10,
                                      stepGranularity: 10,
                                      maxLines: 4,
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  height: 1.h,
                                )
                              : Container(),
                          (widget.isBiz == true)
                              ? SizedBox(
                                  width: 50.w,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/mark_icon.svg'),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "Create upto 5 sub Account per \nBusiness",
                                        // "hello",
                                        textAlign: TextAlign.left,
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                  (widget.isBiz == true)
                      ? SizedBox(
                          height: 2.h,
                        )
                      : Container(),
                  (widget.isBiz == true) ? const TermsAndCond() : Container(),
                  (widget.isBiz == true)
                      ? SizedBox(
                          height: 2.h,
                        )
                      : Container(),
                  (widget.isBiz == true)
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: GestureDetector(
                            onTap: () {
                              // if (personalSelected) {
                              //   registrationData.setAccountType = "2";
                              // } else {
                              //   registrationData.setAccountType = "1";
                              // }
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const KycVerfication(),
                                ),
                              );
                            },
                            child: AuthButtons(
                              form: true,
                              text: 'Proceed to Verification',
                              route: const IdentityPassPage(),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
