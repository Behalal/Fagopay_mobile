import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/bills/electricity.dart';
import 'package:fagopay/screens/individual/requests/make_request.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupportRequest extends StatelessWidget {
  const SupportRequest({super.key});

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
                          stage: 50,
                          pageName: "Support Request",
                          backRoute: const MakeRequest()),
                      SizedBox(
                        height: 2.h,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: stepsColor),
                            children: [
                              const TextSpan(text: 'Support'),
                              const TextSpan(
                                  text: ' Ibrahim Lukman',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const TextSpan(text: ' request of '),
                              TextSpan(
                                  text: '$currencySymbol 200',
                                  style: const TextStyle(
                                      color: fagoSecondaryColor)),
                            ]),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        height: 105,
                        decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 2.5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // width: 60.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.contacts_rounded,
                                          color: stepsColor,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        const AutoSizeText(
                                          "Ibrahim Lukman",
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: stepsColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const AutoSizeText(
                                      "Narration",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    const AutoSizeText(
                                      "I want to buy a new laptop ",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "$currencySymbol 200",
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: fagoSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: AuthButtons(
                            form: false,
                            text: "Continue",
                            route: const Electricity()),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: const AutoSizeText(
                          "OR",
                          style: TextStyle(
                              color: fagoSecondaryColor,
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const AutoSizeText(
                        "How much can you afford?",
                        style: TextStyle(
                            color: stepsColor,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 1.h,
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
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            hintText: "Amount to request",
                            hintStyle: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder,
                            ),
                            suffixIcon: const Icon(Icons.send_outlined,
                                color: fagoSecondaryColor, size: 25),
                          ),
                        ),
                      ),
                    ]))));
  }
}
