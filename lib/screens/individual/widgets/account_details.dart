import 'package:auto_size_text/auto_size_text.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class AccountDetails extends StatefulWidget {
  String action;
  Map<String, dynamic>? accountDetails;
  AccountDetails(
      {super.key, required this.action, required this.accountDetails});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    //ref.watch();
    print(
        "acct balance is $currencySymbol ${widget.accountDetails!['balance']}.00");
    return Column(
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
                  AutoSizeText(
                    "You can still ${widget.action}",
                    style: const TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        (widget.accountDetails!.isNotEmpty &&
                                widget.accountDetails != null)
                            ? "Wema"
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
                            ? "2346389056"
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
    );
  }
}
