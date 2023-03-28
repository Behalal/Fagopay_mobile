import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/dashboard/home/dashboard_home.dart';
import 'package:fagopay/screens/dashboard/widgets/account_details.dart';
import 'package:fagopay/screens/dashboard/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FundWallet extends StatefulWidget {
  // final String action;
  final Map<String, dynamic>? accountDetails;
  const FundWallet({
    super.key,
    this.accountDetails,
  });

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  @override
  Widget build(BuildContext context) {
    print(
        "new balance is $currencySymbol ${widget.accountDetails?['balance'] ?? ''}.00");
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
                        pageName: "Fund Wallet",
                        backRoute: DashboardHome(userDetails: userFullDetails),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                                      "Balance Limit",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AutoSizeText(
                                      (widget.accountDetails!.isNotEmpty &&
                                              widget.accountDetails != null)
                                          ? "$currencySymbol 1,000,000.00"
                                          : "${currencySymbol}0.00",
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: fagoSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 42.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const AutoSizeText(
                                      "You can still add",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AutoSizeText(
                                      (widget.accountDetails!.isNotEmpty &&
                                              widget.accountDetails != null)
                                          ? "$currencySymbol 300,000.00"
                                          : "${currencySymbol}0.00",
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: fagoSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            height: 87,
                            decoration: const BoxDecoration(
                              color: fagoSecondaryColorWithOpacity10,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 42.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Balance",
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: verificationCodeText,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        AutoSizeText(
                                          (widget.accountDetails!.isNotEmpty &&
                                                  widget.accountDetails != null)
                                              ? "$currencySymbol ${widget.accountDetails!['balance']}"
                                              : "${currencySymbol}0.00",
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
                                  SizedBox(
                                    width: 42.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AutoSizeText(
                                          (widget.accountDetails!.isNotEmpty &&
                                                  widget.accountDetails != null)
                                              ? " ${widget.accountDetails!['bank_name']}"
                                              : "",
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: verificationCodeText,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        AutoSizeText(
                                          (widget.accountDetails!.isNotEmpty &&
                                                  widget.accountDetails != null)
                                              ? " ${widget.accountDetails!['account_number']}"
                                              : "",
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: verificationCodeText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // AccountDetails(
                      //   action: "add",
                      //   accountDetails: const {},
                      // ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 45.w,
                            child: const AutoSizeText(
                              "Send money to account",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: verificationCodeText,
                              ),
                            ),
                          ),
                          Container(
                            width: 33.w,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: fagoGreenColorWithOpacity17),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 6),
                              child: AutoSizeText(
                                "Recommended",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: verificationCodeText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 115,
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
                                      "Bank",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    const AutoSizeText(
                                      "Account Name",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    const AutoSizeText(
                                      "Account No",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: verificationCodeText,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 42.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AutoSizeText(
                                      widget.accountDetails?['bank_name'] ?? "",
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    AutoSizeText(
                                      widget.accountDetails?['account_name'] ??
                                          "",
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: verificationCodeText,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AutoSizeText(
                                            widget.accountDetails?[
                                                    'account_number'] ??
                                                "",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: verificationCodeText,
                                            ),
                                          ),
                                          SizedBox(width: 1.w),
                                          const Icon(
                                            Icons.copy_outlined,
                                            size: 15,
                                          )
                                        ],
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
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 2.h),
                        child: const AutoSizeText(
                          "OR",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const AutoSizeText(
                        "Enter Amount to Fund",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: verificationCodeText,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder),
                          decoration: InputDecoration(
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
                            hintText: "0.00",
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
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 1.h),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            //  Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         const DashboardHome(),
                            //   ),
                            // ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 3.w),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: buttonColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.credit_card,
                                    size: 15,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  const AutoSizeText(
                                    "Use Card to Top up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Work Sans",
                                        fontWeight: FontWeight.w600,
                                        color: white),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: .5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: const [
                              Image(
                                  image:
                                      AssetImage("assets/images/shield.png")),
                              Image(image: AssetImage("assets/images/key.png")),
                            ],
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          const AutoSizeText(
                            "Secured by flutterwave",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                color: inactiveTab),
                          ),
                        ],
                      )
                    ]))));
  }
}
