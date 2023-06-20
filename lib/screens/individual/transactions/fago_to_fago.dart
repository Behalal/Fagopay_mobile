import 'dart:developer';

import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import '../../../controllers/transaction_controller.dart';
import '../../functions.dart';
import '../bills/models/transaction_post_model.dart';
import 'confirm_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/account_details.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../../widgets/transaction_form.dart';

class FagoToFago extends StatefulWidget {
  const FagoToFago({super.key});

  @override
  State<FagoToFago> createState() => _FagoToFagoState();
}

class _FagoToFagoState extends State<FagoToFago> {
  final _userController = Get.find<UserController>();
  final _transactionController = Get.find<TransactionController>();
  final _companyController = Get.find<CompanyController>();
  String verifiedReceipientUser = "";
  String userNotFound = "";


  @override
  void initState() {
    setState(() {
      _transactionController.onLookUpNumberLoadingState = null;
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
    return Scaffold(
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
                accountDetails: _userController.switchedAccountType == 2 ? _companyController.company!.account! : _userController.userAccountDetails!,
              ),
              SizedBox(
                height: 2.h,
              ),
              GetBuilder<TransactionController>(
                init: TransactionController(),
                  builder: (controller){
                return FagoTransactionForm(
                  page: "phone",
                  cancelRoute: const FagoToFago(),
                  verifiedReceipientUser: _transactionController.accountName,
                  onChangedOfAccountNumberController: (value) async {
                    setState(() {
                      if (value.length == 11) {
                        _transactionController.lookUpPhone(phoneNumber: _transactionController.phoneController.text.trim()).then((value){
                          setState(() {});
                        });}else if(value.isEmpty || value == ""){
                        log("message");
                        setState(() {
                          controller.onLookUpNumberLoadingState = null;
                        });
                      }else if (value.length <= 9){
                        setState(() {
                          _transactionController.accountName = "No user found";
                        });
                      }
                    });
                  },
                  onSubmitForm: () {
                    if (_transactionController.amountController.text != "" && _transactionController.phoneController.text != "") {
                      bankTransferFields.setPhoneNumber = _transactionController.phoneController.text;
                      bankTransferFields.setAmount = _transactionController.amountController.text;
                      bankTransferFields.setNarration = _transactionController.dexcriptionController.text;
                      goToPage(
                        context,
                        ConfirmTransactions(
                          backRoute: const FagoToFago(),
                          action: 'fago_to_fago',
                        ),
                      );
                      return;
                    }
                    Get.snackbar("Error","Enter the fields correctly!");
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

//   Future<void> getAccountDetailsByPhoneNumber(BuildContext context, String phoneNumber) async {
//     progressIndicator(context);
//     final response = await _transactionController.lookUpPhone(phoneNumber: phoneNumber);
//
//      if(response == null ){
//        _transactionController.userNameId(FagoAccUserStatus.notFound);
//        Get.back();
//        setState(() {
//          verifiedReceipientUser = 'user not found';
//        });
//      }
//      else{
//        _transactionController.userNameId(FagoAccUserStatus.found);
//        final customerDetail = response['data']['account_detail'];
//        if (customerDetail != "") {
//          Get.back();
//          setState(() {
//            verifiedReceipientUser = customerDetail['account_name'];
//          });
//          return;
//        }
//        Get.back();
//      }
//    // _transactionController.userNameId(1);
//     print(response);
//
//         //.then((value) {
//       // var res = jsonDecode(value.body);
//       //
//       // print('this value $value');
//       // print('this response $res');
//       // progress.dismiss();
//       // if(value  == null){
//       //   progress.dismiss();
//       // }
//
//
//       // progress.dismiss();
//       // setState(() {
//       //   verifiedReceipientUser = "";
//       // });
//    // });
// ///Toast
//     // Fluttertoast.showToast(
//     //   msg: "${response['data']['error']}",
//     //   toastLength: Toast.LENGTH_LONG,
//     //   gravity: ToastGravity.TOP,
//     //   timeInSecForIosWeb: 2,
//     //   backgroundColor: Colors.red,
//     //   textColor: Colors.white,
//     //   fontSize: 16.0,
//     // );
//   }
}
