// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/models/bank_model.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:fagopay/screens/individual/widgets/account_details.dart';
import 'package:fagopay/screens/individual/widgets/banks_dropdown.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/individual/widgets/transaction_form.dart';
import 'package:fagopay/screens/widgets.dart';

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
  bool isLoading = true;
  String? accountName = "";
  String selectedBank = "";
  final _transactionController = Get.find<TransactionController>();

  @override
  void initState() {
    super.initState();
    callBankProvider();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(
        body: (isLoading)
            ? const Loading()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProgressStyle(
                        stage: 50,
                        pageName: "Bank Transfer",
                        backRoute: DashboardHome(
                          userDetails: widget.userDetails,
                          accountDetails: widget.accountDetails,
                        ),
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
                          print(selectedValue);
                        },
                        selectedValue: "",
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      FagoTransactionForm(
                        accountName: widget.accountDetails.accountName,
                        page: "bank",
                        cancelRoute: FagoToBank(
                          userDetails: widget.userDetails,
                          accountDetails: widget.accountDetails,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // void verifyData(String bankaccount, String bankcode) {
  //   ref
  //       .read(transactionControllerProvider.notifier)
  //       .getAllBanks()
  //       .then((banksValue) {
  //     if (banksValue.code != null && banksValue.code != 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(banksValue.message!),
  //         ),
  //       );
  //     } else {
  //       // Future.delayed(const Duration(seconds: 4), () {
  //       setState(() {
  //         isLoading = false;
  //         allBanks = banksValue.banks!;
  //       });
  //       // });
  //     }
  //   });
  // }

  // void callUserDetailsProvider() {
  //   ref.read(loginControllerProvider.notifier).getUserDetails().then((value) {
  //     if (value.code != null && value.code == 401) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => const SignIn(),
  //         ),
  //       );
  //     } else if (value.code != null && value.code != 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(value.message!),
  //         ),
  //       );
  //     } else {
  //       setState(() {
  //         userDetails = value;
  //       });
  //     }
  //   });
  // }

  void callBankProvider() async {
    final responseData = await _transactionController.getAllBanks();
    List<BankDetails> banks = responseData['data']
        .map<BankDetails>((bankDetail) => BankDetails.fromJson(bankDetail))
        .toList();
    setState(() {
      isLoading = false;
      allBanks = banks;
    });
  }

  List<DropdownMenuItem<String>> getBankList(List<BankDetails> banks) {
    final allBanks = banks.map((bank) {
      return DropdownMenuItem(
          value: bank.bankCode, child: Text('${bank.bankName}'));
    }).toList();

    List<DropdownMenuItem<String>> bankItems = [
      const DropdownMenuItem(value: "", child: Text("Select Bank")),
      ...allBanks
    ];

    return bankItems;
  }
}
