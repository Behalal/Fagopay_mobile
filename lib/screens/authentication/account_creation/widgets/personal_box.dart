import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/terms_and_cond.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/kyc/personal_verification_page.dart';
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:fagopay/screens/kyc/busin_verification_page.dart';
import 'package:fagopay/screens/kyc/kyc2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';

class PersonalBox extends StatefulWidget {
  final bool isBiz;
  const PersonalBox({super.key, required this.isBiz});

  @override
  State<PersonalBox> createState() => _PersonalBoxState();
}

class _PersonalBoxState extends State<PersonalBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 5.w),
      child: Container(
        // height: (widget.isBiz == true) ? 15.h : 9.h,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        decoration: (widget.isBiz)
            ? DottedDecoration(
                shape: Shape.box, color: fagoSecondaryColor, dash: const [3, 3])
            : const BoxDecoration(
                color: fagoSecondaryColorWithOpacity10,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        child: (widget.isBiz == true)
                            ? Image.asset("assets/images/check_Icon.png")
                            : null),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset("assets/images/Ellipse 62.png"),
                            Image.asset("assets/images/personal_Icon.png")
                          ],
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Personal Account",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              width: 50.w,
                              child: const AutoSizeText(
                                "I will like to operate the account in \nmy personal name.",
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
                                          "Personal name in account details",
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
                                          "Access to business tool such as \ninvoice, bookkeeping, & customer \nmanagement.",
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
                                          "Low transactional limit",
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
                                          "BVN & ID verification Only",
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
                                          "Create Only 1 personal account",
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ProfileKycPage()

                                      //     KycVerfication(
                                      //   accountType: "individual",
                                      // ),
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
      ),
    );
  }
}
