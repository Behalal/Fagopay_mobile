import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/business/customers/customer.dart';
import 'package:fagopay/screens/individual/widgets/business_form.dart';
import 'package:fagopay/screens/individual/widgets/business_warning.dart';
import 'package:fagopay/screens/individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressStyle(
                      stage: 50,
                      width: 4,
                      pageName: "My Supplies",
                      backRoute: const CustomerPage(),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const BusinessWarning(),
                    SizedBox(
                      height: 2.h,
                    ),
                    const BusinessForm(),
                    SizedBox(height: 4.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AuthButtons(
                          form: true, text: "Submit", route: null),
                    )
                  ]
              )
          )
      )
    );
  }
}
