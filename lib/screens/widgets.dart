import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../controllers/bill_controller.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';
import 'authentication/widgets/auth_buttons.dart';
import 'constants/colors.dart';
import 'individual/bills/models/bill_post_model.dart';
import 'individual/bills/models/transaction_post_model.dart';
import 'individual/transactions/transaction_successful.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/loader.gif",
              width: 50,
              height: 50,
              fit: BoxFit.fitWidth,
            ),
          ]),
    );
  }
}

class PinCodeModal extends StatefulWidget {
  final String action;

  const PinCodeModal({
    super.key,
    required this.action,
  });

  @override
  State<PinCodeModal> createState() => _PinCodeModalState();
}

class _PinCodeModalState extends State<PinCodeModal> {
  final TextEditingController pincontroller = TextEditingController();
  final _billController = Get.find<BillController>();
  final _transactionController = Get.find<TransactionController>();
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();
  String _isLoading = "2";

  // @override
  // void dispose() {
  //   pincontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading == "2"
        ? Container(
            width: 100.w,
            height: 65.h,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.w,
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 1.5.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                              color: stepsColor,
                              border:
                                  Border.all(width: 1.5, color: stepsColor)),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: SizedBox(
                          width: 80.w,
                          child: const AutoSizeText(
                            "Input your transaction authentication code to confirm this transfer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: fagoPrimaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: PinCodeTextField(
                          controller: pincontroller,
                          appContext: context,
                          obscureText: true,
                          length: 4,
                          onChanged: (value) {},
                          keyboardType: TextInputType.none,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 45,
                            fieldWidth: 45,
                            activeFillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: GestureDetector(
                            onTap: () async {
                              if (pincontroller.text.length != 4 || pincontroller.text.isEmpty) {
                                Get.snackbar("Error","Kindly enter your pin", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                return;
                              }
                              if (_userController.userAccountDetails!.balance! < 1 || _userController.userAccountDetails!.balance! == 0) {
                                Get.snackbar("Error","Insufficient Wallet Balance", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                return;
                              }
                              if (_userController.switchedAccountType == 2 && int.parse(_companyController.company!.account!.balance.toString()) < 1 ||
                                  _userController.switchedAccountType == 2 && int.parse(_companyController.company!.account!.balance.toString()) == 0) {
                                Get.snackbar("Error","Insufficient Wallet Balance", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                return;
                              }
                              setState(() {
                                _isLoading = "1";
                              });
                              if (widget.action == "buy_airtime") {
                                await buyAirtime(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "buy_data") {
                                await buyData(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "buy_light") {
                                await buyElectricity(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "buy_internet") {
                                await buyInternet(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "tv") {
                                await buyCableSubscription(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "bank_transfer") {
                                await bankTransfer(context, pincontroller.text);
                                return;
                              }
                              if (widget.action == "fago_to_fago") {
                                await fagoToFagoTransfer(context, pincontroller.text);
                                return;
                              }
                            },
                            child: AuthButtons(text: "Pay", form: true)),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      )
                    ],
                  ),
                ),
                NumericKeyboard(
                  onKeyboardTap: ((text) {
                    setState(() {
                      pincontroller.text = pincontroller.text + text;
                    });
                  }),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textColor: black,
                  rightIcon: const Icon(
                    Icons.backspace_outlined,
                    size: 25,
                  ),
                  rightButtonFn: (() {
                    setState(() {
                      pincontroller.text = pincontroller.text
                          .substring(0, pincontroller.text.length - 1);
                    });
                  }),
                )
              ],
            ),
          )
        : _isLoading == "1"
            ? const Center(
                child: Loading(),
              )
            : Container();
  }

  Future<void> buyAirtime(BuildContext context, String pinCode) async {
    final response = await _billController.buyAirtime(pinCode);
    final jsonBody = response?.data;
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => TransactionSuccessful(
          amount: buyAirtimeFields.amount,
          number: buyAirtimeFields.getphone,
          action: 'airtime', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
        widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
        widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
        ),
      ));
      Get.snackbar("Success","Airtime Purchase Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }

  Future<void> buyData(BuildContext context, String pinCode) async {
    final response = await _billController.buyData(pinCode);
    final jsonBody = response?.data;
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: buyDataFields.amount,
            number: buyDataFields.getphone,
            action: 'data', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","DataBundle Purchase Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }

  Future<void> buyElectricity(BuildContext context, String pinCode) async {
    final response = await _billController.buyElectricity(pinCode);
    final jsonBody = response?.data;
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: buyElectricityFields.amount,
            number: buyElectricityFields.getphone,
            action: 'electricity', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","Electricity Purchase Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }

  Future<void> buyInternet(BuildContext context, String pinCode) async {
    final response = await _billController.buyInternet(pinCode);
    final jsonBody = response?.data;
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Internet Subscription Purchase Successful'),
      //   ),
      // );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: buyInternetFields.amount,
            number: buyInternetFields.billersCode,
            action: 'Internet Subscription', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","Internet Subscription Purchase Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }

  Future<void> buyCableSubscription(
      BuildContext context, String pinCode) async {
    final response = await _billController.buyCableSubscription(pinCode);
    final jsonBody = response?.data;
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: buyTvCableFields.amount,
            number: buyTvCableFields.billersCode,
            action: 'Cable Subscription', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","Cable Subscription Purchase Successful", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    }
  }

  Future<void> bankTransfer(BuildContext context, String pinCode) async {
    final response = await _transactionController.bankTransfer(pinCode);
    final jsonBody = response?.data;
    if (kDebugMode) {
      print(jsonBody);
    }
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: bankTransferFields.amount,
            number: bankTransferFields.accountNumber,
            action: 'Bank Transfer', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","Bank Transfer Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }

  Future<void> fagoToFagoTransfer(BuildContext context, String pinCode) async {
    final response = await _transactionController.fagoToFagoTransfer(pinCode);
    final jsonBody = response?.data;
    if (kDebugMode) {
      print(jsonBody);
    }
    if (response?.statusCode != 200) {
      setState(() {
        Navigator.of(context).pop();
      });
      Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    } else {
      setState(() {
        _isLoading = "1";
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => TransactionSuccessful(
            amount: bankTransferFields.amount,
            number: bankTransferFields.phoneNumber,
            action: 'Fago to Fago Transfer', transactionType: widget.action == "buy_airtime" ? "Airtime Purchase" : widget.action == "buy_data" ? "DataBundle Purchase" :
          widget.action == "buy_light" ? "Electricity Bill Purchase" : widget.action == "buy_internet" ? "Internet Purchase" : widget.action == "tv" ? "Cable Subscription" :
          widget.action == "bank_transfer" ? "Bank Transfer" : widget.action == "fago_to_fago" ? "Fago Transfer" : "",
          ),
        ),
      );
      Get.snackbar("Success","Transfer Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }
  }
}

// show modal sheet

Future showPinModal(
  BuildContext context,
  String action,
) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    // shape: const ShapeBorder().add(),
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (BuildContext context) {
      //
      return PinCodeModal(
        action: action,
      ); //whatever you're returning, does not have to be a Container
    },
  );
}
