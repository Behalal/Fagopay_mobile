import '../../../controllers/transaction_controller.dart';
import '../../functions.dart';
import '../bills/models/transaction_post_model.dart';
import 'confirm_transaction.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../widgets/account_details.dart';
import '../widgets/head_style_extra_pages.dart';
import '../widgets/transaction_form.dart';

class FagoToFago extends StatefulWidget {
  const FagoToFago({super.key});

  @override
  State<FagoToFago> createState() => _FagoToFagoState();
}

class _FagoToFagoState extends State<FagoToFago> {
  final _userController = Get.find<UserController>();
  final _transactionController = Get.find<TransactionController>();

  @override
  void dispose() {
    _transactionController.phoneController.clear();
    _transactionController.amountController.clear();
    _transactionController.dexcriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 5.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressStyle(
                  stage: 50,
                  pageName: "Fago P2P",
                  // backRoute: const DashboardHome(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                AccountDetails(
                  action: "spend",
                  accountDetails: _userController.userAccountDetails!,
                ),
                SizedBox(
                  height: 2.h,
                ),
                FagoTransactionForm(
                  page: "phone",
                  cancelRoute: const FagoToFago(),
                  onSubmitForm: () {
                    if (_transactionController.amountController.text != "" &&
                        _transactionController.phoneController.text != "") {
                      bankTransferFields.setPhoneNumber =
                          _transactionController.phoneController.text;
                      bankTransferFields.setAmount =
                          _transactionController.amountController.text;
                      bankTransferFields.setNarration =
                          _transactionController.dexcriptionController.text;
                      goToPage(
                        context,
                        ConfirmTransactions(
                          backRoute: const FagoToFago(),
                          action: 'fago_to_fago',
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
    );
  }
}
