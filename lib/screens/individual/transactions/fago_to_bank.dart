// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/models/bank_model.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/functions.dart';
import 'package:fagopay/screens/individual/bills/models/transaction_post_model.dart';
import 'package:fagopay/screens/individual/transactions/confirm_transaction.dart';
import 'package:fagopay/screens/widgets/account_details.dart';
import 'package:fagopay/screens/widgets/banks_dropdown.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/screens/widgets/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/company_controller.dart';
import '../../../controllers/user_controller.dart';

class FagoToBank extends StatefulWidget {
  final UserDetail userDetails;
  final dynamic accountDetails;

  const FagoToBank({
    Key? key,
    required this.userDetails,
    required this.accountDetails,
  }) : super(key: key);

  @override
  State<FagoToBank> createState() => _FagoToBankState();
}

class _FagoToBankState extends State<FagoToBank> {
  List<BankDetails> allBanks = [];
  String selectedBankValue = "";
  final _companyController = Get.find<CompanyController>();
  final _userController = Get.find<UserController>();
  final _transactionController = Get.find<TransactionController>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _transactionController.getBankDetailsLoadingState = null;
    });
    callBankProvider();
  }

  @override
  void dispose() {
    _transactionController.accountNumberController.clear();
    _transactionController.amountController.clear();
    _transactionController.dexcriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allBanks.isEmpty || allBanks == [] ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingWidget(
              color: fagoSecondaryColor,
              size: MediaQuery.of(context).size.height/6,
            ),
            Text("Please wait...", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: Colors.black),),
          ],
        ),
      ) : SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 50,
                pageName: "Bank Transfer",
                // backRoute: DashboardHome(
                //   userDetails: widget.userDetails,
                //   accountDetails: widget.accountDetails,
                // ),
              ),
              SizedBox(
                height: 2.h,
              ),
              AccountDetails(
                action: "spend",
                accountDetails:  _userController.switchedAccountType == 2 ? _companyController.company!.account! : _userController.userAccountDetails!,
              ),
              SizedBox(
                height: 2.h,
              ),
              SelectBank(
                bankdropdown: getBankList(allBanks),
                onChanged: (selectedValue) {
                  setState(() {
                    selectedBankValue = selectedValue!;
                    bankTransferFields.setBankId = selectedValue;
                  });
                },
                selectedValue: "",
              ),
              SizedBox(
                height: 2.h,
              ),
              GetBuilder<TransactionController>(
                  builder: (controller){
                return FagoTransactionForm(
                  accountName: widget.accountDetails.accountName,
                  selectedBankValue: selectedBankValue,
                  verifiedReceipientUser: _transactionController.verifiedReceipientUser,
                  onChangedOfAccountNumberController: (value) async {
                    // if (value.length > 10) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('The account number must be 10 digits!'),
                    //     ),
                    //   );
                    //   return;
                    // }
                    if (value.length >= 10) {
                      await _transactionController.getBankDetails(selectedBankValue, value);
                    }else if(value.isEmpty || value == ""){
                      log("message");
                      setState(() {
                        controller.getBankDetailsLoadingState = null;
                      });
                    }else if (value.length <= 9){
                      setState(() {
                        _transactionController.verifiedReceipientUser = "No user found";
                      });
                    }
                  },
                  page: "bank",
                  cancelRoute: FagoToBank(
                    userDetails: widget.userDetails,
                    accountDetails: widget.accountDetails,
                  ),
                  onSubmitForm: () {
                    // if (verifiedReceipientUser == "") {
                    //   Fluttertoast.showToast(
                    //     msg: "Receipient account is not verified!",
                    //     toastLength: Toast.LENGTH_LONG,
                    //     gravity: ToastGravity.TOP,
                    //     timeInSecForIosWeb: 2,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0,
                    //   );
                    //   return;
                    // }
                    if (bankTransferFields.bankId != "" &&
                        _transactionController.amountController.text !=
                            "" &&
                        _transactionController
                            .accountNumberController.text !=
                            "") {
                      bankTransferFields.setAccountName =
                      _transactionController.verifiedReceipientUser!;
                      bankTransferFields.setAccountNumber =
                          _transactionController
                              .accountNumberController.text;
                      bankTransferFields.setAmount =
                          _transactionController.amountController.text;
                      bankTransferFields.setNarration =
                          _transactionController.dexcriptionController.text;
                      goToPage(
                        context,
                        ConfirmTransactions(
                          backRoute: FagoToBank(
                            userDetails: widget.userDetails,
                            accountDetails: widget.accountDetails,
                          ),
                          action: 'bank_transfer',
                        ),
                      );
                      return;
                    }
                    Get.snackbar("Error","Enter the fields correctly!",);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void callBankProvider() async {
    final responseData = await _transactionController.getAllBanks();
    List<BankDetails> banks = responseData['data']
        .map<BankDetails>((bankDetail) => BankDetails.fromJson(bankDetail))
        .toList();
    setState(() {
      // isLoading = false;
      allBanks = banks;
    });
  }

  List<DropdownMenuItem<String>> getBankList(List<BankDetails> banks) {
    final allBanks = banks.map((bank) {
      return DropdownMenuItem(
        value: bank.bankCode,
        child: Text('${bank.bankName}'),
      );
    }).toList();

    List<DropdownMenuItem<String>> bankItems = [
      const DropdownMenuItem(value: "", child: Text("Select Bank")),
    ];

    bankItems.addAll(allBanks);

    return bankItems;
  }
}
