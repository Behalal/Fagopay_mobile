import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/dashboard/bills/widgets/tv_sub_dropdown.dart';
import 'package:fagopay/screens/dashboard/bills/widgets/tv_subscriptions.dart';
import 'package:fagopay/screens/dashboard/transactions/confirm_transaction.dart';
import 'package:fagopay/screens/dashboard/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TVSubscription extends StatefulWidget {
  const TVSubscription({super.key});

  @override
  State<TVSubscription> createState() => _TVSubscriptionState();
}

class _TVSubscriptionState extends State<TVSubscription> {
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
                        pageName: "Cable Subscription",
                        // backRoute: const DashboardHome(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const TVProviders(),
                      SizedBox(
                        height: 2.h,
                      ),
                      const CablePackageDropDown(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                "Price",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: welcomeText,
                                ),
                              ),
                              AutoSizeText(
                                "$currencySymbol 15,000",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: welcomeText,
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
                        "Enter Router Number",
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
                            hintText: "Enter Router Number",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AutoSizeText(
                                "Fullname",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: welcomeText,
                                ),
                              ),
                              AutoSizeText(
                                "Obasa Yusuf",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: welcomeText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: AuthButtons(
                            form: false,
                            text: "Continue",
                            route: ConfirmTransactions(
                              backRoute: const TVSubscription(),
                              action: 'tv',
                            )),
                      )
                    ]))));
  }
}
