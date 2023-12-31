import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/fund_wallet.dart';
import 'package:fagopay/screens/constants/keys.dart';
import 'package:fagopay/screens/individual/home/wallets/web_view.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:url_launcher/url_launcher.dart';

class FundWallet extends StatefulWidget {
  // final String action;
  final dynamic accountDetails;

  const FundWallet({
    Key? key,
    required this.accountDetails,
  }) : super(key: key);

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  final tc = Get.put(TransactionController());
  final _transactioncontroller = Get.find<TransactionController>();
  final _userUcontroller = Get.find<UserController>();

  @override
  void dispose() {
    _transactioncontroller.amountController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // print(
    //     "new balance is $currencySymbol ${widget.accountDetails.balance ?? ''}.00");
    return Scaffold(
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
                                  ? "$currencySymbol ${_userUcontroller.user!.accountDailyLimit}"
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
                              (widget.accountDetails.accountNumber!.isNotEmpty)
                                  ? "$currencySymbol ${double.parse(_userUcontroller.user!.accountDailyLimit ?? "0")-double.parse(widget.accountDetails.balance.toString())}"
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
                          // SizedBox(
                          //   width: 42.w,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: [
                          //       AutoSizeText(
                          //         (widget.accountDetails.accountNumber!
                          //                 .isNotEmpty)
                          //             ? " ${widget.accountDetails.bankName}"
                          //             : "",
                          //         style: const TextStyle(
                          //           fontFamily: "Work Sans",
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w400,
                          //           color: verificationCodeText,
                          //         ),
                          //       ),
                          //       SizedBox(height: 3.h),
                          //       AutoSizeText(
                          //         (widget.accountDetails.accountNumber!
                          //                 .isNotEmpty)
                          //             ? " ${widget.accountDetails.accountNumber}"
                          //             : "",
                          //         style: const TextStyle(
                          //           fontFamily: "Work Sans",
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w700,
                          //           color: verificationCodeText,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                    child: const AutoSizeText("Fund account",
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          AutoSizeText(
                            widget.accountDetails.bankName ?? "",
                            style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: verificationCodeText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "Account Name: ",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: verificationCodeText,
                            ),
                          ),
                          AutoSizeText(
                            widget.accountDetails.accountName ?? "",
                            style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: verificationCodeText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "Account No",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: verificationCodeText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.accountDetails.accountNumber! ==
                                  "") {
                                print('enter text');
                              } else {
                                print(
                                    widget.accountDetails.accountNumber!);
                                FlutterClipboard.copy(widget.accountDetails.accountNumber!).then((value) => print('copied'));
                                Get.snackbar('Account Number Copied',
                                    widget.accountDetails.accountNumber!,
                                    snackPosition: SnackPosition.BOTTOM,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.h,
                                      vertical: 2.h,
                                    ));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  widget.accountDetails.accountNumber ??
                                      "",
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
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
                      )
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
                      log("You clicked me");
                      if (_transactioncontroller.amountController.text != ""||_transactioncontroller.amountController.text.isNotEmpty) {
                        await _transactioncontroller.fundWallet(amount: _transactioncontroller.amountController.text);
                      }else{
                        Get.snackbar("Error","Fill in the form properly!", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                      }

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
                    children:const  [
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
    );
  }

  // Future<void> fundWallet(BuildContext context) async {
  //  progressIndicator(context);
  //   final response = await _transactioncontroller.fundWallet(_transactioncontroller.amountController.text);
  //   final jsonData = response?.data;
  //
  //   if (response?.statusCode == 200) {
  //     if (kDebugMode) {
  //       print(jsonData);
  //     }
  //     Get.back();
  //     final hostedLink = jsonData['data']['link'];
  //     Get.to(()=> FundWalletWebView(url: hostedLink,));
  //     await _launchURL('$hostedLink');
  //           if (!mounted) return;
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => PaymentScreen(
  //           paymentLink: '$hostedLink',
  //         ),
  //       ),
  //     );
  //     return;
  //   }
  //  Get.back();
  //   Get.snackbar("Error","${jsonData['data']['error']}");
  // }
  // &tx_ref=GysabJoy
  _launchURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      // mode: LaunchMode.inAppWebView,
    )) throw 'Could not launch $url';
  }
}

//http://fagopay-coreapi-development.herokuapp.com/api/v1/transaction/flutterwave-callback/13036849177539058365940857492822?status=cancelled
//http://fagopay-coreapi-development.herokuapp.com/api/v1/transaction/flutterwave-callback/12767497395428605230153359889408?status=completed&tx_ref=ZSvEKe0I&transaction_id=943609855