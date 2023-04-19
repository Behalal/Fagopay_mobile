// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/models/bank_model.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/functions.dart';
import 'package:fagopay/screens/individual/bills/models/transaction_post_model.dart';
import 'package:fagopay/screens/individual/transactions/confirm_transaction.dart';
import 'package:fagopay/screens/widgets/account_details.dart';
import 'package:fagopay/screens/widgets/banks_dropdown.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FagoToBank extends StatefulWidget {
  final User userDetails;
  final AccountDetail accountDetails;

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
  List<DropdownMenuItem<String>> bankDropdown = [];
  String selectedBankValue = "";
  final _transactionController = Get.find<TransactionController>();
  String verifiedReceipientUser = "";

  @override
  void initState() {
    super.initState();
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
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body:
                // (isLoading)
                //     ? const Loading():
                SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
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
                      accountDetails: widget.accountDetails,
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
                    FagoTransactionForm(
                      accountName: widget.accountDetails.accountName,
                      selectedBankValue: selectedBankValue,
                      verifiedReceipientUser: verifiedReceipientUser,
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
                          await getBankDetails(
                              context, selectedBankValue, value);
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
                              verifiedReceipientUser;
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
                        Fluttertoast.showToast(
                          msg: "Enter the fields correctly!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
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

  Future<void> getBankDetails(
      BuildContext context, String bankCode, String accountNumber) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response =
        await _transactionController.getBankDetails(bankCode, accountNumber);
    final jsonBodyData = jsonDecode(response.body);
    final customerDetail = jsonBodyData['data']['account_name'];
    if (response.statusCode == 200) {
      progress.dismiss();
      setState(() {
        verifiedReceipientUser = customerDetail;
      });
      return;
    }
    progress.dismiss();
    setState(() {
      verifiedReceipientUser = "";
    });
    Fluttertoast.showToast(
      msg: "${jsonBodyData['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
