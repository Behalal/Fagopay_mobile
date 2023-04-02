import 'package:fagopay/models/bank_model.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/repository/controllers/login_controller_provider.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:fagopay/screens/individual/widgets/account_details.dart';
import 'package:fagopay/screens/individual/widgets/banks_dropdown.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/individual/widgets/transaction_form.dart';
import 'package:fagopay/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../repository/controllers/transaction_controller.dart';

class FagoToBank extends StatefulWidget {
  User userDetails;
  FagoToBank({super.key, required this.userDetails});

  @override
  State<FagoToBank> createState() => _FagoToBankState();
}

class _FagoToBankState extends State<FagoToBank> {
  late List<BankDetails>? allBanks;
  late List<DropdownMenuItem<String>> bankDropdown;
  late bool isLoading;
  late User userDetails;
  late String? accountName;
  late String? selectedBank;

  @override
  void initState() {
    accountName = null;
    isLoading = true;
    allBanks = [];
    bankDropdown = [];
    selectedBank = "";
    userDetails = widget.userDetails;
    super.initState();

    // Future.delayed(const Duration(seconds: 1000), () {
    //   callUserDetailsProvider();
    //   callBankProvider();
    // });
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
                      // ProgressStyle(
                      //   stage: 50,
                      //   pageName: "Bank Transfer",
                      //   backRoute: DashboardHome(userDetails: userFullDetails),
                      // ),
                      SizedBox(
                        height: 2.h,
                      ),
                      // AccountDetails(
                      //   action: "spend",
                      //   accountDetails: userDetails.accountDetails!,
                      // ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SelectBank(
                        bankdropdown: getBankList(allBanks!),
                        onChanged: (() {}),
                        selectedValue: "",
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      FagoTransactionForm(
                        accountName: accountName,
                        page: "bank",
                        cancelRoute: FagoToBank(userDetails: userDetails,),
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

  // void callBankProvider() {
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

  List<DropdownMenuItem<String>> getBankList(List<BankDetails> banks) {
    List<DropdownMenuItem<String>> bankItems = [];
    bankItems.add(
      const DropdownMenuItem(value: "", child: Text("Select Bank")),
    );

    for (var i = 0; i < banks.length; i++) {
      bankItems.add(
        DropdownMenuItem(
            value: banks[i].bankCode, child: Text(banks[i].bankName)),
      );
    }

    return bankItems;
  }
}
