// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fagopay/controllers/customers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../widgets/business_form.dart';
import '../../widgets/business_warning.dart';
import '../../widgets/head_style_extra_pages.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _customerController = Get.find<CustomerController>();

  @override
  void dispose() {
    _customerController.nameController.clear();
    _customerController.phoneController.clear();
    _customerController.emailController.clear();
    _customerController.countryController.clear();
    _customerController.stateController.clear();
    _customerController.cityController.clear();
    _customerController.addressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProgressStyle(
                      stage: 50,
                      width: 4,
                      pageName: "My Customers",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const BusinessWarning(),
                    SizedBox(
                      height: 3.h,
                    ),
                    const BusinessForm(),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_customerController.nameController.text != "" &&
                            _customerController.phoneController.text != "" &&
                            _customerController.emailController.text != "" &&
                            _customerController.addressController.text != "" &&
                            _customerController.countryController.text != "" &&
                            _customerController.stateController.text != "" &&
                            _customerController.cityController.text != "") {
                          await registerCustomer(context);
                          return;
                        }
                        Fluttertoast.showToast(
                          msg: "Enter the fields correctly",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: AuthButtons(
                            form: true, text: "Submit", route: null),
                      ),
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

  Future<void> registerCustomer(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _customerController.registerNewCustomer(
      name: _customerController.nameController.text,
      phoneNumber: _customerController.phoneController.text,
      email: _customerController.emailController.text,
      address: _customerController.addressController.text,
      countryId: _customerController.countryController.text,
      stateId: _customerController.stateController.text,
      cityId: _customerController.cityController.text,
    );
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      progress.dismiss();
      if (!mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Customer Detail Created Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    progress.dismiss();
    Fluttertoast.showToast(
      msg: "${jsonBody['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
