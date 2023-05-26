// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/bills/models/bill_post_model.dart';
import 'package:fagopay/screens/individual/bills/models/transaction_post_model.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ConfirmTransactions extends StatelessWidget {
  final String? action;
  final Widget? backRoute;

  static DateTime now = DateTime.now();
  static DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(now);

  String transactionType = "";
  String toLabel = "";

  ConfirmTransactions({
    Key? key,
    this.action,
    this.backRoute,
    this.transactionType = "",
    this.toLabel = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = getDataType(action!);
    // print(data.amount);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 100,
                pageName: "Confirm Transfer",
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 90.w,
                decoration: const BoxDecoration(
                  color: fagoPrimaryColor,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                  child: const AutoSizeText(
                    "Transaction Overview",
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: white),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                decoration: DottedDecoration(
                    linePosition: LinePosition.bottom,
                    color: transactionKeys,
                    dash: const [3, 3]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        transactionType,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: transactionKeys),
                      ),
                      AutoSizeText(
                        (action == 'buy_airtime')
                            ? "Buy Airtime"
                            : ((action == 'buy_data')
                                ? "Data Purchase"
                                : ((action == 'buy_light')
                                    ? "Electricity Purchase"
                                    : ((action == 'buy_internet')
                                        ? "Internet Purchase"
                                        : action == "tv"
                                            ? "Cable Subscription"
                                            : action == "bank_transfer"
                                                ? "Bank Transfer"
                                                : action == "fago_to_fago"
                                                    ? "Fago to Fago Transfer"
                                                    : "Wema-2309234595"))),
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              if (action == 'buy_data' || action == 'buy_internet')
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Data Bundle",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: transactionKeys),
                        ),
                        SizedBox(
                          width: 30.w,
                          child: AutoSizeText(
                            "${data.name}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: fagoSecondaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              // SizedBox(
              //   height: 3.h,
              // ),
              Container(
                decoration: DottedDecoration(
                    linePosition: LinePosition.bottom,
                    color: transactionKeys,
                    dash: const [3, 3]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        "Amount",
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: transactionKeys),
                      ),
                      AutoSizeText(
                        (action == 'buy_airtime')
                            ? "${currencySymbol}${data.amount}"
                            : ((action == 'buy_data' ||
                                    action == "buy_internet")
                                ? "${currencySymbol}${data.amount}"
                                : ((action == 'buy_light')
                                    ? "${currencySymbol}${data.amount}"
                                    : action == 'tv'
                                        ? "${currencySymbol}${data.amount}"
                                        : action == 'bank_transfer'
                                            ? "${currencySymbol}${data.amount}"
                                            : action == 'fago_to_fago'
                                                ? "${currencySymbol}${data.amount}"
                                                : "")),
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor),
                      )
                    ],
                  ),
                ),
              ),
              if (action == "buy_light") ...[
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Meter Type",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: transactionKeys),
                        ),
                        AutoSizeText(
                          "${data.variationCode}",
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: fagoSecondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              if (action == "bank_transfer") ...[
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Account Name",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: transactionKeys),
                        ),
                        AutoSizeText(
                          "${data.accountName}",
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: fagoSecondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: 3.h,
              ),
              Container(
                decoration: DottedDecoration(
                    linePosition: LinePosition.bottom,
                    color: transactionKeys,
                    dash: const [3, 3]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        toLabel,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: transactionKeys),
                      ),
                      AutoSizeText(
                        (action == 'buy_airtime')
                            ? data.getphone
                            : ((action == 'buy_data' ||
                                    action == "buy_internet")
                                ? "${data.getphone}"
                                : ((action == 'buy_light')
                                    ? "${data.billersCode}"
                                    : action == 'tv'
                                        ? "${data.billersCode}"
                                        : action == 'bank_transfer'
                                            ? "${data.accountNumber}"
                                            : action == 'fago_to_fago'
                                                ? "${data.phoneNumber}"
                                                : "")),
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor),
                      )
                    ],
                  ),
                ),
              ),
              if (action == "bank_transfer" || action == "fago_to_fago") ...[
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Description",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: transactionKeys),
                        ),
                        AutoSizeText(
                          "${data.narration}",
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: fagoSecondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              // SizedBox(
              //   height: 3.h,
              // ),
              // if (action.contains('bank'))
              // Container(
              //   decoration: DottedDecoration(
              //       linePosition: LinePosition.bottom,
              //       color: transactionKeys,
              //       dash: const [3, 3]),
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: const [
              //         AutoSizeText(
              //           "Bank Account",
              //           style: TextStyle(
              //               fontFamily: "Work Sans",
              //               fontSize: 14,
              //               fontWeight: FontWeight.w400,
              //               color: transactionKeys),
              //         ),
              //         AutoSizeText(
              //           "United Bank of Africa",
              //           style: TextStyle(
              //             fontFamily: "Work Sans",
              //             fontSize: 16,
              //             fontWeight: FontWeight.w700,
              //             color: fagoSecondaryColor,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // if (action.contains('bank'))
              SizedBox(
                height: 3.h,
              ),
              // if (action.contains('bank'))
              Container(
                decoration: DottedDecoration(
                    linePosition: LinePosition.bottom,
                    color: transactionKeys,
                    dash: const [3, 3]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        "Transfer Fee",
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: transactionKeys),
                      ),
                      AutoSizeText(
                        "$currencySymbol 24.04",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      )
                    ],
                  ),
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
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        "Date",
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: transactionKeys),
                      ),
                      AutoSizeText(
                        formatted,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                child: GestureDetector(
                  onTap: () => showPinModal(context, action!),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        const AutoSizeText(
                          "Continue",
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
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: fagoSecondaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Cancel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w600,
                            color: fagoSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic getDataType(String action) {
    if (action == 'buy_airtime') {
      transactionType = "Transaction type";
      toLabel = "Phone Number";
      return buyAirtimeFields;
    }
    if (action == 'buy_data') {
      transactionType = "Transaction type";
      toLabel = "Phone Number";
      return buyDataFields;
    }
    if (action == 'buy_light') {
      transactionType = "Transaction type";
      toLabel = "Meter Number";
      return buyElectricityFields;
    }
    if (action == 'buy_internet') {
      transactionType = "Transaction type";
      toLabel = "Router Number";
      return buyInternetFields;
    }
    if (action == 'tv') {
      transactionType = "Transaction type";
      toLabel = "Card Number";
      return buyTvCableFields;
    }
    if (action == 'bank_transfer') {
      transactionType = "Transaction type";
      toLabel = "Account Number";
      return bankTransferFields;
    }
    if (action == 'fago_to_fago') {
      transactionType = "Transaction type";
      toLabel = "Phone Number";
      return bankTransferFields;
    }
  }
}
