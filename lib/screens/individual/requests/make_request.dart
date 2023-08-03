import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/request_money_controller.dart';
import '../../../controllers/transaction_controller.dart';
import '../../authentication/recover_password_otp_screen.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';

class MakeRequest extends StatefulWidget {
  const MakeRequest({super.key});

  @override
  State<MakeRequest> createState() => _MakeRequestState();
}

class _MakeRequestState extends State<MakeRequest> {
  final _moneyRequest = Get.put(RequestMoney());
  final _transactionController = Get.find<TransactionController>();


  @override
  void initState() {
    setState(() {
      _moneyRequest.onLookUpNumberLoadingState = null;
      _moneyRequest.onLookUpNumberErrorState = null;
    });
    super.initState();
  }

  @override
  void dispose() {
    _transactionController.phoneController.clear();
    _transactionController.amountController.clear();
    _transactionController.dexcriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestMoney>(
      init: RequestMoney(),
        builder: (controller){
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
                  pageName: "Request Money",
                  // backRoute: RequestHome(),
                ),
                SizedBox(
                  height: 4.h,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "User must have an account with fagopay, Transactions charge will be deducted from the senders account",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                ),
                SizedBox(
                  height: 3.h,
                ),
                // FagoTransactionForm(page: "", cancelRoute: const RequestHome()),
                // ignore: prefer_const_constructors
                AutoSizeText(
                  "Request From",
                  style: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    readOnly: _moneyRequest.onLookUpNumberLoadingState == true ? true: false,
                    onChanged: (value) {
                      setState(() {
                        if (value.length == 11) {
                          _moneyRequest.lookUpPhone(phoneNumber: _transactionController.phoneController.text.trim()).then((value){
                            setState(() {

                            });
                          });
                        }
                      });
                    },
                    controller: _transactionController.phoneController,
                    keyboardType: TextInputType.phone,
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
                      hintText: "Enter User's Phone",
                      hintStyle: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      suffix: _moneyRequest.onLookUpNumberLoadingState == true && _moneyRequest.onLookUpNumberErrorState == false ?
                      const LoadingWidget(
                        color: fagoSecondaryColor,
                        size: 18,
                      ):const SizedBox(),
                    ),
                  ),
                ),
                SizedBox(height: 0.2.h),
                _moneyRequest.onLookUpNumberLoadingState == false && _moneyRequest.onLookUpNumberErrorState == false ||
                    _moneyRequest.onLookUpNumberLoadingState == false && _moneyRequest.onLookUpNumberErrorState == true ?
                Container(width: 90.w,
                  decoration: const BoxDecoration(
                      color: fagoSecondaryColorWithOpacity10,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 1.h),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(image: AssetImage("assets/images/account.png")),
                        SizedBox(width: 2.w,),
                        AutoSizeText(_moneyRequest.accountName,
                          style: const TextStyle(fontFamily: "Work Sans",
                            fontSize: 14, fontWeight: FontWeight.w500, color: welcomeText,),
                        )
                      ],
                    ),
                  ),
                ) : const SizedBox(),
                SizedBox(height: 4.h,),
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
                  height: 1.5.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _transactionController.amountController,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const AutoSizeText(
                  "Narrate your need",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    controller:
                    _transactionController.dexcriptionController,
                    style: const TextStyle(
                        fontFamily: "work Sans",
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
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      hintText: "Enter Narration",
                      hintStyle: const TextStyle(
                        fontFamily: "work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 0.5.h),
                  child: GestureDetector(
                    onTap: () async {
                      if (_transactionController
                          .dexcriptionController.text !=
                          "" &&
                          _transactionController.amountController.text !=
                              "" &&
                          _transactionController.phoneController.text !=
                              "") {
                        await _transactionController.requestMoney(
                            _transactionController.phoneController.text,
                            _transactionController.amountController.text,
                            _transactionController.dexcriptionController.text, context);
                        return;
                      }
                      Get.snackbar("Error","Enter the fields correctly",colorText: Colors.white, backgroundColor: fagoSecondaryColor);
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
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
