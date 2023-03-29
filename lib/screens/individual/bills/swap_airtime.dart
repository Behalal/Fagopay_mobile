import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/transactions/confirm_transaction.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SwapAirtime extends StatefulWidget {
  const SwapAirtime({super.key});

  @override
  State<SwapAirtime> createState() => _SwapAirtimeState();
}

class _SwapAirtimeState extends State<SwapAirtime> {
  late bool mtnActive;
  late bool airtelActive;
  late bool gloActive;
  late bool etisatActive;
  @override
  void initState() {
    mtnActive = true;
    airtelActive = false;
    gloActive = false;
    etisatActive = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                        pageName: "Swap Airtime",
                        // backRoute: const DashboardHome(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const AutoSizeText(
                        "Select Network Provider",
                        style: TextStyle(
                            color: welcomeText,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                mtnActive = true;
                                airtelActive = false;
                                gloActive = false;
                                etisatActive = false;
                              });
                            }),
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (mtnActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image: AssetImage("assets/images/mtn.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                mtnActive = false;
                                airtelActive = true;
                                gloActive = false;
                                etisatActive = false;
                              });
                            }),
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (airtelActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image:
                                        AssetImage("assets/images/airtel.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                mtnActive = false;
                                airtelActive = false;
                                gloActive = true;
                                etisatActive = false;
                              });
                            }),
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (gloActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image: AssetImage("assets/images/glo.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                mtnActive = false;
                                airtelActive = false;
                                gloActive = false;
                                etisatActive = true;
                              });
                            }),
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (etisatActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/etisalat.png")),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      const AutoSizeText(
                        "Enter Phone Number",
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
                            hintText: "Enter Phone Number",
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
                        height: 0.5.h,
                      ),
                      Container(
                        width: 90.w,
                        decoration: const BoxDecoration(
                            color: fagoSecondaryColorWithOpacity10,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Image(
                                  image:
                                      AssetImage("assets/images/account.png")),
                              SizedBox(
                                width: 2.w,
                              ),
                              const AutoSizeText(
                                "Ibrahim Lukman",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: welcomeText,
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              const AutoSizeText(
                                "Select from Contacts",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Work Sans",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: fagoBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const AutoSizeText(
                        "Confirm Phone Number",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: welcomeText,
                        ),
                      ),
                      SizedBox(height: 2.h),
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
                            hintText: "Confirm Phone Number",
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
                        "How much Airtime to Swap",
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
                            hintText: "Enter Amount",
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
                      Container(
                        decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Row(
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
                                      "Transaction Information",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    const AutoSizeText(
                                      "Fee",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    const AutoSizeText(
                                      "Transaction Fee",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 42.w,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        "$currencySymbol 100",
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: verificationCodeText,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      AutoSizeText(
                                        "$currencySymbol 1,000",
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: verificationCodeText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: AuthButtons(
                            form: false,
                            text: "Continue",
                            route: ConfirmTransactions(
                              backRoute: const SwapAirtime(),
                              action: 'swap',
                            )),
                      )
                    ]))));
  }
}
