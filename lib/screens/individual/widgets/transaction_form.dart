// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class FagoTransactionForm extends StatefulWidget {
  final String? accountName;
  final String? selectedBankValue;
  final String page;
  final Widget cancelRoute;
  final TextEditingController? accountNumberController;
  final Function(String)? onChangedOfAccountNumberController;
  final String? verifiedReceipientUser;
  final VoidCallback? onSubmitForm;

  const FagoTransactionForm({
    Key? key,
    this.accountName,
    required this.page,
    required this.cancelRoute,
    this.selectedBankValue,
    this.accountNumberController,
    this.onChangedOfAccountNumberController,
    this.verifiedReceipientUser,
    this.onSubmitForm,
  }) : super(key: key);

  @override
  State<FagoTransactionForm> createState() => _FagoTransactionFormState();
}

class _FagoTransactionFormState extends State<FagoTransactionForm> {
  final _transactionsController = Get.find<TransactionController>();

  @override
  void dispose() {
    _transactionsController.accountNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formDescription;
    if (widget.page == 'bank') {
      formDescription = "Account";
    } else {
      formDescription = "Phone";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Enter Receipient $formDescription",
          style: const TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            controller: widget.accountNumberController,
            onChanged: widget.onChangedOfAccountNumberController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
              hintText: "Enter Recipient $formDescription",
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
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeText(
                  "Fullname",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                AutoSizeText(
                  '${widget.verifiedReceipientUser}',
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
          "Enter Amount",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: signInPlaceholder,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
              hintText: "Amount to send",
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
          "Narration",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 0.5.h,
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
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                      style: BorderStyle.solid)),
              hintText: "Enter Narration",
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
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.5.h),
          child: GestureDetector(
            onTap: widget.onSubmitForm,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AutoSizeText(
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
        )
      ],
    );
  }
}
