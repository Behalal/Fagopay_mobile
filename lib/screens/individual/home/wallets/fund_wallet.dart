// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:url_launcher/url_launcher.dart';

class FundWallet extends StatefulWidget {
  // final String action;
  final AccountDetail accountDetails;

  const FundWallet({
    Key? key,
    required this.accountDetails,
  }) : super(key: key);

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  final _transactioncontroller = Get.find<TransactionController>();

  @override
  void dispose() {
    _transactioncontroller.amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "new balance is $currencySymbol ${widget.accountDetails.balance ?? ''}.00");
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProgressStyle(
                      stage: 50,
                      pageName: "Fund Wallet",
                      // backRoute: DashboardHome(userDetails: userFullDetails),
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
                                    (widget.accountDetails.accountNumber!
                                            .isNotEmpty)
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
                                    (widget.accountDetails.accountNumber!
                                            .isNotEmpty)
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 42.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        (widget.accountDetails.accountNumber!
                                                .isNotEmpty)
                                            ? "$currencySymbol ${widget.accountDetails.balance}"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        (widget.accountDetails.accountNumber!
                                                .isNotEmpty)
                                            ? " ${widget.accountDetails.bankName}"
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
                                        (widget.accountDetails.accountNumber!
                                                .isNotEmpty)
                                            ? " ${widget.accountDetails.accountNumber}"
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
                          width: 30.w,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: fagoGreenColorWithOpacity17),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            child: FittedBox(
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
                                    widget.accountDetails.bankName ?? "",
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: verificationCodeText,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  AutoSizeText(
                                    widget.accountDetails.accountName ?? "",
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AutoSizeText(
                                          widget.accountDetails.accountNumber ??
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.w, vertical: 2.h),
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
                    // SizedBox(
                    //   height: 0.5.h,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 1.h,
                      ),
                      child: TextFormField(
                        controller: _transactioncontroller.amountController,
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
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
                          onTap: () async {
                            if (_transactioncontroller.amountController.text !=
                                "") {
                              await fundWallet(context);
                              return;
                            }
                            Fluttertoast.showToast(
                              msg: "Fill in the form properly!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text('Fill in the form properly!'),
                            //   ),
                            // );
                          },
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
                                image: AssetImage("assets/images/shield.png")),
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
                            color: inactiveTab,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fundWallet(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _transactioncontroller
        .fundWallet(_transactioncontroller.amountController.text);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      progress.dismiss();
      final hostedLink = jsonData['data']['link'];
      await _launchURL('$hostedLink');
      return;
    }
    progress.dismiss();
    Fluttertoast.showToast(
      msg: "${jsonData['data']['error'][0]}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('${jsonData['data']['error'][0]}'),
    //   ),
    // );
  }

  _launchURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      // mode: LaunchMode.inAppWebView,
    )) throw 'Could not launch $url';
  }
}
