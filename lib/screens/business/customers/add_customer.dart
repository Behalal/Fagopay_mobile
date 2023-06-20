// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fagopay/controllers/customers_controller.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/company_controller.dart';
import '../../../controllers/user_controller.dart';
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
  final _companyController = Get.find<CompanyController>();
  final _userController = Get.find<UserController>();


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
    // final progress = ProgressHUD.of(context);
    // progress?.dismiss();
    // print(_companyController.company!.id!);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w, bottom: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 50,
                width: 2,
                pageName: "Add Customers",
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
                  if (_customerController.nameController.text.isEmpty ||
                      _customerController.phoneController.text.isEmpty ||
                      _customerController.emailController.text.isEmpty ||
                      _customerController.addressController.text.isEmpty ||
                      _customerController.countryController.text.isEmpty ||
                      _customerController.stateController.text.isEmpty ||
                      _customerController.cityController.text.isEmpty) {
                    Get.snackbar("Error","Enter the fields correctly");
                  }else if(_customerController.phoneController.text.length < 11){
                    Get.snackbar("Error","Please enter a valid Phone Number");
                  }else{
                    await registerCustomer(context);
                  }
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
    );
  }

  Future<void> registerCustomer(BuildContext context) async {
    progressIndicator(context);
    final response = await _customerController.registerNewCustomer(
      companyId: _companyController.company!.id!,
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
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pop(context,false);
      _customerController.nameController.clear();
      _customerController.phoneController.clear();
      _customerController.emailController.clear();
      _customerController.addressController.clear();
      _customerController.countryController.clear();
      _customerController.stateController.clear();
      _customerController.cityController.clear();
      Get.snackbar("Success","Customer Detail Created Successfully");
      return;
    }else{
     _customerController.nameController.clear();
     _customerController.phoneController.clear();
     _customerController.emailController.clear();
     _customerController.addressController.clear();
     _customerController.countryController.clear();
     _customerController.stateController.clear();
     _customerController.cityController.clear();
      Get.back();
      Get.snackbar("Error","${jsonBody['data']['error']}");
    }
  }
}
